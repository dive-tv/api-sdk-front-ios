//
//  Extensions.swift
//  SDKFrontiOS
//
//  Created by Carlos Bailon Perez on 08/06/2017.
//  Copyright © 2017 Touchvie. All rights reserved.
//


class SDKConfiguration {
    
    static var backgroundColor: UIColor = .black
    static var modulesBackgroundColor: UIColor = .white
    
    static var titleColor: UIColor = .red
    static var secondaryColor: UIColor = .blue
    static var cliclableColor: UIColor = .yellow
    
    static var buttonLabelColor: UIColor = .brown
    static var buttonBackgroundColor: UIColor = .yellow
    
    static var primaryFont: UIFont = UIFont.systemFont(ofSize: 12)
    static var secondaryFont: UIFont = UIFont.systemFont(ofSize: 10)
    static var buttonFont: UIFont = UIFont.systemFont(ofSize: 9)
    
    static var pocketSave: Bool = false
}

class ApiSDKUtils {
    
    class func getStringForLocalized (name: String) -> String {
        
        return Bundle(for: self).localizedString(forKey: name, value: nil, table: nil)
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




