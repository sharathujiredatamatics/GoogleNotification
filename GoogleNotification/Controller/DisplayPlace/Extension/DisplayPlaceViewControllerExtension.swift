//
//  DisplayPlaceViewControllerExtension.swift
//  GoogleNotification
//
//  Created by Datamatics on 17/03/21.
//  Copyright © 2021 Datamatics. All rights reserved.
//

import UIKit
import CoreData
// DisplayPlaceViewController to manage all notification saved.
extension DisplayPlaceViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PlaceTableViewCell
        cell.name.text = placeData[indexPath.row].name
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let datestring = dateFormatter.string(from: placeData[indexPath.row].date)
        cell.date.text = datestring
        
        cell.discription.text = placeData[indexPath.row].locationDescription
        cell.country.text = placeData[indexPath.row].country
        cell.placeImage.image = UIImage(data: placeData[indexPath.row].image)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            // Delete the row from the data source
            managerContext.delete(placesData[indexPath.row])
            do{
                try managerContext.save()
            }catch{
                print("Error :")
            }
            // delete from arrays
            placeData.remove(at: indexPath.row)
            // delete row from tableview
            placeTableViewCell.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let showOnMap = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DisplayPlaceOnMapViewController") as! DisplayPlaceOnMapViewController
        present(showOnMap, animated: true)
        let identity = placeData[indexPath.row].identifier
        showOnMap.identifier = identity
        show(showOnMap, sender: nil)
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection
        section: Int) -> String? {
        return ("Number of Records are : \(placeData.count)\n")
    }
    func deleteAllRecords() {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Location")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
            placeData.removeAll()
            placeTableViewCell.reloadData()
        } catch {
            print ("There was an error")
        }
        
    }
}
