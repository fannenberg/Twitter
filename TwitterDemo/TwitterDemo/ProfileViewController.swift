//
//  ProfileViewController.swift
//  TwitterDemo
//
//  Created by Fernanda on 3/24/16.
//  Copyright © 2016 Maria C. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    
    var tweet: Tweet!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        avatarImageView.setImageWithURL(tweet.profileURL!)
        headerImageView.setImageWithURL(tweet.bannerURL!)
        nameLabel.text = tweet.name as String?
        usernameLabel.text = "@\(tweet.screenname!)"
        tweetCountLabel.text = "\(tweet.tweetCount!)"
        followingCountLabel.text = "\(tweet.followingCount!)"
        followersCountLabel.text = "\(tweet.followersCount!)"
        

        // Do any additional setup after loading the view.
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
