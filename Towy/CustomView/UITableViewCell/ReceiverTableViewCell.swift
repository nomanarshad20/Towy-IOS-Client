//
//  ReceiverTableViewCell.swift
//  OYLA
//
//  Created by Macbook Pro on 16/07/2021.
//

import UIKit

class ReceiverTableViewCell: UITableViewCell {

    @IBOutlet weak var lblMessage:UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
    
}
