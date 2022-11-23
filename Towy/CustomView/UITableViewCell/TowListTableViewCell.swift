//
//  TowListTableViewCell.swift
//  Towy
//
//  Created by user on 13/08/2022.
//

import UIKit

class TowListTableViewCell: UITableViewCell {

    
    @IBOutlet weak var img:UIImageView!
    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var lblSubtitle:UILabel!
    @IBOutlet weak var lblPrice:UILabel!
    @IBOutlet weak var lblTime:UILabel!

    
    var obj : TowDatum?{
        didSet{
            //UtilitiesManager.shared.setImage(url: obj., img: <#T##UIImageView#>)
            self.lblTitle.text = obj?.name ?? ""
            self.lblTime.text = "\("\(obj?.driver_reach_time_in_minutes ?? 0)") min"
//            self.lblTitle.text = obj?.name ?? ""
//            self.lblTitle.text = obj?.name ?? ""
            self.lblPrice.text = "PKR \(obj?.estimated_fare ?? 0)"
            //self.lblTime.text = "\(obj?. ?? 0)"

        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
