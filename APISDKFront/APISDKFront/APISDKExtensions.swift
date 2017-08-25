//
//  Extensions.swift
//  SDKFrontiOS
//
//  Created by Carlos Bailon Perez on 08/06/2017.
//  Copyright © 2017 Touchvie. All rights reserved.
//


//MARK: UIColor



extension UIColor {
    
    class func diveOffYellowColor() -> UIColor {
        return UIColor(red: 247.0 / 255.0, green: 215.0 / 255.0, blue: 59.0 / 255.0, alpha: 1.0)
    }
    
    class func diveWhiteColor() -> UIColor {
        return UIColor(white: 255.0 / 255.0, alpha: 1.0)
    }
    
    class func diveSeafoamBlueColor() -> UIColor {
        return UIColor(red: 93.0 / 255.0, green: 196.0 / 255.0, blue: 182.0 / 255.0, alpha: 1.0)
    }
    
    class func diveDarkGreyTwoColor() -> UIColor {
        return UIColor(red: 49.0 / 255.0, green: 50.0 / 255.0, blue: 51.0 / 255.0, alpha: 1.0)
    }
    
    class func diveWarmGreyColor(alpha : CGFloat? = nil) -> UIColor {
        return UIColor(white: 144.0 / 255.0, alpha: alpha != nil ? alpha! : 1.0);
    }
    
    class func divePaleGreyColor() -> UIColor {
        return UIColor(red: 232.0 / 255.0, green: 234.0 / 255.0, blue: 238.0 / 255.0, alpha: 1.0)
    }
    
    class func divePaleGreyTwoColor() -> UIColor {
        return UIColor(red: 244.0 / 255.0, green: 246.0 / 255.0, blue: 249.0 / 255.0, alpha: 1.0)
    }
    
    class func diveTealGreenColor() -> UIColor {
        return UIColor(red: 39.0 / 255.0, green: 155.0 / 255.0, blue: 139.0 / 255.0, alpha: 1.0)
    }
    
    class func diveTealGreenColorTwo() -> UIColor {
        return UIColor(red: 38.0 / 255.0, green: 155.0 / 255.0, blue: 139.0 / 255.0, alpha: 1.0)
    }
    
    class func diveDarkGreyColor(alpha : CGFloat? = nil) -> UIColor {
        return UIColor(red: 28.0 / 255.0, green: 29.0 / 255.0, blue: 29.0 / 255.0, alpha: alpha != nil ? alpha! : 1.0)
    }
    
    class func diveBlackColor(alpha : CGFloat? = nil) -> UIColor {
        return UIColor(white: 38.0 / 255.0, alpha: alpha != nil ? alpha! : 1.0)
    }
    
    class func diveBlackTwoColor() -> UIColor{
        return UIColor(red: 14 / 255.0, green: 14 / 255.0, blue: 14 / 255.0, alpha: 1.0)
    }
    
    class func diveBlackShadow(alpha : CGFloat? = nil) -> UIColor {
        return UIColor(red: 14 / 255.0, green: 14 / 255.0, blue: 14 / 255.0, alpha: 0.3)
    }
}


//MARK: UIFont


extension UIFont {
    
    class func diveLatoRegularFont(_ _size : CGFloat) -> UIFont? {
        return UIFont(name: "Lato-Regular", size: _size);
    }
    
    class func diveLatoLightFont(_ _size : CGFloat) -> UIFont? {
        return UIFont(name: "Lato-Light", size: _size);
    }
    
    class func diveLatoSemiBoldFont(_ _size : CGFloat) -> UIFont? {
        return UIFont(name: "Lato-Semibold", size: _size)
    }
}




