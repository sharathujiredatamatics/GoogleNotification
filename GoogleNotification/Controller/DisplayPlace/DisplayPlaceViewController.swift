//
//  DisplayPlaceViewController.swift
//  GoogleNotification
//
//  Created by Datamatics on 16/03/21.
//  Copyright © 2021 Datamatics. All rights reserved.
//

import UIKit
import CoreData
class DisplayPlaceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let managerContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var nearByPlaceCoreData = [NSManagedObject]()
    @IBOutlet weak var placeTableViewCell: UITableView!
    var placeData = [Place]()
    var placesData = [NSManagedObject]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        fetchPlaceData()
    }
    func fetchPlaceData(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Location")
        do {
            let results = try managerContext.fetch(request)
            placesData = results as! [NSManagedObject]
            // clean up of array to avoid doubled data
            self.placeData.removeAll()
            // Retrieving data 1 by 1
            for place in placesData {
                // Append data to arrays
                let name = place.value(forKey: "name")
                let country = place.value(forKey: "country")
                let location = place.value(forKey: "locationDescription")
                let lat = place.value(forKey: "latitude")
                let long = place.value(forKey: "longitude")
                let image = place.value(forKey: "image")
                let date = place.value(forKey: "date")
                let newPlace = Place(name: name as! String, country: country as! String, locationDescription: location as! String, lat: lat as! Double, long: long as! Double, image: image as! Data, date: date as! String)
                self.placeData.append(newPlace!)
        
        }
        }catch {
            print("Caught an error: \(error)")
        }
        
    }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return placeData.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PlaceTableViewCell
            cell.name.text = placeData[indexPath.row].name
            cell.date.text = placeData[indexPath.row].date
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
    func tableView(_ tableView: UITableView, titleForHeaderInSection
        section: Int) -> String? {
        return ("Number of Records are : \(placeData.count)")
    }
}
