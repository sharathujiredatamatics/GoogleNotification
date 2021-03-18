//
//  SaveNotificationAction.swift
//  GoogleNotification
//
//  Created by Datamatics on 17/03/21.
//  Copyright © 2021 Datamatics. All rights reserved.
//

import UIKit
import UserNotifications
extension MapViewController : UNUserNotificationCenterDelegate {
    func setNotification(title : String, subTitle : String, body: String, year : Int, month : Int, day : Int, hour : Int,minute : Int, image : Data){
        var dateComponent = DateComponents()
        dateComponent.year = year
        dateComponent.month = month
        dateComponent.day = day
        dateComponent.hour = hour
        dateComponent.minute = minute
        let identifier = "Identifier\(StorageClass.shared.identifier)"
        let content = UNMutableNotificationContent()
        let open = UNNotificationAction(identifier: "open", title: "Show Location", options: UNNotificationActionOptions.foreground)
        let details = UNNotificationAction(identifier: "details", title: "Details", options: UNNotificationActionOptions.foreground)
        
        let category = UNNotificationCategory(identifier: identifier, actions: [open, details], intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([category])
        content.title = title
        content.subtitle = subTitle
        content.body = body
        StorageClass.shared.badgeCount = StorageClass.shared.badgeCount + 1
        content.badge = StorageClass.shared.badgeCount as NSNumber
        content.categoryIdentifier = identifier
        content.sound = UNNotificationSound.default
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: false)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void)
    {
        if response.actionIdentifier == "open"
        {
            let showOnMap = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DisplayPlaceOnMapViewController") as! DisplayPlaceOnMapViewController
            showOnMap.identifier = response.notification.request.identifier
            present(showOnMap, animated: true)
            UIApplication.shared.applicationIconBadgeNumber -= 1
        }
        else if response.actionIdentifier == "details"{
            let displayPlaceViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DisplayPlaceViewController") as! DisplayPlaceViewController
            present(displayPlaceViewController, animated: true)
            UIApplication.shared.applicationIconBadgeNumber -= 1
            
        }
        else
        {
            let displayPlaceViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DisplayPlaceViewController") as! DisplayPlaceViewController
            present(displayPlaceViewController, animated: true)
            UIApplication.shared.applicationIconBadgeNumber -= 1
        }
        
        completionHandler()
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert,.sound,.badge])
        UIApplication.shared.applicationIconBadgeNumber += 1
    }
};
