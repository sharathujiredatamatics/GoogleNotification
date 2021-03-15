//
//  ViewController.swift
//  GoogleNotification
//
//  Created by Datamatics on 15/03/21.
//  Copyright © 2021 Datamatics. All rights reserved.
//

import UIKit
import MapKit
protocol HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark)
}
class MapViewController: UIViewController {
    @IBOutlet weak var serachLocation: UISearchBar!
    let locationManager = CLLocationManager()
    var resultSearchController : UISearchController? = nil
    @IBOutlet weak var searchLocationButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addLocation: UIButton!
    @IBOutlet weak var sheduleNotification: UIButton!
    var selectedPin: MKPlacemark? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        locationmanager()
        locationSearch()
        searchBarAction()
        
    }
    func locationmanager(){
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
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

}

