//
//  ViewController.swift
//  Assignment1
//
//  Created by Enrique Delgado on 9/3/22.
//

import UIKit
import AlamofireImage

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    // These 2 functions are needed when working with table views
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //this will eventually be self.movies
        return movies.count
    }
    
    //This function gets call per row. So if we get 50 rows, this function gets call 50 times
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // IMPORTANT CONCEPT: what dequeue is going to do is recycle existing cells that are OFFview, and if there are none, it will create a new cell
        // this is to account for showing lots of cells. To avoid running out of memory
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        
        let movie = movies[indexPath.row]
        let title = movie["title"] as! String
        let synopsis = movie["overview"] as! String
        
        let baseURL = "https://image.tmdb.org/t/p/w500"
        let posterPath = movie["poster_path"] as! String
        let postURL = URL(string: baseURL + posterPath)
        
        //the question mark represents a Swift Optional. It is used to account for Nil values
        //this is titleLabel BECAUSE that is the name we used in the outlet in MovieCell class
        cell.titleLabel?.text = title
        cell.synopsisLabel?.text = synopsis
        
        //af exists now because I imported alamofireimage.
        //I"m using an exclamation mark to account for nils
        cell.posterView.af.setImage(withURL: postURL!)
        
        return cell
    }
    
    // the creation() of an array of dictionaries[String:Any]
    @IBOutlet weak var tableView: UITableView!
    var movies = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
        // Do any additional setup after loading the view.
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]

                    // TODO: Get the array of movies
                    // TODO: Store the movies in a property to use elsewhere
                    // TODO: Reload your table view data
                 
                 //you have to cast the results to an array of dictionaries
                 self.movies = dataDictionary["results"] as! [[String:Any]]
                
                 //you always have to update your view in order to get the values
                 self.tableView.reloadData()
                 
             }
        }
        task.resume()
    }


}

