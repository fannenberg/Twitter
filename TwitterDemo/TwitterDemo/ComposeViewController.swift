//
//  ComposeViewController.swift
//  TwitterDemo
//
//  Created by Fernanda on 3/24/16.
//  Copyright © 2016 Maria C. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var tweetField: UITextView!
    
    var profileUrl: NSURL?
    let client = TwitterClient.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()

        avatarImageView.setImageWithURL(profileUrl!)
        tweetField.becomeFirstResponder()
        
        avatarImageView.layer.cornerRadius = 4
        avatarImageView.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onExit(sender: AnyObject) {
        
        tweetField.resignFirstResponder()
        self.dismissViewControllerAnimated(true, completion: {})
        
        print ("User didn't tweet :/")
    }
    
    @IBAction func onTweeting(sender: AnyObject) {
        
        let typeTweet = tweetField.text
        let postTweet = typeTweet.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())
        client.tweeting(postTweet!)
        self.dismissViewControllerAnimated(true, completion: {})
        
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
