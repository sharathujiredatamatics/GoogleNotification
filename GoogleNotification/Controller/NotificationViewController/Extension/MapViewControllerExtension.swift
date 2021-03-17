//
//  MapViewControllerExtension.swift
//  GoogleNotification
//
//  Created by Datamatics on 15/03/21.
//  Copyright © 2021 Datamatics. All rights reserved.
//

import Foundation
import MapKit
import CoreData
extension MapViewController : HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark){
        // cache the pin
        selectedPin = placemark
        // clear existing pins
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        print(placemark.coordinate)
        annotation.title = placemark.name
        if let city = placemark.locality,
            let state = placemark.administrativeArea {
            annotation.subtitle = "\(city) \(state)"
        }
        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: placemark.coordinate, span: span)
        mapView.setRegion(region, animated: true)
        
        let mapSnapshotOptions = MKMapSnapshotter.Options()
        mapSnapshotOptions.region = region
        mapSnapshotOptions.scale = UIScreen.main.scale
        mapSnapshotOptions.size = CGSize(width: 200, height: 200)
        mapSnapshotOptions.showsBuildings = true
        mapSnapshotOptions.showsPointsOfInterest = true
        let snapShotter = MKMapSnapshotter(options: mapSnapshotOptions)
        snapShotter.start { (snapshot:MKMapSnapshotter.Snapshot?, error: Error?) in
            let image = (snapshot?.image)!
            StorageClass.shared.image = image.jpegData(compressionQuality: 1.0)!
        }
        StorageClass.shared.name = (selectedPin?.name)!
        StorageClass.shared.country = (selectedPin?.country)!
        StorageClass.shared.locationDescription = (selectedPin?.description)!
        StorageClass.shared.latitude = (selectedPin?.coordinate.latitude)!
        StorageClass.shared.longitude = (selectedPin?.coordinate.longitude)!
        
    }
    func alert(tittle:String, message:String) {
        let alert = UIAlertController(title: tittle, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    func addSetButtonAction(){
        if StorageClass.shared.name == ""{
            alert(tittle: "Alert", message: "Already SetUp Notification or Empty Place Data")
        }
        else{
            datePickerOutlet.frame = CGRect(x: 0, y: 15, width: 270, height: 200)
            let alertController = UIAlertController(title: "\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .alert)
            alertController.view.addSubview(datePickerOutlet)
            let selectAction = UIAlertAction(title: "Ok", style: .default, handler: { _ in
                self.saveNotificationButton()
            })
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(selectAction)
            alertController.addAction(cancelAction)
            present(alertController, animated: true)
        }
    }
    func viewPlaceButtonAction(){
        let displayPlaceViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DisplayPlaceViewController") as! DisplayPlaceViewController
        present(displayPlaceViewController, animated: true)
    }
}
