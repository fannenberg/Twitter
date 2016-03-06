//
//  Tweet.swift
//  TwitterDemo
//
//  Created by Fernanda on 2/29/16.
//  Copyright © 2016 Maria C. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var text: NSString?
    var timestamp: NSDate?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    var profileURL: NSURL?
    var name: NSString?
    var screenname: NSString?
    
    init(dictionary: NSDictionary) {
        
        let user = dictionary["user"] as? NSDictionary
        name = user!["name"] as? String
        text = dictionary["text"] as? String
        screenname = user!["screen_name"] as? String
        
        let profileURLString = user!["profile_image_url_https"] as? String
        if  profileURLString != nil {
            profileURL = NSURL(string: profileURLString!)
        } else {
            profileURL = nil
        }
        
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favourites_count"] as? Int) ?? 0
        
        let timestampString = dictionary["created_at"] as? String
        
        
        if let timestampString = timestampString {
            let formatter = NSDateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.dateFromString(timestampString)
        }
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet]{
        var tweets = [Tweet]()        
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            
            tweets.append(tweet)
        }
        
        return tweets
    }


}
