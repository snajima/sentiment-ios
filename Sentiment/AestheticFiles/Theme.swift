//
//  Theme.swift
//  Hack Challenge
//
//  Created by Shungo Najima on 12/1/22.
//

import Foundation
import UIKit

extension UIColor
{
    
    class func sageAccent() -> UIColor
    {
        return UIColor(red: 205/255, green: 224/255, blue: 201/255, alpha: 1)
    }

    class func lilacAccent() -> UIColor
    {
        return UIColor(red: 93/255, green: 89/255, blue: 94/255, alpha: 0.2)

    }
    
    class func mintGreenAccent() -> UIColor {
        return UIColor(red: 104/255, green: 178/255, blue: 160/255, alpha: 0.3)
    }
    
    class func sageGreenBackground() -> UIColor {
        return UIColor(red: 205/255, green: 224/255, blue: 201/255, alpha: 0.5)
    }
    
    class func darkGreen() -> UIColor {
        return UIColor(red: 16/255, green: 154/255, blue: 48/255, alpha: 1)
    }
    
    class func profileGreen() -> UIColor {
        return UIColor(red: 80/255, green: 181/255, blue: 158/255, alpha: 1)
    }
    
    class func warmPink() -> UIColor {
        return UIColor(red: 237/255, green: 157/255, blue: 154/255, alpha: 1)
    }
    
    class func warmPink(alpha: CGFloat) -> UIColor {
        return UIColor(red: 237/255, green: 157/255, blue: 154/255, alpha: alpha)
    }
    
    class func softPink() -> UIColor {
        return UIColor(red: 239/255, green: 195/255, blue: 160/255, alpha: 1)
    }
    
    class func veryWarmPink() -> UIColor {
        return UIColor(red: 236/255, green: 138/255, blue: 151/255, alpha: 1)
    }
    
    class func verySoftPink() -> UIColor {
        return UIColor(red: 240/255, green: 214/255, blue: 163/255, alpha: 1)
    }
    
    class func offWhite() -> UIColor {
        return UIColor(red: 236/255, green: 245/255, blue: 249/255, alpha: 1)
    }
    
    class func offWhite2() -> UIColor {
        return UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
    }
}

extension CAGradientLayer {
    static func pinkGradientLayer(in frame: CGRect) -> Self {
        let layer = Self()
        layer.colors = [UIColor.warmPink().cgColor, UIColor.softPink().cgColor]
        layer.frame = frame
        layer.startPoint = CGPoint(x: 0, y: 0)
        layer.endPoint = CGPoint(x: 1, y: 0)
        return layer
    }
    
    static func pinkCircularGradientLayer(in frame: CGRect, cornerRadius: CGFloat) -> Self {
        let layer = Self()
        layer.cornerRadius = cornerRadius
        layer.colors = [UIColor.veryWarmPink().cgColor, UIColor.verySoftPink().cgColor]
        layer.frame = frame
        layer.startPoint = CGPoint(x: 0, y: 0)
        layer.endPoint = CGPoint(x: 1, y: 0)
        return layer
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
