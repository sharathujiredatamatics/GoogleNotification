//
//  LocationSearchTableExtension.swift
//  GoogleNotification
//
//  Created by Datamatics on 15/03/21.
//  Copyright © 2021 Datamatics. All rights reserved.
//

import UIKit
import MapKit
extension MapViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingItems.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        if searchPlace.text == ""{
            searchPlaceTableView.isHidden = true
        }
        else{
            searchPlaceTableView.isHidden = false
            let selectedItem = matchingItems[indexPath.row].placemark
            cell.textLabel?.text = selectedItem.name
            let address = "\(selectedItem.thoroughfare ?? ""), \(selectedItem.locality ?? ""), \(selectedItem.subLocality ?? ""), \(selectedItem.administrativeArea ?? ""), \(selectedItem.postalCode ?? ""), \(selectedItem.country ?? "")"
            cell.detailTextLabel?.text = address
            self.placeTableHeight?.constant = self.searchPlaceTableView.contentSize.height
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = matchingItems[indexPath.row].placemark
        dropPinZoomIn(placemark: selectedItem)
        tableView.isHidden = true
        searchPlace.text = nil
    }
}
