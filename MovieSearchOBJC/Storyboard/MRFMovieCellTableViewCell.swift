//
//  MRFMovieCellTableViewCell.swift
//  MovieSearchOBJC
//
//  Created by Michael Flowers on 10/11/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import UIKit

class MRFMovieCellTableViewCell: UITableViewCell {

    var movie: MRFMovie? {
        didSet {
            updateViews()
        }
    }
    var posterImage: UIImage?  {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var overviewTextView: UITextView!

    private func updateViews(){
        guard let passedInMovie = movie else {
            print("Error passing movie into cell")
            return
        }
        titleLabel.text = "Title: \(passedInMovie.title)"
        ratingLabel.text = "Rating: \(passedInMovie.rating)"
        overviewTextView.text = passedInMovie.overview
        guard let passedInPosterImage = posterImage else {
            print("Error passing in poster image to cell")
            return
        }
        movieImageView.image = passedInPosterImage
    }
}
