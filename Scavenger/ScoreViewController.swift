//
//  ScoreViewController.swift
//  Scavenger
//
//  Created by Sam Weiller on 11/28/15.
//  Copyright © 2015 saweiller. All rights reserved.
//

import UIKit
import CoreLocation

class ScoreViewController: UIViewController {
    let validZoneValue = 30.0 // need .0 to be considered a double
    @IBOutlet weak var myScore: UILabel!
    @IBOutlet weak var theirScore: UILabel!
    
    @IBAction func theCheckInButton(sender: AnyObject) {
        var validLocation = -1
        
        // Define locations
        // is now done in mapViewController
        
        // grab current location from Parse
        var myCurrentLocation = CLLocation(latitude: theTeamLocation["latitude"] as! Double, longitude: theTeamLocation["longitude"] as! Double) // not positive this will work? Not 100% sure what downcasting is...
        
        // Check distances
        // for (index, element) in list.enumerate()
        for (locNum, aLocation) in theLocations.enumerate() {
            if theActiveLocations[locNum] == 1{
                var calculatedDistance = myCurrentLocation.distanceFromLocation(aLocation)
                print(calculatedDistance)
                if (calculatedDistance < validZoneValue) {
                    validLocation = locNum // this should be the index of the valid location
                }
            }
        }
        
        if (validLocation > -1){
            showSimpleAlertWithTitle("Yahoo!", message: "You got 5 points for checking in!", viewController: self)
            theActiveLocations[validLocation] = 0
            // alternitively:
            markerArray[validLocation].map = nil //or something like this. look it up. DONE!
            
            myGlobalScore = myGlobalScore + 5
            self.myScore.text = String(myGlobalScore)
            self.theirScore.text = String(theirGlobalScore)
            // also need to update points.
        } else {
            showSimpleAlertWithTitle("Sorry!", message: "You are not within range of any marker zones.", viewController: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
}
