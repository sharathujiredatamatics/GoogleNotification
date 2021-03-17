//
//  DisplayPlaceViewController.swift
//  GoogleNotification
//
//  Created by Datamatics on 16/03/21.
//  Copyright © 2021 Datamatics. All rights reserved.
//

import UIKit
import CoreData
// DisplayPlaceViewController to manage NotificationTableViewController and to fetch data from coredata.
class DisplayPlaceViewController: UIViewController {
    let managerContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var nearByPlaceCoreData = [NSManagedObject]()
    @IBOutlet weak var placeTableViewCell: UITableView!
    var placeData = [Place]()
    var placesData = [NSManagedObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
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
    @IBAction func homeWindow(_ sender: UIButton) {
        let showOnMap = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        present(showOnMap, animated: true)
    }
    @IBAction func deleteAllNotification(_ sender: UIButton) {
        deleteAllRecords()
    }
    
}
