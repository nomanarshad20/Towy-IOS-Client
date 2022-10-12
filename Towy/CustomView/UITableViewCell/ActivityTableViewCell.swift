//
//  ActivityTableViewCell.swift
//  Towy
//
//  Created by Usman on 27/09/2022.
//

import UIKit

class ActivityTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var lblDate:UILabel!
    @IBOutlet weak var lblStatus:UILabel!
    @IBOutlet weak var imgTitle:UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setData(obj:PastBooking){
        
        //yyyy-MM-dd'T'HH:mm:ssZ
        //MMM d, h:mm a
        self.lblTitle.text = obj.booking_unique_id ?? ""
        self.lblDate.text = dateToShow(strDate: obj.created_at ?? "")
        let status = obj.ride_status ?? 5
        switch status{
        case 0:
            print("")
            self.lblStatus.text = "PKR\(obj.estimated_fare ?? "0") . Cancelled"

        case 1:
            print("")
            self.lblStatus.text = "PKR\(obj.estimated_fare ?? "0") . Cancelled"

        case 2:
            print("")
            self.lblStatus.text = "PKR\(obj.estimated_fare ?? "0") . Rejected"

        case 3:
            print("")
            self.lblStatus.text = "PKR\(obj.estimated_fare ?? "0") . Cancelled"

        case 4:
            print("")
            self.lblStatus.text = "PKR\(obj.estimated_fare ?? "0") . Cancelled"

        case 5:
            print("")
            self.lblStatus.text = "PKR\(obj.estimated_fare ?? "0") . Completed"

        default:
            print("default")
            self.lblStatus.text = "PKR\(obj.estimated_fare ?? "0") . Cancelled"

        }
        //PKR0 . Cancelled
        
    }
    
    func dateToShow(strDate:String) -> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        //yyyy-MM-dd'T'HH:mm:ss.SSS'Z'
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM d, h:mm a"
        
        let date: Date? = dateFormatterGet.date(from: strDate) as Date?
        //        print(dateFormatterPrint.string(from: date! as Date))
        return dateFormatterPrint.string(from: date ?? Date())
    }
}
