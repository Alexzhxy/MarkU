//
//  FavoritesTableViewCell.swift
//  MarkU
//
//  Created by Zhang, Alex on 10/15/15.
//  Copyright © 2015 Zhang, Alex. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {


    @IBOutlet weak var position: UILabel!
    
    @IBOutlet weak var timeStamp: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
