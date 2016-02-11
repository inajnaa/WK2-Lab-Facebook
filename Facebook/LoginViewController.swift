//
//  LoginViewController.swift
//  Facebook
//
//  Created by Anjani Bhargava on 2/10/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var fieldParentView: UIView!
    @IBOutlet weak var labelParentView: UIView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    var fieldParentViewInitial: CGFloat!
    var labelParentViewInitial: CGFloat!
    var logoImageInitial: CGFloat!
    
    var fieldParentOffset: CGFloat!
    var labelParentOffset: CGFloat!
    var logoImageOffset: CGFloat!


    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        
        fieldParentViewInitial = fieldParentView.frame.origin.y
        labelParentViewInitial = labelParentView.frame.origin.y
        logoImageInitial = logoImage.frame.origin.y
        
        fieldParentOffset = -50
        labelParentOffset = -180
        logoImageOffset = -30
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didLogin(sender: AnyObject) {

        self.activityIndicator.startAnimating()
        
        delay(2) { () -> () in
            self.activityIndicator.stopAnimating()
            
            if self.emailField.text == "kingsley" && self.passwordField.text == "password" {
                self.performSegueWithIdentifier("loginSegue", sender: nil)
                
            } else {
                let alertController = UIAlertController(title: "Access Denied", message: "Incorrect credentials", preferredStyle: .Alert)
                
                let cancelAction = UIAlertAction(title: "OK", style: .Cancel, handler: { (UIAlertAction) -> Void in
                })
                
                alertController.addAction(cancelAction)
                
                self.presentViewController(alertController, animated: true, completion: {
                })
            }
        }
    }
    

    @IBAction func changedEmailField(sender: AnyObject) {
        if emailField.text!.isEmpty || passwordField.text!.isEmpty {
            loginButton.enabled = false
        } else {
            loginButton.enabled = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func keyboardWillShow (notification: NSNotification!) {
        fieldParentView.frame.origin.y = fieldParentViewInitial + fieldParentOffset
        
        labelParentView.frame.origin.y = labelParentViewInitial + labelParentOffset
        
        logoImage.frame.origin.y = logoImageInitial + logoImageOffset
        
    }
    
   
    func keyboardWillHide (notification: NSNotification!) {
        fieldParentView.frame.origin.y = fieldParentViewInitial
        
        labelParentView.frame.origin.y = labelParentViewInitial
        
        logoImage.frame.origin.y = logoImageInitial
        
    }
    
    @IBAction func didTap(sender: AnyObject) {
        view.endEditing(true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
