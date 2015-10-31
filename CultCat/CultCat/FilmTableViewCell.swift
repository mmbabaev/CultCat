//
//  FilmTableViewCell.swift
//  CultCat
//
//  Created by Михаил on 31.10.15.
//  Copyright © 2015 Mihail. All rights reserved.
//

import UIKit

class FilmTableViewCell: UITableViewCell {

    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var filmName: UILabel!
    
    @IBOutlet weak var rateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
