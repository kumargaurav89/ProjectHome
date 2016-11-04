//
//  PropertyListTableViewCell.swift
//  Home
//
//  Created by Iqbal Singh on 2016-05-16.
//  Copyright © 2016 Kumar. All rights reserved.
//

import UIKit

class PropertyListTableViewCell: UITableViewCell {
    
    
    
    
    @IBOutlet var picImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
