//
//  MovieDetailViewController.swift
//  MovieAssistant
//
//  Created by Vincent Yu on 1/27/19.
//  Copyright © 2019 Vincent Yu. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    // MARK: Properties
    var movieTitle: String = ""
    var movieGenre: String? = nil
    var movieReleaseDate: String? = nil
    var movieRating: String? = nil
    var movieImage: UIImage? = nil
    var movieDescription: String? = nil
    var movieUrl: String? = nil
    let formatter = DateFormatter()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var movieImageView: UIImageView!
    
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = movieTitle
        genreLabel.text = movieGenre ?? "Unknown"
        releaseDateLabel.text = movieReleaseDate ?? "---"
        ratingLabel.text = movieRating ?? "-"
        movieImageView.image = movieImage!
        descriptionTextView.text = movieDescription ?? "No description"
    }
    
    @IBAction func viewMore(_ sender: Any) {
        if let movieUrl = movieUrl {
            let url = URL(string: movieUrl)!
            UIApplication.shared.open(url, options: [:])
        }
        else {
            print("No preview for \(movieTitle)")
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
