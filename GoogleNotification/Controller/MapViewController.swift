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
class MapViewController: UIViewController {
    @IBOutlet weak var serachLocation: UISearchBar!
    let locationManager = CLLocationManager()
    var resultSearchController : UISearchController? = nil
    @IBOutlet weak var searchLocationButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    var selectedPin: MKPlacemark? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        locationmanager()
        locationSearch()
        searchBarAction()
        
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in})
        UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
        UIApplication.shared.applicationIconBadgeNumber = 0
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        
        
    }
    
    
    @objc func willEnterForeground() {
        UIApplication.shared.applicationIconBadgeNumber = 0
        StorageClass.shared.badgeCount = 0
    }
    
    
    
    
    func locationmanager(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        locationManager.startUpdatingLocation()
        mapView.showsUserLocation = true
    }
    func locationSearch(){
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTable") as! LocationSearchTable
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        
        resultSearchController?.searchResultsUpdater = locationSearchTable
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        
        locationSearchTable.mapView = mapView
        locationSearchTable.handleMapSearchDelegate = self
    }
    func searchBarAction(){
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        navigationItem.searchController = resultSearchController
    }
    @IBAction func addSetNotification(_ sender: UIButton) {
        if StorageClass.shared.name == ""{
           alert(tittle: "Alert", message: "Already SetUp Notification or Empty Place Data")
        }
        else{
        let addSetViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddSetViewController") as! AddSetViewController
        addSetViewController.modalPresentationStyle = .overCurrentContext
        addSetViewController.modalTransitionStyle = .coverVertical
        present(addSetViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func viewPlace(_ sender: UIButton) {
        let displayPlaceViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DisplayPlaceViewController") as! DisplayPlaceViewController
        show(displayPlaceViewController, sender: nil)
    }
}

