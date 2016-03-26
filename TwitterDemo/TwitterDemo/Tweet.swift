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
    var tweetID: String?
    var retweeted: Bool
    var favorited: Bool
    var bannerURL: NSURL?
    var tweetCount: Int?
    var followingCount: Int?
    var followersCount: Int?
    
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
        
        let bannerURLString = user!["profile_banner_url"] as? String
        if  bannerURLString != nil {
            bannerURL = NSURL(string: bannerURLString!)
        } else {
            bannerURL = nil
        }
        
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favourites_count"] as? Int) ?? 0
        
        let timestampString = dictionary["created_at"] as? String
        
        
        if let timestampString = timestampString {
            let formatter = NSDateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.dateFromString(timestampString)
        }
        
        tweetID = dictionary["id_str"] as? String
        retweeted = dictionary["retweeted"] as! Bool
        favorited = dictionary["favorited"] as! Bool
        tweetCount = user!["statuses_count"] as? Int
        followingCount = user!["friends_count"] as? Int
        followersCount = user!["followers_count"] as? Int
        
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
