//
//  MovieTableViewCell.swift
//  MovieAssistant
//
//  Created by Vincent Yu on 1/27/19.
//  Copyright © 2019 Vincent Yu. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    // MARK: Properties
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieGenre: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
