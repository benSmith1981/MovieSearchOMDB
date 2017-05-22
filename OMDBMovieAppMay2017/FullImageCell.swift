//
//  RequestResult.swift
//  OMDBMovies
//
//  Created by Ben Smith on 10/05/16.
//  Copyright © 2017 Ben Smith. All rights reserved.
//

import UIKit

class FullImageCell: UITableViewCell {
    
    @IBOutlet var fullImageView: UIImageView!
    @IBOutlet var smallImageView: UIImageView!
    @IBOutlet var rightText: UILabel!
    @IBOutlet var leftText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupimage()
       // setupSmallImage()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        setupSmallImage()
    }
    
    func setupimage() {
        fullImageView.clipsToBounds = true
        fullImageView.layer.masksToBounds = true
    }
    
    func setupSmallImage() {
        let size = Size()
        let frame :CGFloat = size.percentage(of: contentView.frame.width, percentage: 34)
        
        smallImageView.frame = CGRect(x: contentView.frame.width/2 - frame/2, y: contentView.frame.height/2 - frame/4, width: frame, height: frame)
        
        smallImageView.clipsToBounds = true
        smallImageView.layer.masksToBounds = true
        smallImageView.layer.cornerRadius = smallImageView.frame.width/2
        smallImageView.layer.borderColor = UIColor.white.cgColor
        smallImageView.layer.borderWidth = 4
        smallImageView.backgroundColor = UIColor.white
        smallImageView.layer.shadowRadius = 4
        
        smallImageView.layer.shadowColor = UIColor.black.cgColor
 
        
    }
}
