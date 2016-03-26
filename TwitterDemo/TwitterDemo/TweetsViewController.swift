//
//  TweetsViewController.swift
//  TwitterDemo
//
//  Created by Fernanda on 3/4/16.
//  Copyright © 2016 Maria C. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tweets: [Tweet]!
    let client = TwitterClient.sharedInstance
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        client.homeTimeline({ (tweets: [Tweet]) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
            
        }, failure: { (error: NSError) -> () in
                print(error.localizedDescription)
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets != nil {
            return tweets!.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
            cell.tweet = tweets[indexPath.row]
    
        return cell
    }
    
    
    @IBAction func onLogoutButton(sender: AnyObject) {
        client.logout()
    }

    @IBAction func onRetweet(sender: AnyObject) {
        
        let button = sender as! UIButton
        let view = button.superview!
        let cell = view.superview as! TweetCell
        let indexpath = tableView.indexPathForCell(cell)
        let tweet = tweets[indexpath!.row]
        
        if tweet.retweeted == false {
            self.tweets![indexpath!.row].retweetCount += 1
            tweet.retweeted = true
            client.reTweet(tweet.tweetID!)
            tableView.reloadData()
            
        } else if tweet.retweeted == true {
            self.tweets![indexpath!.row].retweetCount -= 1
            tweet.retweeted = false
            client.unRetweet(tweet.tweetID!)
            tableView.reloadData()
        }
    }
    
    @IBAction func onFavorite(sender: AnyObject) {
        
        let button = sender as! UIButton
        let view = button.superview!
        let cell = view.superview as! TweetCell
        let indexpath = tableView.indexPathForCell(cell)
        let tweet = tweets[indexpath!.row]
        
        if tweet.favorited == false {
            self.tweets![indexpath!.row].favoritesCount += 1
            tweet.favorited = true
            client.favorite(tweet.tweetID!)
            tableView.reloadData()
            
        } else if tweet.favorited == true {
            self.tweets![indexpath!.row].favoritesCount -= 1
            tweet.favorited = false
            client.unFavorite(tweet.tweetID!)
            tableView.reloadData()
        }

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "detailSegue" {
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            let tweet = tweets![indexPath!.row]
            
            let detailViewController = segue.destinationViewController as! DetailViewController
            detailViewController.tweet = tweet
            print("Detail Segue got activated")
        }
        
        if segue.identifier == "composeSegue" {
            let profileUrl = User.currentUser?.profileUrl
            let composeViewController = segue.destinationViewController as! ComposeViewController
            composeViewController.profileUrl = profileUrl
        }
    }
    

}
