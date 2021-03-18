//
//  DisplayPlaceViewController.swift
//  GoogleNotification
//
//  Created by Datamatics on 18/03/21.
//  Copyright © 2021 Datamatics. All rights reserved.
//

import UIKit
import MapKit
import CoreData
class DisplayPlaceOnMapViewController: UIViewController {
    @IBOutlet weak var displayMap: MKMapView!
    var placeData = [NSManagedObject]()
    let managerContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var identifier = String()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        setRegionFromNotification()
    }
    @IBAction func homeWindow(_ sender: UIButton) {
        let showOnMap = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        present(showOnMap, animated: true)
    }
    @IBAction func viewNotification(_ sender: UIButton) {
        let displayPlaceViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DisplayPlaceViewController") as! DisplayPlaceViewController
        present(displayPlaceViewController, animated: true)
    }
}
