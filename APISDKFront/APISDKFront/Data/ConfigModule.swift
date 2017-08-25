//
//  DataModule.swift
//  SDKFrontiOS
//
//  Created by Sergio Girao on 15/9/16.
//  Copyright © 2016 Tagsonomy. All rights reserved.
//

import UIKit

open class ConfigModule: NSObject {
    
    fileprivate(set) var moduleName : String?;
    fileprivate(set) var targets : [Target]?;
    var isValid : Bool = false;
    
    init(moduleName : String, targets : [Target]? = nil){
        super.init();
        
        self.moduleName = moduleName;
        self.targets = targets;
    }

}
