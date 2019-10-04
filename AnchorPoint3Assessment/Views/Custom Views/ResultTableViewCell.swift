//
//  ResultTableViewCell.swift
//  AnchorPoint3Assessment
//
//  Created by Josh Sparks on 10/4/19.
//  Copyright © 2019 Josh Sparks. All rights reserved.
//

import UIKit


class ResultTableViewCell: UITableViewCell {
    
    @IBOutlet weak var artworkImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var movieItem: MovieSearch? {
        didSet {
            guard let item = movieItem else { return }
            titleLabel.text = item.title
            ratingLabel.text = "\(item.vote_average)"
            descriptionLabel.text = item.overview
            artworkImageView.image = nil
            MovieController.fetchImage(item: item) { (image) in
                if let image = image {
                    DispatchQueue.main.async {
                        self.artworkImageView.image = image
                    }
                } else {
                    print("Image was nil")
                }
            }
            
        }
    }
}
