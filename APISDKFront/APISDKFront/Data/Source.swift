//
//  SourceData.swift
//  SDKFrontiOS
//
//  Created by Jonathan Castro Miguel on 15/10/16.
//  Copyright © 2016 Tagsonomy. All rights reserved.
//

import Foundation
import SwiftyJSON

public class Source : Validatable{
    public var name : String?;
    public var url : String?;
    public var disclaimer : String?;
    public var image : String?;
    
    init(data:JSON){
        
        //validated variables
        //self.name = data["name"].object as! String;
        
        if let _name = data["name"].object as? String , _name != ""{
            self.name = _name;
        }
        
        //non validated variables
        if let _url = data["url"].object as? String , _url != ""{
            self.url = _url;
        }
        
        if let _disclaimer = data["disclaimer"].object as? String , _disclaimer != "" {
            self.disclaimer = _disclaimer;
        }
        
        if let _image = data["image"].object as? String , _image != ""{
            self.image = _image;
        }
    }
    
    class func validate(_ data: JSON?) throws{
        
        guard let _data = data , _data != nil else{
            try DataModelErrors.ThrowError(DataModelErrors.CreateSourceErrors.emptyData);
            return;
        }
        
        /*if(_data["name"].object as? String == nil){
            //Throw indavilData Error
            try DataModelErrors.ThrowError(DataModelErrors.CreateImageErrors.invalidData);
        }*/
        
    }
}
