//
//  PlaceSearchControl.swift
//  GoogleNotification
//
//  Created by Datamatics on 17/03/21.
//  Copyright © 2021 Datamatics. All rights reserved.
//

import UIKit
import MapKit
extension MapViewController :  UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            matchingItems.removeAll()
            self.searchPlaceTableView.isHidden = true
            self.searchPlaceTableView.reloadData()
        }
        else{
            guard let mapView = mapView,
                let searchBarText = searchBar.text else { return }
            let request = MKLocalSearch.Request()
            request.naturalLanguageQuery = searchBarText
            request.region = mapView.region
            let search = MKLocalSearch(request: request)
            search.start { response, _ in
                guard let response = response else {
                    return
                }
                self.matchingItems = response.mapItems
                self.searchPlaceTableView.isHidden = false
                self.searchPlaceTableView.reloadData()
            }
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        matchingItems.removeAll()
        self.searchPlaceTableView.isHidden = true
        self.searchPlaceTableView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if searchBar.text!.isEmpty {
            matchingItems.removeAll()
            self.searchPlaceTableView.isHidden = true
            self.searchPlaceTableView.reloadData()
        }
        else{
            self.searchPlaceTableView.reloadData()
        }
    }
}
