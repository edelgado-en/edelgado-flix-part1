//
//  MovieDetailsViewController.swift
//  Assignment1
//
//  Created by Enrique Delgado on 9/8/22.
//

import UIKit
import AlamofireImage

class MovieDetailsViewController: UIViewController {
    
    

    @IBOutlet weak var backDropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    var movie = [String:Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = movie["title"] as? String
        synopsisLabel.text = movie["overview"] as? String
        
        let baseURL = "https://image.tmdb.org/t/p/w500"
        let posterPath = movie["poster_path"] as! String
        let postURL = URL(string: baseURL + posterPath)
        
        //af exists now because I imported alamofireimage.
        //I"m using an exclamation mark to account for nils
        posterView.af.setImage(withURL: postURL!)
        
        let backDropPath = movie["backdrop_path"] as! String
        let backDropURL = URL(string: baseURL + backDropPath)
        
        backDropView.af.setImage(withURL: backDropURL!)
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
