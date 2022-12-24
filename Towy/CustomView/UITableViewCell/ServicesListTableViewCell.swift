//
//  ServicesListTableViewCell.swift
//  Towy
//
//  Created by Usman on 15/11/2022.
//

import UIKit

class ServicesListTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lblName : UILabel!
    @IBOutlet weak var lblDes : UILabel!
    @IBOutlet weak var lblPrice : UILabel!
    @IBOutlet weak var imgService : UIImageView!

    @IBOutlet weak var stackBtn : UIStackView!
    @IBOutlet weak var btnPlus : UIButton!
    @IBOutlet weak var btnMinus : UIButton!
    @IBOutlet weak var lblQuantity : UILabel!

    
    var obj : Services?{
        didSet{
            
            //5,2
            if obj?.is_quantity_allowed ?? 0  == 1{
                self.stackBtn.isHidden = false
            }else{
                self.stackBtn.isHidden = true
            }
            UtilitiesManager.shared.setImage(url: obj?.image ?? "", img: imgService)
            self.lblName.text = obj?.name ?? ""
            self.lblDes.text = obj?.description ?? ""
            self.lblPrice.text = "\(obj?.base_rate ?? "") $"
            self.lblQuantity.text = "\(obj?.quantity ?? 1)"
            
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
