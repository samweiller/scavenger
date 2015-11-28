//
//  InstructionViewController.swift
//  Scavenger
//
//  Created by Sam Weiller on 11/27/15.
//  Copyright © 2015 saweiller. All rights reserved.
//

import UIKit
import Parse

class InstructionViewController: UIViewController {
    @IBOutlet weak var theTeamViewer: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        var query = PFQuery(className:"user")
//        query.getObjectInBackgroundWithId("xWMyZEGZ") {
//            (gameScore: PFObject?, error: NSError?) -> Void in
//            if error == nil && gameScore != nil {
//                print(gameScore)
//            } else {
//                print(error)
//            }
//        }
        
        var currentUser = PFUser.currentUser()
        self.theTeamViewer.text = currentUser!.username
        
    }
    
        
}

