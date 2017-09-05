//
//  ConfigSDK.swift
//  APISDKFront
//
//  Created by Carlos Bailon Perez on 28/08/2017.
//  Copyright © 2017 Touchvie. All rights reserved.
//

import Foundation



open class ApiSDKConfiguration {
    
    open static var scrollDirection : UICollectionViewScrollDirection = .vertical
    open static var minimunSpaceCells : CGFloat = 10
    open static var separators : Bool = true
    
    
    open static var primaryFont: UIFont = UIFont.systemFont(ofSize: 11)
    open static var secondaryFont: UIFont = UIFont.systemFont(ofSize: 10)
    open static var buttonFont: UIFont = UIFont.systemFont(ofSize: 9)
    
    open static var backgroundColor: UIColor = .black
    open static var modulesBackgroundColor: UIColor = .white
    
    open static var titleColor: UIColor = .red
    open static var secondaryColor: UIColor = .blue
    open static var cliclableColor: UIColor = .yellow
    open static var synopsisTextColor: UIColor = .lightGray
    open static var greenLabelColor = UIColor(red: 39/255, green: 155/255, blue: 139/255, alpha: 1.0)
    
    
    
    open static var buttonLabelColor: UIColor = .brown
    open static var buttonBackgroundColor: UIColor = .yellow
    
    open static var pocketSave: Bool = false
}
