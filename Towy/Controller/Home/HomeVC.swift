//
//  HomeVC.swift
//  Towy
//
//  Created by user on 26/07/2022.
//

import UIKit
import GoogleMaps
import CoreLocation

class HomeVC: UIViewController , CLLocationManagerDelegate , GMSMapViewDelegate , UIGestureRecognizerDelegate{
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
        manager.delegate = self
        manager.startUpdatingLocation()
        
        registerXib()
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setUI()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        lat  = (location?.coordinate.latitude)!
        long = (location?.coordinate.longitude)!
    }
    
    func setUI(){
        setupMapView()
        homeVM.setDashBoard(photoSliderView: photoSliderView)
       // self.clcDashBoard.register(UINib(nibName: "DashboardCVCell", bundle: nil), forCellWithReuseIdentifier: "DashboardCVCell")
    }
    func setupMapView(){
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 10.0)
        myMapView = GMSMapView.map(withFrame: mapView.frame, camera: camera)
        myMapView.settings.myLocationButton = true
        myMapView.settings.setAllGesturesEnabled(false)
        myMapView.isUserInteractionEnabled  = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(triggerTouchAction))
        myMapView.addGestureRecognizer(tapGesture)
        self.mainView.addSubview(myMapView!)
    }
    @objc func triggerTouchAction(gestureReconizer: UITapGestureRecognizer) {
        ControllerNavigation.shared.pushVC(of: .locationVC)
    }
    func registerXib(){
        self.clcDashBoard.register(UINib(nibName: "DashboardCVCell", bundle: nil), forCellWithReuseIdentifier: "DashboardCVCell")
    }
    //DashboardCVCell
}


extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        LocalData.sharedIntance.dasboardArray.count
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DashboardCVCell", for: indexPath as IndexPath) as! DashboardCVCell
        //cell.obj = self.dashBoardVM.dashBoard?.data.dashboardContent[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        var collectionViewSize = collectionView.frame.size
        collectionViewSize.width = collectionViewSize.width/2.0 - 8
       // collectionViewSize.height = collectionViewSize.width - 100
        return collectionViewSize
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        

    }
    
}
