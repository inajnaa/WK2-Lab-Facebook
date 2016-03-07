//
//  ImageTransition.swift
//  Facebook
//
//  Created by Anjani Bhargava on 3/3/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class ImageTransition: BaseTransition {

    override func presentTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        
        // creating variables for VCs
        let photoViewController = toViewController as! PhotoViewController
        let storyViewController = fromViewController as! StoryViewController
        
        // creating the new image to move
        let movingImage = UIImageView()
        movingImage.frame = storyViewController.selectedImageView.frame
        movingImage.image = storyViewController.selectedImageView.image
        movingImage.clipsToBounds = storyViewController.selectedImageView.clipsToBounds
        movingImage.contentMode = photoViewController.imageView.contentMode
        
        // add new image to the container view
        containerView.addSubview(movingImage)
        
        // hide image in destination VC
        photoViewController.imageView.alpha = 0
        
        // hide destination VC
        toViewController.view.alpha = 0
        
        UIView.animateWithDuration(duration, animations: {

            // set size and position of moving image to be same as destinatino image
            movingImage.frame = photoViewController.imageView.frame

            // animate view controller to appear
            toViewController.view.alpha = 1
            
        }) { (finished: Bool) -> Void in
            
            // show image in destination VC
            photoViewController.imageView.alpha = 1
            
            // remove moving image from view
            movingImage.removeFromSuperview()
            
            // tell transition to finish
            self.finish()
        }
    }
    
    
    override func dismissTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        
        // creating variables for VCs
        let photoViewController = fromViewController as! PhotoViewController
        let storyViewController = toViewController as! StoryViewController
        
        // creating image to move
        let movingImage = UIImageView()
        movingImage.frame = photoViewController.imageView.frame
        movingImage.image = photoViewController.imageView.image
        movingImage.clipsToBounds = photoViewController.imageView.clipsToBounds
        movingImage.contentMode = photoViewController.imageView.contentMode
        
        // adding image to container view
        containerView.addSubview(movingImage)
        
        // set image in from VC to be 1
        photoViewController.imageView.alpha = 1
        
        // set from VC to be visible
        fromViewController.view.alpha = 1
        
        UIView.animateWithDuration(duration, animations: {
            
            // set moving image to be size and position of destination image
            movingImage.frame = storyViewController.selectedImageView.frame
            
            // animate from VC away
            fromViewController.view.alpha = 0
            
            // animate photo in to VC to go away
            photoViewController.imageView.alpha = 0
            
        }) { (finished: Bool) -> Void in
        
            // remove image and finish animation
            movingImage.removeFromSuperview()
            self.finish()
        }
    }

    
}
