//
//  TravelProductData.swift
//  SDKFrontiOS
//
//  Created by Jonathan Castro Miguel on 14/10/16.
//  Copyright © 2016 Tagsonomy. All rights reserved.
//

import Foundation
import SwiftyJSON

internal class TravelProduct : Product{
    var country : String?;
    var region : String?;
    var city : String?;
    var address : String?
    var postalCode : String?;
    var rating : Float?;
    
    
    override init(data: JSON){
        
        //non validate variables
        if let _country = data["country"].object as? String , _country != ""{
            self.country = _country;
        }
        
        if let _region = data["region"].object as? String , _region != ""{
            self.region = _region;
        }
        
        if let _city = data["city"].object as? String , _city != ""{
            self.city = _city;
        }
        
        if let _address = data["address"].object as? String , _address != ""{
            self.address = _address;
        }
        
        if let _postalCode = data["postalCode"].object as? String , _postalCode != ""{
            self.postalCode = _postalCode;
        }
        
        if let _rating = data["rating"].float{
            self.rating = _rating;
        }
        
        super.init(data: data);
    }
    
    override class func validate(_ data: JSON?) throws{
        
        try super.validate(data);
    }
}
