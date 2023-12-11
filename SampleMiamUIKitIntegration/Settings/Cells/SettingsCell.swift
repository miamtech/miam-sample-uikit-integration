//
//  SettingsCell.swift
//  SampleMiamUIKitIntegration
//
//  Created by Walerowicz on 29/11/2023.
//

import UIKit

class SettingsCell: UITableViewCell {

    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var cellPicto: UIImageView!
    @IBOutlet weak var chevronPicto: UIImageView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
