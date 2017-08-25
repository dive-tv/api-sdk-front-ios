//
//  CardDetailJson.swift
//  SDKFrontiOS
//
//  Created by Jonathan Castro Miguel on 13/09/16.
//  Copyright © 2016 Touchvie. All rights reserved.
//

import Foundation
import SwiftyJSON

class CardDetailJson : BaseCardDetailBuilder{
    
    // MARK: Public Methods
    /**
     This method receive a json configured by the user.
     
     - parameter json: The json with the sections and modules the user wants to show
     
     - returns: Returns the CardDetailJson
     */
    func loadDataConfig(_ json : JSON) -> CardDetailJson{
        self.configJSON = json.dictionaryObject as! [String : String];
        return self;
    }
    
}
