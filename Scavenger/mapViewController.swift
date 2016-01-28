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
import Parse

let theLocations = [
    CLLocation(latitude: 33.77682871, longitude: -84.38881874), // 5th & Spring
    CLLocation(latitude: 33.77764023, longitude: -84.3957442),  // Ferst & Cherry
    CLLocation(latitude: 33.77382035, longitude: -84.3919158),  // 3rd & Techwood
    CLLocation(latitude: 33.77400317, longitude: -84.39686179), // Tech Green
//    CLLocation(latitude: 33.77541223, longitude: -84.4025588)]  // CRC (Ferst Drive)
//    CLLocation(latitude: 33.780452, longitude: -84.416711)]  // Test location
    CLLocation(latitude: 33.778488, longitude: -84.396835)]  // Demo location

let theLocationLabels = [
    "Fifth and Spring",
    "Ferst and Cherry",
    "Third and Techwood",
    "Tech Green",
    "CRC"
]

var theActiveLocations = Array(count: 5, repeatedValue: 1)
var markerArray = Array(count:5, repeatedValue: GMSMarker())
var opponentLocation = CLLocation(latitude: 0, longitude: 0)
var theUserLocation = CLLocation(latitude: 0, longitude: 0)
var opponentMarker = GMSMarker()
var myGlobalScore = 0
var theirGlobalScore = 0

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var theMap: GMSMapView!
    let locationManager = CLLocationManager()
    var timer = NSTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()

        theMap.myLocationEnabled = true
        theMap.settings.myLocationButton = true
        
//        showSimpleAlertWithTitle("Hello", message: "It's me.", viewController: self)
        
        print(locationManager.location?.coordinate.longitude)
        
        // Plant the markers
        for i in [0,1,2,3,4]{
            markerArray[i] = GMSMarker()
            markerArray[i].position = theLocations[i].coordinate
            markerArray[i].appearAnimation = kGMSMarkerAnimationPop
            markerArray[i].snippet = theLocationLabels[i]
            markerArray[i].icon = UIImage(named: "marker1")
            markerArray[i].map = theMap
        }
        
        timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "locationUpdater", userInfo: nil, repeats: true)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        var theUserLocation:CLLocation = locations[0] 
    }
    
    func locationUpdater() {
        locationManager.startUpdatingLocation()
        print(theUserLocation)
        theUserLocation = CLLocation(latitude: locationManager.location!.coordinate.latitude , longitude: locationManager.location!.coordinate.longitude)
        self.queryFunc(theUserLocation)
        self.opponentLocationQuery()
        opponentMarker.map = nil
        opponentMarker.position = opponentLocation.coordinate
        opponentMarker.appearAnimation = kGMSMarkerAnimationPop
        opponentMarker.snippet = "Your Opponent"
        opponentMarker.icon = GMSMarker.markerImageWithColor(UIColor.yellowColor()) // change this
        opponentMarker.map = self.theMap
    }
    
    func queryFunc(location: CLLocation) {
        
        var currentUser = PFUser.currentUser()
        var query = PFQuery(className:"Location")
        var userAsString = currentUser!.username! as String
        
        query.whereKey("teamName", equalTo:userAsString)
        
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) scores.")
                for object in objects! {
                    theObjectID = object.objectId! as String
                }
                
                // Update the PFObject in existence
                var query = PFQuery(className:"Location")
                print(theObjectID)
                query.getObjectInBackgroundWithId(theObjectID) {
                    (theTeamLocation: PFObject?, error: NSError?) -> Void in
                    if error != nil {
                        print(error)
                    } else if let theTeamLocation = theTeamLocation {
                        theTeamLocation["latitude"] = location.coordinate.latitude
                        theTeamLocation["longitude"] = location.coordinate.longitude
                        theTeamLocation["teamScore"] = myGlobalScore
                        theTeamLocation.saveInBackground()
                        print("Update success")
                    }
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }
    
    func opponentLocationQuery() -> CLLocation{
            var query = PFQuery(className:"Location")
        
        query.whereKey("teamName", equalTo:"theOpponent")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) scores.")
                for object in objects! {
                    var opponentLatitude = object["latitude"]
                    var opponentLongitude = object["longitude"]
                    theirGlobalScore = object["teamScore"] as! Int
                    opponentLocation = CLLocation(latitude: opponentLatitude as! Double, longitude: opponentLongitude as! Double)
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
     return opponentLocation
    }
}