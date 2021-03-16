//
//  PlaceTableViewCell.swift
//  GoogleNotification
//
//  Created by Datamatics on 16/03/21.
//  Copyright © 2021 Datamatics. All rights reserved.
//

import UIKit

class PlaceTableViewCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var discription: UILabel!
    @IBOutlet weak var placeImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
