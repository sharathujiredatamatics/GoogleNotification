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
    override func viewDidLoad() {
        super.viewDidLoad()
        locationmanager()
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in})
        UNUserNotificationCenter.current().delegate = self
        StorageClass.shared.fetchPlaceData()
        self.searchPlace.delegate = self
        searchPlaceTableView.isHidden = true
        UIApplication.shared.applicationIconBadgeNumber = 0
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(loadMapView), name: NSNotification.Name(rawValue: "loadMapView"), object: nil)
    }
    
    @objc func willEnterForeground() {
        UIApplication.shared.applicationIconBadgeNumber = 0
        StorageClass.shared.badgeCount = 0
    }
    @objc func loadMapView(notification: NSNotification){
        
    }
    @IBAction func addSetNotification(_ sender: UIButton) {
        addSetButtonAction()
    }
    @IBAction func viewPlace(_ sender: UIButton) {
        viewPlaceButtonAction()
    }
}
