//
//  RateAndReviewVC.swift
//  Towy
//
//  Created by Usman on 12/09/2022.
//

import UIKit
import Cosmos
class RateAndReviewVC: UIViewController {
    
    
    @IBOutlet weak var ratingView:CosmosView!
    @IBOutlet weak var txtDescription:UITextView!
    @IBOutlet weak var btnSubmit:UIButton!
    
   // var delegate:RatingDelegate!
    var ride:NewRide!
    var rating = ""
    var booking : BookingInfo? = nil
    var rateVm = RateAndReviewVM()

    override func viewDidLoad() {
        super.viewDidLoad()
//        ratingView.didFinishTouchingCosmos = { rating in
//            self.rating = "\(rating)"
//        }
    }
    
    @IBAction func submittTapped(_ sender:UIButton){
        
        guard let data = self.booking else{return}
        if data.driver_id != nil && data.id != nil {
            rateVm.bookingId = "\(data.id ?? 0)"
            rateVm.driverId = "\(data.driver_id ?? 0)"
            rateVm.message = self.txtDescription.text
            rateVm.rating = ratingView.rating
            rateVm.callRatingApi { dd in
                UtilitiesManager.shared.showAlertWithAction(self, message: dd.message ?? "Rating Save Successfully", title: Key.APP_NAME, buttons: ["OK"]) { index in
                    
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.moveToTabbarVC()

//                        HIDE_CUSTOM_LOADER()
//                        self.navigationController?.popToRootViewController(animated: true)
                    }
            }
        }
        /*
        SHOW_CUSTOM_LOADER()
        delay(seconds: 5) {
            UtilitiesManager.shared.showAlertWithAction(self, message: "Rating Save Successfully", title: Key.APP_NAME, buttons: ["OK"]) { index in
                HIDE_CUSTOM_LOADER()
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
        
        if rating != "" && ride != nil{
           // SHOW_CUSTOM_LOADER()
//            //"user_id":UtilityManager.manager.getId(),,"type": 2
//            RatingManager.manager.RateAndReview(params:["passenger_id":ride.passenger_id ?? 0,"rating":rating,"message":txtDescription.text ?? "","booking_id":ride.booking_id ?? 0]) { (bool, err) in
//                if bool{
//                    DispatchQueue.main.async {
//                        self.delegate.didRatePassenger()
//                        self.navigationController?.popViewController(animated: true)
//                    }
//                }else{
//                    UtilityManager.manager.showAlertView(title: Constants.APP_NAME, message: err ?? "something went wrong")
//                }
//            }
        }else{
//            NotificationCenter.default.post(name: NSNotification.Name(Constants.NotificationObservers.DRIVER_RATED_THE_CUSTOMER.rawValue), object: nil, userInfo: nil)
//            self.navigationController?.popViewController(animated: true)
//            UtilityManager.manager.showAlertView(title: Constants.APP_NAME, message: Constants.RATE_FIRST)
        }
       */
       
    }
    
    @IBAction func backTapped(_ sender:UIButton){
       // delegate.didCancelRating()
        self.navigationController?.popViewController(animated: true)
    }
    
}
