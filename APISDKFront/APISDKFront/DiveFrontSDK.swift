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
    
    
    public class func createCardDetail (withCardId cardId: String, withRestDelegate delegate: APISDKDelegate, bundle : Bundle, withConfiguration configuration: ConfigurationAPISDK? = nil, completion: @escaping (Section?) -> Void) {
        if let path = bundle.path(forResource: "config_type", ofType: "json") {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
                let json = JSON(data: data);
                if(json != nil && json.error == nil) {
                    let cardDetailJSON = CardDetailJson(sdkConfiguration: configuration, restSDKDelegate : delegate, bundle: bundle, completion: completion);
                    cardDetailJSON.loadDataConfig(json).build(cardId);
                }
            }
        } else {
            fatalError("config_type json don´t find")
        }
    }
}
