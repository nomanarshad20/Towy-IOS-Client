//
//  HomeVC.swift
//  Towy
//
//  Created by user on 26/07/2022.
//

import UIKit

class HomeVC: UIViewController {
    // MARK: Outlets

    @IBOutlet var photoSliderView: PhotoSliderView!
    @IBOutlet weak var clcDashBoard:UICollectionView!
    @IBOutlet weak var clcDashBoardHeight:NSLayoutConstraint?

    
    
    let homeVM = HomeVM()

    // MARK: View Methods
    override func viewDidLoad() {
        registerXib()
    }
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setUI()
//    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setUI()
    }

    
    func setUI(){

        homeVM.setDashBoard(photoSliderView: photoSliderView)
       // self.clcDashBoard.register(UINib(nibName: "DashboardCVCell", bundle: nil), forCellWithReuseIdentifier: "DashboardCVCell")

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
