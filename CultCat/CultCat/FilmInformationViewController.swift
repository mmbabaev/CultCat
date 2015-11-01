//
//  FilmInformationViewController.swift
//  CultCat
//
//  Created by Михаил on 31.10.15.
//  Copyright © 2015 Mihail. All rights reserved.
//

import UIKit

class FilmInformationViewController: UIViewController {

    var film: Film?
    
    @IBAction func showTrailer(sender: UIButton) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = film?.name
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "startSession" {
            let vc = segue.destinationViewController as! SessionViewController
            vc.filmId = "test"
            vc.film = film
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
