//
//  DetailViewController.swift
//  TwitterDemo
//
//  Created by Fernanda on 3/24/16.
//  Copyright © 2016 Maria C. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    
    var tweet: Tweet!
    let client = TwitterClient.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "M/d, HH:mm"
        let timeLabelString = formatter.stringFromDate(tweet.timestamp!)
        
        profileImageView.setImageWithURL(tweet.profileURL!)
        nameLabel.text = tweet.name as? String
        usernameLabel.text = "@\(tweet.screenname as! String)"
        timestampLabel.text = timeLabelString
        retweetCountLabel.text = "\(tweet.retweetCount)"
        favoriteCountLabel.text = "\(tweet.favoritesCount)"
        tweetLabel.text = tweet.text as? String
        
        if tweet.retweeted {
            retweetButton.setImage(UIImage(named: "retweet-action-on-green"), forState: .Normal)
        } else {
            retweetButton.setImage(UIImage(named: "retweet-action_default"), forState: .Normal)
        }
        
        if tweet.favorited {
            favoriteButton.setImage(UIImage(named: "like-action-on-red"), forState: .Normal)
        } else {
            favoriteButton.setImage(UIImage(named: "like-action-off"), forState: .Normal)
        }
        
        profileImageView.layer.cornerRadius = 4
        profileImageView.clipsToBounds = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onFavorite(sender: AnyObject) {
        
        if tweet.favorited == false {
            tweet.favoritesCount += 1
            tweet.favorited = true
            client.favorite(tweet.tweetID!)
            
        } else if tweet.favorited == true {
            tweet.favoritesCount -= 1
            tweet.favorited = false
            client.unFavorite(tweet.tweetID!)
            
        }
    }
    
    @IBAction func onRetweet(sender: AnyObject) {
        
        if tweet.retweeted == false {
            tweet.retweetCount += 1
            tweet.retweeted = true
            client.reTweet(tweet.tweetID!)
            
        } else if tweet.retweeted == true {
            tweet.retweetCount -= 1
            tweet.retweeted = false
            client.unRetweet(tweet.tweetID!)
        
        }
    }
    

    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "profileSegue" {
            
            let profileViewController = segue.destinationViewController as! ProfileViewController
            profileViewController.tweet = tweet
            
            print("Profile Segue got activated")
        }
        
    }


}
