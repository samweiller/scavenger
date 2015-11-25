//
//  mapViewController.swift
//  Scavenger
//
//  Created by Sam Weiller on 11/23/15.
//  Copyright © 2015 saweiller. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var theMap: GMSMapView!
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        
        //        // Ask for Authorisation from the User.
        //        self.locationManager.requestAlwaysAuthorization()
        //
        //        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        locationManager.startUpdatingLocation()
        theMap.myLocationEnabled = true
        theMap.settings.myLocationButton = true
    }
}