//
//  DriverListTableViewCell.swift
//  Towy
//
//  Created by Usman on 15/11/2022.
//

import UIKit

class DriverListTableViewCell: UITableViewCell {

    @IBOutlet weak var imgDriver : UIImageView!
    
    @IBOutlet weak var lblService : UILabel!
    @IBOutlet weak var lblPrice : UILabel!
    @IBOutlet weak var lblTime : UILabel!
    @IBOutlet weak var lblName : UILabel!

    
    var obj : DriverList?{
        didSet{
            //UtilitiesManager.shared.setImage(url: obj. ?? "", img: imgDriver)
            self.lblName.text = obj?.first_name ?? ""
            self.lblPrice.text = "\(obj?.total_fare ?? 0)$"
            self.lblTime.text = "\(obj?.distance ?? 0.0)KM"
            guard let services = obj?.service else{return}
            self.lblService.text = getServices(arr: services)
            
            /*
            if obj?.is_quantity_allowed ?? 0  == 1{
                self.stackBtn.isHidden = false
            }else{
                self.stackBtn.isHidden = true
            }
            UtilitiesManager.shared.setImage(url: obj?.image ?? "", img: imgService)
            self.lblName.text = obj?.name ?? ""
            self.lblDes.text = obj?.description ?? ""
            self.lblPrice.text = "PKR \(obj?.base_rate ?? "")"
            self.lblQuantity.text = "\(obj?.quantity ?? 1)"
            */
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
    
    func getServices(arr:[DriverServices]) -> String{
        var name = ""
        for obj in arr{
            if name.isEmpty{
                name = "\(obj.service_name ?? "")"
            }else{
                name = name+","+"\(obj.service_name ?? "")"
            }
        }
        return name
    }
    
}
