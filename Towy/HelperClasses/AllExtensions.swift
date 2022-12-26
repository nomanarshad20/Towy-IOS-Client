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

extension UIView {
    /// animate the border width
    func animateBorderWidth(toValue: CGFloat, duration: Double) -> CABasicAnimation {
        let widthAnimation = CABasicAnimation(keyPath: "borderWidth")
        widthAnimation.fromValue = layer.borderWidth
        widthAnimation.toValue = toValue
        widthAnimation.duration = duration
        return widthAnimation
    }
    
    /// animate the scale
    func animateScale(toValue: CGFloat, duration: Double) -> CABasicAnimation {
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 1.0
        scaleAnimation.toValue = toValue
        scaleAnimation.duration = duration
        scaleAnimation.repeatCount = .infinity
        scaleAnimation.isRemovedOnCompletion = false
        scaleAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        return scaleAnimation
    }
    
    func pulsate(animationDuration: CGFloat) {
        
        var animationGroup = CAAnimationGroup()
        animationGroup = CAAnimationGroup()
        animationGroup.duration = animationDuration
        animationGroup.repeatCount = Float.infinity
        
        let newLayer = CALayer()
        newLayer.bounds = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        newLayer.cornerRadius = self.frame.width/2
        newLayer.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        newLayer.cornerRadius = self.frame.width/2
        
        animationGroup.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.default)
        
        animationGroup.animations = [animateScale(toValue: 6.0, duration: 2.0),
                                     animateBorderWidth(toValue: 1.2, duration: animationDuration)]
        newLayer.add(animationGroup, forKey: "pulse")
        self.layer.cornerRadius = self.frame.width/2
        self.layer.insertSublayer(newLayer, at: 0)
    }
}


class DictionaryEncoder {
    private let jsonEncoder = JSONEncoder()

    /// Encodes given Encodable value into an array or dictionary
    func encode<T>(_ value: T) throws -> Any where T: Encodable {
        let jsonData = try jsonEncoder.encode(value)
        return try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments)
    }
}

class DictionaryDecoder {
    private let jsonDecoder = JSONDecoder()

    /// Decodes given Decodable type from given array or dictionary
    func decode<T>(_ type: T.Type, from json: Any) throws -> T where T: Decodable {
        let jsonData = try JSONSerialization.data(withJSONObject: json, options: [])
        return try jsonDecoder.decode(type, from: jsonData)
    }
}

extension Double {
    func rounded(digits: Int) -> Double {
        let multiplier = pow(10.0, Double(digits))
        return (self * multiplier).rounded() / multiplier
    }
}
