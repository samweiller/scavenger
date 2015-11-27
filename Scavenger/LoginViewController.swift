//
//  LoginViewController.swift
//  Scavenger
//
//  Created by Sam Weiller on 11/25/15.
//  Copyright © 2015 saweiller. All rights reserved.
//

import UIKit
import Parse


class LoginViewController: UIViewController {
    @IBOutlet weak var teamNameField: UITextField!
    @IBOutlet weak var teamPasswordField: UITextField!
    
    
    @IBAction func theLoginButton(sender: UIButton) {
        let theTeamName = teamNameField.text
        let theTeamPassword = teamPasswordField.text
        
        var user = PFUser()
        user.username = theTeamName
        user.password = theTeamPassword
        
        //for custom fields use default key-value assign
//        user["fullName"] = fullName
        
        user.signUpInBackgroundWithBlock{ (succeeded: Bool, error: NSError?) -> Void in
            if let error = error {
//                let errorString = error.userInfo?["error"] as? String
                // Show the errorString somewhere and let the user try again.
            } else {
                // Hooray! Let them use the app now.
            }
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

