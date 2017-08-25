//
//  TextContainerData.swift
//  SDKFrontiOS
//
//  Created by Jonathan Castro Miguel on 20/10/16.
//  Copyright © 2016 Tagsonomy. All rights reserved.
//

import Foundation
import SwiftyJSON

class TextContainerData : ContainerData{
    
    var text : String;
    var source : Source?;
    
    init(data: JSON){
        
        //validate variables
        self.text = data["text"].object as! String;
        
        let _source = data["source"];
        
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
        
        if(_data["text"].object as? String == nil){
            //Throw indavilData Error
            try DataModelErrors.ThrowError(DataModelErrors.CreateContainerDataErrors.invalidData);
        }
    }
}
