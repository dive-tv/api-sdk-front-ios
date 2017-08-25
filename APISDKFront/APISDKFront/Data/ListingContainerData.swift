//
//  ListingContainerData.swift
//  SDKFrontiOS
//
//  Created by Jonathan Castro Miguel on 24/10/16.
//  Copyright © 2016 Tagsonomy. All rights reserved.
//

import Foundation
import SwiftyJSON

class ListingContainerData : ContainerData{
    
    var text : String;
    var value : String;
    
    init(data: JSON){
        
        //validate variables
        self.text = data["text"].object as! String;
        self.value = data["value"].object as! String;
        
        super.init();
    }
    
    override class func validate(_ data: JSON?) throws{
        guard let _data = data , _data != nil else{
            try DataModelErrors.ThrowError(DataModelErrors.CreateContainerDataErrors.emptyData);
            return;
        }
        
        guard case let (_text as String, _value as String) = (_data["text"].object, _data["value"].object)
            , _text != "" && _value != "" else{
                //Throw indavilData Error
                try DataModelErrors.ThrowError(DataModelErrors.CreateContainerDataErrors.invalidData);
                return;
        }
    }
}
