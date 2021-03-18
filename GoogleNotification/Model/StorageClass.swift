//
//  StorageClass.swift
//  GoogleNotification
//
//  Created by Datamatics on 16/03/21.
//  Copyright © 2021 Datamatics. All rights reserved.
//

import UIKit
import MapKit
import CoreData
struct Place {
    var name: String
    var country : String
    var locationDescription : String
    var lat : Double
    var long : Double
    var image : Data
    var date : Date
    var identifier : String
    init?( name: String, country: String, locationDescription: String, lat: Double ,long: Double, image : Data, date : Date, identifier : String) {
        self.name = name
        self.country = country
        self.locationDescription = locationDescription
        self.lat = lat
        self.long = long
        self.image = image
        self.date = date
        self.identifier = identifier
    }
}

class StorageClass{
    static let shared = StorageClass()
    init() {
    }
    var name = String()
    var country = String()
    var locationDescription = String()
    var latitude = Double()
    var longitude = Double()
    var image = Data()
    var date = Date()
    public var badgeCount = UIApplication.shared.applicationIconBadgeNumber
    var identifier = Int()
    var searchedPlace = [Place]()
    var placesData = [NSManagedObject]()
    let managerContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    func fetchPlaceData(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Location")
        do {
            let results = try managerContext.fetch(request)
            placesData = results as! [NSManagedObject]
            identifier = placesData.count
        }catch {
            print("Caught an error: \(error)")
        }
        
    }
}
