//
//  ContactTableViewCell.swift
//  RGATest
//
//  Created by Lucas Farah on 2/20/17.
//  Copyright © 2017 Awesome Labs. All rights reserved.
//

import UIKit
import Kingfisher

class ContactTableViewCell: UITableViewCell {

    @IBOutlet weak var lblContactName: UILabel!
    @IBOutlet weak var imgvContact: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.imgvContact.roundSquareImage()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
