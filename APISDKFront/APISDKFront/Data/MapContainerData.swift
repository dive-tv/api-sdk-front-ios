//
//  MapContainerData.swift
//  SDKFrontiOS
//
//  Created by Jonathan Castro Miguel on 24/10/16.
//  Copyright © 2016 Tagsonomy. All rights reserved.
//

import Foundation
import SwiftyJSON

class MapContainerData : ContainerData{
    
    var latitude : Float;
    var longitude : Float;
    var zoom : Float;
    
    init(data: JSON){
        
        //validate variables
        self.latitude = data["latitude"].floatValue;
        self.longitude = data["longitude"].floatValue;
        self.zoom = data["zoom"].floatValue;
        
        super.init();
    }
    
    override class func validate(_ data: JSON?) throws{
        guard let _data = data , _data != nil else{
            try DataModelErrors.ThrowError(DataModelErrors.CreateContainerDataErrors.emptyData);
            return;
        }
        
        if(_data["latitude"].float == nil || _data["longitude"].float == nil || _data["zoom"].float == nil){
            //Throw indavilData Error
            try DataModelErrors.ThrowError(DataModelErrors.CreateContainerDataErrors.invalidData);
        }
    }
}

