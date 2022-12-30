//
//  TagsCollectionViewCell.swift
//  CameraApp
//
//  Created by Usman on 24/10/2022.
//

import UIKit

class TagsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var viewLabel : UIView!
/*
    public var obj: CaptionModel! {
        didSet {
            selectedTag(caption: obj)
            self.lblTitle.text = obj.caption
        }
        
    }
    */
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.viewLabel.layer.borderWidth = 1
        self.viewLabel.layer.borderColor = UIColor.black.cgColor

    }
    /*
    func selectedTag(caption: CaptionModel){
        
        if caption.isSelected{
            self.viewLabel.backgroundColor = .black
            self.lblTitle.textColor = .white
            //return viewFolder
        }else{
            self.viewLabel.backgroundColor = .white
            self.lblTitle.textColor = .black
            //return viewFolder
        }
        
    }
    */
}
