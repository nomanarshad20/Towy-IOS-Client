//
//  TripTotalTableViewCell.swift
//  Towy
//
//  Created by Usman on 13/09/2022.
//

import UIKit

class TripTotalTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var lblAmount:UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
