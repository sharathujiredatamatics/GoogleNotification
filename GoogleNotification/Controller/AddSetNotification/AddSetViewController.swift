//
//  AddSetViewController.swift
//  GoogleNotification
//
//  Created by Datamatics on 16/03/21.
//  Copyright © 2021 Datamatics. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications
class AddSetViewController: UIViewController {
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var datePickerOutlet: UIDatePicker!
    let managerContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        gestureHandler()
        let yesterdayDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        datePickerOutlet.minimumDate = yesterdayDate
    }
    func gestureHandler(){
        let hideGesture = UITapGestureRecognizer(target: self, action:  #selector(self.hideAction))
        self.mainView.addGestureRecognizer(hideGesture)
    }
    @objc func hideAction(sender : UISwipeGestureRecognizer) {
        self.dismiss(animated: false, completion: nil)
        
    }
    @IBAction func datePicker(_ sender: UIDatePicker) {
        
    }
    
    @IBAction func saveNotification(_ sender: UIButton) {
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
    
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let datestring = dateFormatter.string(from: datePickerOutlet.date)
//        let selectedDate = dateFormatter.date(from : datestring)
//        
        entity.date = datestring
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
                self.dismiss(animated: false, completion: nil)
                StorageClass.shared.name = ""
                StorageClass.shared.country = ""
                StorageClass.shared.locationDescription = ""
                StorageClass.shared.latitude = 0
                StorageClass.shared.longitude = 0
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

    func setNotification(title : String, subTitle : String, body: String, year : Int, month : Int, day : Int, hour : Int,minute : Int, image : Data){
        var dateComponent = DateComponents()
        dateComponent.year = year
        dateComponent.month = month
        dateComponent.day = day
        dateComponent.hour = hour
        dateComponent.minute = minute
        let content = UNMutableNotificationContent()
        let open = UNNotificationAction(identifier: "open", title: "Show Location", options: UNNotificationActionOptions.foreground)
        let details = UNNotificationAction(identifier: "details", title: "Details", options: UNNotificationActionOptions.destructive)
        let category = UNNotificationCategory(identifier: "Identifier\(StorageClass.shared.identifier)", actions: [open, details], intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([category])
        content.title = title
        content.subtitle = subTitle
        content.body = body
        StorageClass.shared.badgeCount = StorageClass.shared.badgeCount + 1
        content.badge = StorageClass.shared.badgeCount as NSNumber
        content.categoryIdentifier = "Identifier\(StorageClass.shared.identifier)"
        content.sound = UNNotificationSound.default
    
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: false)
        
        let request = UNNotificationRequest(identifier: "Identifier\(StorageClass.shared.identifier)", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void)
    {
        if response.actionIdentifier == "open"
        {
            let showOnMap = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
            
            UIApplication.shared.applicationIconBadgeNumber -= 1
            present(showOnMap, animated: true)
        }
        else if response.actionIdentifier == "details"{
            UIApplication.shared.applicationIconBadgeNumber -= 1
            print ("Did not open notification")
        }
        else
        {
//            let readNotification = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ReadNotificationViewController") as! ReadNotificationViewController
//            readNotification.nTitle = content.title
//            readNotification.nSubTitle = content.subtitle
//            readNotification.nBody = content.body
//            UIApplication.shared.applicationIconBadgeNumber -= 1
//            present(readNotification, animated: true)
        }
        
        completionHandler()
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert,.sound,.badge])
        UIApplication.shared.applicationIconBadgeNumber += 1
    }
    
    
    
    
    
    
}
