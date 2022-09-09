//
//  AllExtensions.swift
//  Towy
//
//  Created by Usman on 20/06/2022.
//

import UIKit
import GoogleMaps


protocol ObjectSavable {
    func setObjects<Object>(_ object: Object, forKey: String) throws where Object: Encodable
    func getObject<Object>(forKey: String, castTo type: Object.Type) throws -> Object where Object: Decodable
}
enum UserDefaultsKeys : String {
    case isLoggedIn
    case isSubscribeUser
}


extension UIViewController {
    var storyboardId: String {
        return value(forKey: "storyboardIdentifier") as? String ?? "none"
    }
}
extension UIApplication {
    class func getTopViewController() -> UIViewController? {
        let appDelegate = UIApplication.shared.delegate
        if let window = appDelegate!.window {
            return window?.topViewController()
        }
        return nil
    }
}
extension UIWindow {
    func topViewController() -> UIViewController? {
        var top = self.rootViewController
        while true {
            if let presented = top?.presentedViewController {
                top = presented
            } else if let nav = top as? UINavigationController {
                top = nav.visibleViewController
            } else if let tab = top as? UITabBarController {
                top = tab.selectedViewController
            } else {
                break
            }
        }
        return top
    }
}

extension UIView{
    
    func springAnimation(delay:Double = 0.5){
        let oldSize = self.bounds.size.width
        self.bounds.size.width = 0.0
        UIView.animate(withDuration: 1.0, delay: delay, usingSpringWithDamping: 0.3, initialSpringVelocity:0.2, options: [],animations: {
            self.bounds.size.width = oldSize
        }, completion: nil)
    }
    
}


extension UIFont{
    class func mySystemFont(ofSize size: CGFloat) -> UIFont? {
        return UIFont(name: FontNames.UberMoveText.regularFont, size: size) ??  UIFont.systemFont(ofSize: size)
    }
    
    class func myMediumSystemFont(ofSize size: CGFloat) -> UIFont? {
        
        return UIFont(name: FontNames.UberMoveText.mediumFont, size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    class func myBoldSystemFont(ofSize size: CGFloat) -> UIFont? {
        return UIFont(name:FontNames.UberMoveText.boldFont , size: size) ??  UIFont.boldSystemFont(ofSize: size)
    }
    //
    //    func setMediumFont(size:CGFloat){
    //        self.f = UIFont(name: mediumFont, size: size)
    //    }
    //    func setBoldFont(size:CGFloat){
    //        self.font = UIFont(name: boldFont, size: size)
    //    }
    //    func setRegularFont(size:CGFloat){
    //        self.font = UIFont(name: regularFont, size: size)
    //    }
}
extension UINavigationController {
    func popToSpecificController(ofClass: AnyClass, animated: Bool = true) {
        if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
            popToViewController(vc, animated: animated)
        }
        
    }
    
}

extension UserDefaults: ObjectSavable {
    func setObjects<Object>(_ object: Object, forKey: String) throws where Object: Encodable {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(object)
            set(data, forKey: forKey)
        } catch {
            throw ObjectSavableError.unableToEncode
        }
    }
    
    func getObject<Object>(forKey: String, castTo type: Object.Type) throws -> Object where Object:Decodable {
        guard let data = data(forKey: forKey) else { throw ObjectSavableError.noValue }
        let decoder = JSONDecoder()
        do {
            let object = try decoder.decode(type, from: data)
            return object
        } catch {
            throw ObjectSavableError.unableToDecode
        }
    }
}



extension GMSMarker {
    func setIconSize(scaledToSize newSize: CGSize) {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        icon?.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        icon = newImage
    }
}
extension UITextField {
    
    func setPadding(_ amount:CGFloat) {
        self.setLeftPadding(amount)
        self.setRightPadding(amount)
    }
    
    func setLeftPadding(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPadding(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
}


extension UIButton {
    
    func disable() {
        self.isUserInteractionEnabled = false
        self.backgroundColor = UIColor.lightGray.withAlphaComponent(0.8)
    }
    
    func enable(){
        self.isUserInteractionEnabled = true
       // self.backgroundColor = UIColor.init(named: Constants.AssetsColor.ThemeBtnColor.rawValue)?.withAlphaComponent(1)
        self.backgroundColor =  UIColor.black.withAlphaComponent(0.8)

    }
    
}
