//
//  Animation.swift
//  Towy
//
//  Created by Usman on 20/06/2022.
//

import Foundation
import UIKit

class AnimationView : UIView{
    
    
    
    
    override func layoutSubviews() {
        springAnimation()
    }
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    func springAnimation(){
        let oldSize = self.bounds.size.width
        self.bounds.size.width = 0.0
        UIView.animate(withDuration: 1.0, delay: 0.5, usingSpringWithDamping: 0.3, initialSpringVelocity:0.2, options: [],animations: {
            self.bounds.size.width = oldSize
        }, completion: nil)
    }
    
}
