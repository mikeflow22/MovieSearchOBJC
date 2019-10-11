//
//  MRFMovieCellTableViewCell.swift
//  MovieSearchOBJC
//
//  Created by Michael Flowers on 10/11/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import UIKit

class MRFMovieCellTableViewCell: UITableViewCell {

    var movie: MRFMovie?
    var posterImage: UIImage?
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var overviewTextView: UITextView!

}
