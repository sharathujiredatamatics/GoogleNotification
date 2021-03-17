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
    var date : String
    init?( name: String, country: String, locationDescription: String, lat: Double ,long: Double, image : Data, date : String) {
        self.name = name
        self.country = country
        self.locationDescription = locationDescription
        self.lat = lat
        self.long = long
        self.image = image
        self.date = date
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
    var date = String()
    public var badgeCount = UIApplication.shared.applicationIconBadgeNumber
    var identifier = Int()
    var searchedPlace = [Place]()
    let managerContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
}
