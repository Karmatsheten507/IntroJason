//
//  JasonTableViewCell.swift
//  IntroJasonTableView
//
//  Created by Nando Septian Husni on 5/28/18.
//  Copyright © 2018 imastudio. All rights reserved.
//

import UIKit

class JasonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var LabelName: UILabel!
    
    @IBOutlet weak var LabelCountry: UILabel!
    
    @IBOutlet weak var LabelAmount: UILabel!
    
    @IBOutlet weak var LabelUse: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
