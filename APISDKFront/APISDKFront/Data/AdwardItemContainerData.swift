//
//  AdwardItemContainerData.swift
//  SDKFrontiOS
//
//  Created by Jonathan Castro Miguel on 24/10/16.
//  Copyright © 2016 Tagsonomy. All rights reserved.
//

import Foundation
import SwiftyJSON

class AdwardItemContainerData : ContainerData{
    
    var title : String;
    var value : String;
    
    init(data: JSON){
        
        //validate variables
        self.title = data["title"].object as! String;
        self.value = data["value"].object as! String;
        
        super.init();
    }
    
    override class func validate(_ data: JSON?) throws{
        guard let _data = data , _data != nil else{
            try DataModelErrors.ThrowError(DataModelErrors.CreateContainerDataErrors.emptyData);
            return;
        }
        
        guard case let (_title as String, _value as String) = (_data["title"].object, _data["value"].object)
            , _title != "" && _value != "" else{
                //Throw indavilData Error
                try DataModelErrors.ThrowError(DataModelErrors.CreateContainerDataErrors.invalidData);
                return;
        }
    }
}
