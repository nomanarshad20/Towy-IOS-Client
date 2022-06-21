//
//  ControllerNavigation.swift
//  Towy
//
//  Created by Usman on 20/06/2022.
//

import Foundation
import UIKit

class ControllerNavigation{
    
    static let shared = ControllerNavigation()
    
    func pushVC(of type: SViewController) {
        let sb = UIStoryboard(name: type.storyboardName, bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: type.vcIdentifier)
        UIApplication.getTopViewController()?.navigationController?.pushViewController(vc, animated: true)
    }
    func getVC(of type: SViewController) -> UIViewController {
        let sb = UIStoryboard(name: type.storyboardName, bundle: nil)
        return sb.instantiateViewController(withIdentifier: type.vcIdentifier)
    }
    
    func presentVC(of type: SViewController, _ presentationStyle: UIModalPresentationStyle = .fullScreen) {
        let sb = UIStoryboard(name: type.storyboardName, bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: type.vcIdentifier)
        vc.modalPresentationStyle = presentationStyle
        UIApplication.getTopViewController()?.present(vc, animated: true, completion: nil)
    }
    
    
}
