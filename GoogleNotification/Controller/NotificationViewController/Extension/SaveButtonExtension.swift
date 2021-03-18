//
//  AddSetViewControllerExtension.swift
//  GoogleNotification
//
//  Created by Datamatics on 17/03/21.
//  Copyright © 2021 Datamatics. All rights reserved.
//

import UIKit
extension MapViewController{
    func saveNotificationButton(){
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.persistentContainer.viewContext
        let entity = Location(context: context)
        entity.name = StorageClass.shared.name
        entity.country = StorageClass.shared.country
        entity.locationDescription = StorageClass.shared.locationDescription
        entity.latitude = StorageClass.shared.latitude
        entity.longitude = StorageClass.shared.longitude
        entity.image = StorageClass.shared.image
        entity.date = StorageClass.shared.date
        entity.identifier = "Identifier\(StorageClass.shared.identifier)"
        entity.date = datePickerOutlet.date
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.dateFormat = "yyyy"
        let year: String = dateFormatter.string(from: self.datePickerOutlet.date)
        dateFormatter.dateFormat = "MM"
        let month: String = dateFormatter.string(from: self.datePickerOutlet.date)
        dateFormatter.dateFormat = "dd"
        let day: String = dateFormatter.string(from: self.datePickerOutlet.date)
        dateFormatter.dateFormat = "HH"
        let hour: String = dateFormatter.string(from: self.datePickerOutlet.date)
        dateFormatter.dateFormat = "mm"
        let min: String = dateFormatter.string(from: self.datePickerOutlet.date)
        
        setNotification(title : "Meeting Notification", subTitle : StorageClass.shared.name, body: StorageClass.shared.locationDescription, year : Int(year)!, month : Int(month)!, day : Int(day)!, hour : Int(hour)!, minute : Int(min)!, image: StorageClass.shared.image)
        do
        {
            try context.save()
            print("Details Stored Sucessfully")
            let myAlert = UIAlertController(title:"Alert", message:"Add And Set Notification Sucessfull", preferredStyle:.alert);
            let acceptAction = UIAlertAction(title: "OK", style: .default) { (_) -> Void in
                
                StorageClass.shared.name = ""
                StorageClass.shared.country = ""
                StorageClass.shared.locationDescription = ""
                StorageClass.shared.latitude = 0
                StorageClass.shared.longitude = 0
                StorageClass.shared.identifier = StorageClass.shared.identifier + 1
            }
            myAlert.addAction(acceptAction)
            present(myAlert, animated: true, completion: nil)
        }
        catch
        {
            let Fetcherror = error as NSError
            print("error", Fetcherror.localizedDescription)
        }
    }
}
