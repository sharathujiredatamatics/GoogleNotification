//
//  ViewController.swift
//  GoogleNotification
//
//  Created by Datamatics on 15/03/21.
//  Copyright © 2021 Datamatics. All rights reserved.
//

import UIKit
import MapKit
import UserNotifications
protocol HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark)
}
class MapViewController: UIViewController{
    @IBOutlet weak var searchPlaceTableView: UITableView!
    @IBOutlet weak var placeTableHeight: NSLayoutConstraint!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var searchPlace: UISearchBar!
    let locationManager = CLLocationManager()
    var selectedPin: MKPlacemark? = nil
    var matchingItems : [MKMapItem] = []
    let datePickerOutlet: UIDatePicker = UIDatePicker()
    let managerContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let content = UNMutableNotificationContent()
    override func viewDidLoad() {
        super.viewDidLoad()
        locationmanager()
        self.searchPlace.delegate = self
        searchPlaceTableView.isHidden = true
        UNUserNotificationCenter.current().delegate = self
        UIApplication.shared.applicationIconBadgeNumber = 0
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    @objc func willEnterForeground() {
        UIApplication.shared.applicationIconBadgeNumber = 0
        StorageClass.shared.badgeCount = 0
    }
    @IBAction func addSetNotification(_ sender: UIButton) {
        addSetButtonAction()
    }
    @IBAction func viewPlace(_ sender: UIButton) {
        viewPlaceButtonAction()
    }
    
    /*func setRegionFromNotification(){
     let location = CLLocationCoordinate2DMake(pin.lat, pin.long)
     let region = MKCoordinateRegionMake(location, span)
     mapView.setRegion(region, animated: true)
     annotation.coordinate = location
     annotation.title = pin.name
     annotation.subtitle = "It is \(String(describing: pin.openNow)) now"
     }*/
}

