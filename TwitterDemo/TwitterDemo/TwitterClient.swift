//
//  TwitterClient.swift
//  TwitterDemo
//
//  Created by Fernanda on 3/1/16.
//  Copyright © 2016 Maria C. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    
    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com")!, consumerKey: "AqCTqDNDybi6PXN9HC32VtTF3", consumerSecret: "lH0FKupw3nXWgItJ5K34WcDe3sqgjufoaXyKROkv6A5VytZSgu")
    
    var loginSucess: (() -> ())?
    var loginFailure: ((NSError) -> ())?
    
    func login(success: () -> (), failure: (NSError) -> ()) {
        loginSucess = success
        loginFailure = failure
        
        TwitterClient.sharedInstance.deauthorize()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "twitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            
            let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")!
            
            UIApplication.sharedApplication().openURL(url)
            
        }) { (error: NSError!) -> Void in
            print("error: \(error.localizedDescription)")
            self.loginFailure?(error)
        }
    }
    
    func logout() {
        User.currentUser = nil
        deauthorize()
        
        NSNotificationCenter.defaultCenter().postNotificationName(User.userDidLogoutNotification, object: nil)
    }
    
    func handleOpenUrl(url: NSURL) {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential!) -> Void in
            
            self.currentAccount({ (user: User) -> () in
                User.currentUser = user  //magic line that calls the setter and saves it
                self.loginSucess?()
            }, failure: { (error: NSError) -> () in
                self.loginFailure?(error)
            })
        }) {(error: NSError!) -> Void in
            print("error: \(error.localizedDescription)")
            self.loginFailure?(error)
        }
    }
    
    func homeTimeline(success: ([Tweet]) -> (), failure: (NSError) -> ()){
        
        GET("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response:AnyObject?) -> Void in
            let dictionaries = response as! [NSDictionary]
            
            let tweets = Tweet.tweetsWithArray(dictionaries)
            
            success(tweets)
        }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
              failure(error)
        })
    }
    
    func currentAccount(success: (User) -> (), failure: (NSError) -> ()) {
        
        GET("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            
            let userDictionary = response as! NSDictionary
            
            let user = User(dictionary: userDictionary)
            
            success(user)
            
        }, failure: { (task: NSURLSessionDataTask?, error:NSError!) -> Void in
            failure(error)
        })

    }
    
    // adding retweet and unretweet
    
    func reTweet(tweetID: String) {
        
        POST("1.1/statuses/retweet/\(tweetID).json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("User is able to retweet") // added for debugging purposes
            
        }, failure: { (task: NSURLSessionDataTask?, error: NSError!) -> Void in
            print("Boo! Try again") // added for debugging purposes
            print("error: \(error.localizedDescription)")
        })
    
    }
    
    func unRetweet (tweetID: String) {
        
        POST("1.1/statuses/unretweet/\(tweetID).json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("User is able to unretweet") // added for debugging purposes
            
            }, failure: { (task: NSURLSessionDataTask?, error: NSError!) -> Void in
                print("Boo! Try again") // added for debugging purposes
                print("error: \(error.localizedDescription)")
        })
        
    }
    
    func favorite (tweetID: String) {
        
        POST("1.1/favorites/create.json?id=\(tweetID)", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("User is able to favorite") // added for debugging purposes
            
            }, failure: { (task: NSURLSessionDataTask?, error: NSError!) -> Void in
                print("Boo! Try again") // added for debugging purposes
                print("error: \(error.localizedDescription)")
        })
    }
    
    func unFavorite (tweetID: String) {
        
        POST("1.1/favorites/destroy.json?id=\(tweetID)", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("User is able to unfavorite") // added for debugging purposes
            
            }, failure: { (task: NSURLSessionDataTask?, error: NSError!) -> Void in
                print("Boo! Try again") // added for debugging purposes
                print("error: \(error.localizedDescription)")
        })
    }
    
    func tweeting (tweetField: String) {
        
        POST("1.1/statuses/update.json?status=\(tweetField)", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response:AnyObject?) -> Void in
            print("User can tweet! Super")
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                print(error.localizedDescription)
        })
    }
}
