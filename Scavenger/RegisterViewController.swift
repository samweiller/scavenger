//
//  RegisterViewController.swift
//  Scavenger
//
//  Created by Sam Weiller on 11/27/15.
//  Copyright © 2015 saweiller. All rights reserved.
//

import UIKit
import Parse



class RegisterViewController: UIViewController {
    
    @IBOutlet weak var teamNameField: UITextField!
    @IBOutlet weak var teamPasswordField: UITextField!
    @IBOutlet weak var errorZone: UILabel!

    
    @IBAction func theButtonToRegister(sender: AnyObject) {
        
        let theTeamName = teamNameField.text
        let theTeamPassword = teamPasswordField.text
        
        let user = PFUser()
        user.username = theTeamName
        user.password = theTeamPassword
        
        user.signUpInBackgroundWithBlock{ (succeeded: Bool, error: NSError?) -> Void in
            if let error = error {
                let errorString = error.userInfo["error"] as? String // grab the error
                self.errorZone.text = errorString // display the error
            } else {
                // Success!
                print("success!")
               
                let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
                print(mainStoryboard)
                let vc : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("InstructionViewController") as UIViewController
//                self.showViewController(vc as UIViewController, sender: vc)
                self.presentViewController(vc, animated: true, completion: nil)
            }
        }
    }
    
    
    @IBAction func theButtonToLogin(sender: AnyObject) {
        let theTeamName = teamNameField.text
        let theTeamPassword = teamPasswordField.text
        
        PFUser.logInWithUsernameInBackground(theTeamName as String!, password:theTeamPassword as String!) {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                print("success!")
                let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
                print(mainStoryboard)
                let vc : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("InstructionViewController") as UIViewController
                print(vc)
                self.presentViewController(vc, animated: true, completion: nil)
                
            } else {
                let errorString = error!.userInfo["error"] as? String // grab the error
                self.errorZone.text = errorString // display the error
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

