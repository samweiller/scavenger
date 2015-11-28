//
//  mapViewController.swift
//  Scavenger
//
//  Created by Sam Weiller on 11/23/15.
//  Copyright © 2015 saweiller. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation
import MapKit

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
        
        // This code is from SwiftLocation. It might make my life easier?
        // NOPE! JUST KIDDING THIS IS SO CONFUSING!
        do {
            let requestID = try SwiftLocation.shared.continuousLocation(Accuracy.Room, onSuccess: { (location) -> Void in
                print("4. Location found \(location?.description)")
                }) { (error) -> Void in
                    print("4. Something went wrong -> \(error?.localizedDescription)")
            }
        } catch (let error) {
            print("Error \(error)")
        }
    }
}