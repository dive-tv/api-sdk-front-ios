//
//  DiveFrontSDK.swift
//  SDKFrontiOS
//
//  Created by Carlos Bailon Perez on 29/06/2017.
//  Copyright © 2017 Touchvie. All rights reserved.
//

import SwiftyJSON
import DiveApi

public class APISDKFront: NSObject {
    
    
    public class func pushCardDetail (withCardId cardId: String, withRestDelegate delegate: RestSDKFrontDelegate, inNavigationController navigationController: UINavigationController, bundle : Bundle) {
        
        DiveAPI.configure(withApp: .DIVE, withEnviroment: .pre)
        
        AuthManager.postToken(_userName: "test1@test.es", _password: "e10adc3949ba59abbe56e057f20f883e") { (response, error) in
            
            if response?.body != nil {
                if let path = bundle.path(forResource: "config_type", ofType: "json") {
                    if let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
                        let json = JSON(data: data);
                        if(json != nil && json.error == nil) {
                            let cardDetailJSON = CardDetailJson(styleConfig: nil, restSDKDelegate : delegate, bundle: bundle);
                            cardDetailJSON.loadDataConfig(json).build(cardId, navigationController: navigationController);
                        }
                    }
                } else {
                    fatalError("config_type json don´t find")
                }
            }
            
        }
        
        
    }
}
