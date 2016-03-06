//
//  TweetCell.swift
//  TwitterDemo
//
//  Created by Fernanda on 3/5/16.
//  Copyright © 2016 Maria C. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    
   var tweet: Tweet! {
        didSet {
            thumbImageView.setImageWithURL(tweet.profileURL!)
            nameLabel.text = tweet.name as? String
            usernameLabel.text = "@\(tweet.screenname as! String)"
            tweetLabel.text = tweet.text as? String
            let formatter = NSDateFormatter()
            formatter.dateFormat = "M/d, HH:mm"
            let timeLabelString = formatter.stringFromDate(tweet.timestamp!)
            timeLabel.text = timeLabelString
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        thumbImageView.layer.cornerRadius = 4
        thumbImageView.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
