//
//  DisplayPlaceOnMapViewControllerExtension.swift
//  GoogleNotification
//
//  Created by Datamatics on 18/03/21.
//  Copyright © 2021 Datamatics. All rights reserved.
//

import UIKit
import CoreData
import MapKit
extension DisplayPlaceOnMapViewController{
    func setRegionFromNotification(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Location")
        do {
            let results = try managerContext.fetch(request)
            placeData = results as! [NSManagedObject]
            
            // Retrieving data 1 by 1
            for place in placeData {
                let identity = place.value(forKey: "identifier") as! String
                if identity == identifier{
                    let name = place.value(forKey: "name") as! String
                    let country = place.value(forKey: "country") as! String
                    let lat = place.value(forKey: "latitude") as! Double
                    let long = place.value(forKey: "longitude") as! Double
                    let annotation = MKPointAnnotation()
                    let location = CLLocationCoordinate2DMake(lat, long)
                    let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                    let region = MKCoordinateRegion(center: location, span: span)
                    annotation.coordinate = location
                    annotation.title = name
                    annotation.subtitle = country
                    displayMap.addAnnotation(annotation)
                    displayMap.setRegion(region, animated: true)
                    break
                }
                
            }
            // error occured
        } catch {
            print("Caught an error: \(error)")
        }
    }
}
