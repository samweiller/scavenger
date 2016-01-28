//
//  InstructionViewController.swift
//  Scavenger
//
//  Created by Sam Weiller on 11/27/15.
//  Copyright © 2015 saweiller. All rights reserved.
//

import UIKit
import Parse
var theObjectID = "foo"
var theTeamLocation = PFObject(className:"Location")

class InstructionViewController: UIViewController {
    @IBOutlet weak var theTeamViewer: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var currentUser = PFUser.currentUser()
        self.theTeamViewer.text = currentUser!.username
        
        theTeamLocation["teamName"] = PFUser.currentUser()?.username
        theTeamLocation["latitude"] = 0
        theTeamLocation["longitude"] = 0
        theTeamLocation["teamScore"] = 0
        
        theTeamLocation.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                print("done")
                // The object has been saved.
            } else {
                print("sad panda")
                // There was a problem, check error.description
            }
        }
        
        sleep(2)
        var theObjectID = theTeamLocation.objectId! as String
        
    }
    
    
}

