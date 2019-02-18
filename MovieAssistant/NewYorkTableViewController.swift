//
//  NewYorkTableViewController.swift
//  MovieAssistant
//
//  Created by Vincent Yu on 1/27/19.
//  Copyright © 2019 Vincent Yu. All rights reserved.
//

import UIKit

class NewYorkTableViewController: UITableViewController {

    // MARK: Properties
    let movieService = MovieService()
    var movies: [Movie] = []
    @IBOutlet var nycTableView: UITableView!
    
    @objc private func handleRefresh(_ refreshControl: UIRefreshControl) {
        movies.removeAll()
        search()
        self.refreshControl?.endRefreshing()
    }
    
    private func search() {
        movieService.search(for: "new_york", completion: { movies, error in
            guard let movies = movies, error == nil else {
                print(error ?? "Unknown Error")
                return
            }
            self.movies = movies
            print("Movies Fetched: \(movies.count)")
            self.nycTableView.reloadData()
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        
        search()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movies.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewYorkMovieCell", for: indexPath) as? MovieTableViewCell else {
            fatalError("The dequeued cell is not an instance of MovieTableViewCell.")
        }
        let movie = movies[indexPath.row]
        cell.movieTitle?.text = movie.trackName
        cell.movieGenre?.text = movie.primaryGenreName
        if let hasImage = movie.hasITunesExtras {
            cell.movieImage?.image = hasImage ? UIImage(named: "Popcorn") : UIImage(named: "Ticket")
        }
        else {
            cell.movieImage?.image = UIImage(named: "Ticket")
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as? MovieDetailViewController
        if let source = sender as? MovieTableViewCell {
            destination?.navigationBar.title = source.movieTitle.text
            guard let index = nycTableView.indexPath(for: source)?.row else{
                fatalError("Unsolved record")
            }
            let movie = movies[index]
            destination?.movieTitle = movie.trackName
            destination?.movieGenre = movie.primaryGenreName
            destination?.movieRating = movie.contentAdvisoryRating
            
            if let releaseDate = movie.releaseDate?.replacingOccurrences(of: "T", with: " ").replacingOccurrences(of: "Z", with: "") {
                // Convert releaseDate to expected format
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                guard let date = dateFormatter.date(from: releaseDate) else {
                    fatalError("Unsolved date format")
                }
                dateFormatter.dateStyle = .medium
                destination?.movieReleaseDate = dateFormatter.string(from: date)
            }
            destination?.movieUrl = movie.previewUrl
            destination?.movieImage = source.movieImage.image
            destination?.movieDescription = movie.longDescription
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
