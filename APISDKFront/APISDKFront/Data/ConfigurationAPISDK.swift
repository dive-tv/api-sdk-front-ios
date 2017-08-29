//
//  ConfigSDK.swift
//  APISDKFront
//
//  Created by Carlos Bailon Perez on 28/08/2017.
//  Copyright © 2017 Touchvie. All rights reserved.
//

import Foundation



open class ConfigurationAPISDK : NSObject{
    
    open var scrollDirection : UICollectionViewScrollDirection = .vertical
    open var primaryFont: UIFont = UIFont.systemFont(ofSize: 12)
    open var secondaryFont: UIFont = UIFont.systemFont(ofSize: 10)
    open var buttonFont: UIFont = UIFont.systemFont(ofSize: 9)
    
    open var backgroundColor: UIColor = .black
    open var modulesBackgroundColor: UIColor = .white
    
    open var titleColor: UIColor = .red
    open var secondaryColor: UIColor = .blue
    open var cliclableColor: UIColor = .yellow
    
    
    open var buttonLabelColor: UIColor = .brown
    open var buttonBackgroundColor: UIColor = .yellow
    
    open var pocketSave: Bool = false
}
