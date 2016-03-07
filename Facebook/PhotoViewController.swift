//
//  PhotoViewController.swift
//  Facebook
//
//  Created by Anjani Bhargava on 3/3/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var actionBar: UIImageView!
    
    var image: UIImage!
    var alpha: CGFloat!
    var blackColor: UIColor!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = image
        
        scrollView.contentSize = CGSize(width: 320, height: 570)
        scrollView.delegate = self
        
        alpha = 1

    }
    
    @IBAction func didTapDone(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        blackColor = UIColor(white: 0, alpha: alpha)
        scrollView.backgroundColor = blackColor
        alpha = 1 + (scrollView.contentOffset.y / 200)
        
        UIView.animateWithDuration(0.2) { () -> Void in
            self.doneButton.alpha = 0
            self.actionBar.alpha = 0
        }
        
        if scrollView.contentOffset.y == 0 {
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                self.doneButton.alpha = 1
                self.actionBar.alpha = 1
            })
            
        }
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView!) -> UIView! {
        return imageView
    }

    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y < -80 {
            dismissViewControllerAnimated(true, completion: nil)
        }
        print(scrollView.contentOffset.y)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
