//
//  User.swift
//  SDKFrontiOS
//
//  Created by Jonathan Castro Miguel on 24/10/16.
//  Copyright © 2016 Tagsonomy. All rights reserved.
//

import Foundation
import SwiftyJSON

public class User : NSObject, Validatable{
    
    public var isLiked : Bool;
    
    init(data: JSON){
        //validated variables
        self.isLiked = data["is_liked"].boolValue;
    }
    
    class func validate(_ data: JSON?) throws{
        
        guard let _data = data , _data != nil else{
            try DataModelErrors.ThrowError(DataModelErrors.CreateUserErrors.emptyData);
            return;
        }
        
        if(_data["is_liked"].bool == nil){
            try DataModelErrors.ThrowError(DataModelErrors.CreateUserErrors.invalidData);
        }
    }
}
