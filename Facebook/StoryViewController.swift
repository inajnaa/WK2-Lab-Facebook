//
//  StoryViewController.swift
//  Facebook
//
//  Created by Timothy Lee on 8/3/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

import UIKit

class StoryViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var commentField: UITextField!
    @IBOutlet weak var commentContainer: UIView!
    @IBOutlet weak var photoImageView: UIImageView!
    
    var selectedImageView: UIImageView!
    
    var imageTransition: ImageTransition!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = imageView.image!.size
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        imageTransition = ImageTransition()
        
        scrollView.contentInset.top = 0
        scrollView.contentInset.bottom = 0
        scrollView.scrollIndicatorInsets.top = 0
        scrollView.scrollIndicatorInsets.bottom = 0
        
        scrollView.sendSubviewToBack(imageView)
        
        NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardWillShowNotification, object: nil, queue: nil, usingBlock: { (notification: NSNotification) -> Void in
            var userInfo = notification.userInfo!
            
            // Get the keyboard height and width from the notification
            // Size varies depending on OS, language, orientation
            let kbSize = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue().size
            let durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber
            let animationDuration = durationValue.doubleValue
            let curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber
            let animationCurve = curveValue.integerValue

            
            UIView.animateWithDuration(animationDuration, delay: 0.0, options: UIViewAnimationOptions(rawValue: UInt(animationCurve << 16)), animations: {
                self.commentContainer.frame.origin.y = self.view.frame.size.height - kbSize.height - self.commentContainer.frame.size.height
            }, completion: nil)
        })
        
        NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardWillHideNotification, object: nil, queue: nil, usingBlock: { (notification: NSNotification) -> Void in
            var userInfo = notification.userInfo!
            
            // Get the keyboard height and width from the notification
            // Size varies depending on OS, language, orientation
            let kbSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue().size
            let durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber
            let animationDuration = durationValue.doubleValue
            let curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber
            let animationCurve = curveValue.integerValue
            
            UIView.animateWithDuration(animationDuration, delay: 0.0, options: UIViewAnimationOptions(rawValue: UInt(animationCurve << 16)), animations: {
                self.commentContainer.frame.origin.y = self.scrollView.frame.size.height + self.scrollView.frame.origin.y
                }, completion: nil)
            })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCommentButton(sender: AnyObject) {
        commentField.becomeFirstResponder()
    }
    
    @IBAction func onBackButton(sender: AnyObject) {
        navigationController!.popViewControllerAnimated(true)
    }

    @IBAction func onLikeButton(sender: AnyObject) {
        likeButton.selected = !likeButton.selected
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBAction func onEditingBegan(sender: AnyObject) {
        
        UIView.animateWithDuration(2, animations: { () -> Void in
            self.commentContainer.center = CGPoint(x: 170, y: 100)
            self.commentContainer.alpha = 0.5
            self.commentContainer.backgroundColor = UIColor.redColor()
            
        })
    }
    
    
    @IBAction func didTapPhoto(sender: UITapGestureRecognizer) {
        
        selectedImageView = sender.view as! UIImageView
        performSegueWithIdentifier("PhotoSegue", sender: self)
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        let destinationViewController = segue.destinationViewController as! PhotoViewController
        destinationViewController.image = self.selectedImageView.image
        
        destinationViewController.modalPresentationStyle = UIModalPresentationStyle.Custom
        destinationViewController.transitioningDelegate = imageTransition
    }

  }
