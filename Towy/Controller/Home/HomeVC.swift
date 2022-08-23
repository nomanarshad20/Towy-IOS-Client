//
//  HomeVC.swift
//  Towy
//
//  Created by user on 26/07/2022.
//

import UIKit
import GoogleMaps
import CoreLocation

class HomeVC: UIViewController , GMSMapViewDelegate , UIGestureRecognizerDelegate{
    // MARK: Outlets
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet var photoSliderView: PhotoSliderView!
    @IBOutlet weak var clcDashBoard:UICollectionView!

    @IBOutlet weak var clcDashBoardHeight:NSLayoutConstraint?

    @IBOutlet weak var mapView: GMSMapView!
    
    var myMapView:GMSMapView!
    var lat  = CLLocationDegrees()
    var long = CLLocationDegrees()
    
    private let manager = CLLocationManager()
    
    let homeVM = HomeVM()

    // MARK: View Methods
    override func viewDidLoad() {
        setupMap()
        registerXib()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setUI()
    }
    func setUI(){
        homeVM.setDashBoard(photoSliderView: photoSliderView)
    }

    func setupMap(){
        // 1
        manager.delegate = self

         // 2
         if CLLocationManager.locationServicesEnabled() {
           // 3
             manager.requestLocation()

           // 4
           mapView.isMyLocationEnabled = true
           mapView.settings.myLocationButton = true
           mapView.isUserInteractionEnabled  = true
           let tapGesture = UITapGestureRecognizer(target: self, action: #selector(triggerTouchAction))
             mapView.addGestureRecognizer(tapGesture)

         } else {
           // 5
             manager.requestWhenInUseAuthorization()
         }
    }
    @objc func triggerTouchAction(gestureReconizer: UITapGestureRecognizer) {
        ControllerNavigation.shared.pushVC(of: .locationVC)
    }
    func registerXib(){
        self.clcDashBoard.register(UINib(nibName: "NewDashBoardCVCell", bundle: nil), forCellWithReuseIdentifier: "NewDashBoardCVCell")
    }
  
    //DashboardCVCell
}


extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        LocalData.sharedIntance.dasboardArray.count
        return homeVM.setDashBoardData().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewDashBoardCVCell", for: indexPath as IndexPath) as! NewDashBoardCVCell
        cell.lblTitle.text = self.homeVM.setDashBoardData()[indexPath.row].title
        cell.img.image = UIImage(named: self.homeVM.setDashBoardData()[indexPath.row].img) 

        //cell.obj = self.dashBoardVM.dashBoard?.data.dashboardContent[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        var collectionViewSize = collectionView.frame.size
        collectionViewSize.width = collectionViewSize.width/4 - 8.0
        collectionViewSize.height = collectionViewSize.width
        return collectionViewSize
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0{
            let vc = ControllerNavigation.shared.getVC(of: .searchLocationVC) as! SearchLocationVC
            vc.CurrentLat   = lat
            vc.CurrentLong = long
            self.navigationController?.pushViewController(vc, animated: true)
//            ControllerNavigation.shared.pushVC(of: .searchLocationVC)
        }

    }
    
}
//
//extension HomeVC : CLLocationManagerDelegate {
//
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//         print("error:: \(error.localizedDescription)")
//    }
//
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        if status == .authorizedWhenInUse {
//            manager.requestLocation()
//        }
//    }
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//
//        if locations.first != nil {
//            print("location:: \(locations.first?.coordinate)")
//            print("last:: \(locations.last?.coordinate)")
//
//            lat  = (locations.first?.coordinate.latitude)!
//            long = (locations.first?.coordinate.longitude)!
//
//            setupMapView()
//        }
//
//    }
//
//}

// MARK: - CLLocationManagerDelegate

//1
extension HomeVC: CLLocationManagerDelegate {
  // 2
  func locationManager(
    _ manager: CLLocationManager,
    didChangeAuthorization status: CLAuthorizationStatus
  ) {
    // 3
    guard status == .authorizedWhenInUse else {
      return
    }
    // 4
    manager.requestLocation()

    //5
    mapView.isMyLocationEnabled = true
    mapView.settings.myLocationButton = true
  }

  // 6
  func locationManager(
    _ manager: CLLocationManager,
    didUpdateLocations locations: [CLLocation]) {
    guard let location = locations.first else {
      return
    }

        lat = location.coordinate.latitude
        long = location.coordinate.longitude
    // 7
    mapView.camera = GMSCameraPosition(
      target: location.coordinate,
      zoom: 15,
      bearing: 0,
      viewingAngle: 0)
    mapView.delegate = self
  }

  // 8
  func locationManager(
    _ manager: CLLocationManager,
    didFailWithError error: Error
  ) {
    print(error)
  }
}

// MARK: - GoogleMapsDelegate


extension HomeVC{
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
       // triggerTouchAction(gestureReconizer: <#T##UITapGestureRecognizer#>)
        print("didTapAt")
        ControllerNavigation.shared.pushVC(of: .locationVC)

    }
}

