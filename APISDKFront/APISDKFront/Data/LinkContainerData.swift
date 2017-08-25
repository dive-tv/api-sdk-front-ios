//
//  LinkContainerData.swift
//  SDKFrontiOS
//
//  Created by Jonathan Castro Miguel on 24/10/16.
//  Copyright © 2016 Tagsonomy. All rights reserved.
//

import Foundation
import SwiftyJSON

class LinkContainerData : ContainerData{
    
    var url : String;
    var source : Source?;
    
    init(data: JSON){
        
        //validate variables
        self.url = data["url"].object as! String;
        
        let _source = data["source"];
        
        //TODO: Source debería no poder ser nil
        if(_source != nil){
            
            do{
                try Source.validate(_source);
                self.source = Source(data: _source);
            }
            catch DataModelErrors.CreateSourceErrors.emptyData{
                DataModelErrors.ShowError(DataModelErrors.CreateSourceErrors.emptyData);
            }
            catch DataModelErrors.CreateSourceErrors.invalidData{
                DataModelErrors.ShowError(DataModelErrors.CreateSourceErrors.invalidData);
            }
            catch{
                DataModelErrors.UnreconigzedError();
            }
        }
        
        super.init();
    }
    
    override class func validate(_ data: JSON?) throws{
        guard let _data = data , _data != nil else{
            try DataModelErrors.ThrowError(DataModelErrors.CreateContainerDataErrors.emptyData);
            return;
        }
        
        guard let _link = _data["url"].object as? String
            , _link != "" else{
                //Throw indavilData Error
                try DataModelErrors.ThrowError(DataModelErrors.CreateContainerDataErrors.invalidData);
                return;
        }
    }
}
