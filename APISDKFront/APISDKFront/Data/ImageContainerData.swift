//
//  ImageContainerData.swift
//  SDKFrontiOS
//
//  Created by Jonathan Castro Miguel on 24/10/16.
//  Copyright © 2016 Tagsonomy. All rights reserved.
//

import Foundation
import SwiftyJSON

class ImageContainerData : ContainerData{
    
    var image : SDKFrontImage;
    
    init(image : SDKFrontImage){
        self.image = image;
        super.init();
    }
    
    init(data: JSON){
        
        //validate variables
        self.image = SDKFrontImage(data: data);
        
        super.init();
    }
    
    override class func validate(_ data: JSON?) throws{
        guard let _data = data , _data != nil else{
            try DataModelErrors.ThrowError(DataModelErrors.CreateContainerDataErrors.emptyData);
            return;
        }
        
        try SDKFrontImage.validate(_data);
    }
}
