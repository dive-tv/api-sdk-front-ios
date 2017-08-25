//
//  ModuleValidator.swift
//  SDKFrontiOS
//
//  Created by Sergio Girao on 16/9/16.
//  Copyright © 2016 Tagsonomy. All rights reserved.
//

import Foundation
import SwiftyJSON
import DiveApi

public class ModuleValidator : NSObject{
  
    /**
     This method check if the data have all the information for a module.
     
     - parameter data:       The data with all the info
     - parameter moduleName: The name of the module to get the information the module needs
     
     - returns: Return true if the data have the information the module needs or false if not
     */
    func validate(_ data : CardDetailResponse, moduleType : String)->Bool{
       
        //For Testing
        //let cardDetail = CardDetail(_cardId: "ID", _type: "movie", _locale: "ES_es", _title: "title");
        
        let appName = Bundle(for: self.classForCoder).infoDictionary!["CFBundleName"] as! String;
        let moduleClass = NSClassFromString(appName + "." + moduleType) as! SDKFrontModule.Type
        
        do{
            try moduleClass.validate(data);
            return true;
        }
        catch{
            print("An Error Ocurred");
            return false;
        }
    }
    
  
}
