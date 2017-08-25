//
//  Errors.swift
//  SDKFrontiOS
//
//  Created by Jonathan Castro Miguel on 13/10/16.
//  Copyright © 2016 Tagsonomy. All rights reserved.
//

import Foundation

protocol ErrorManager {
    static func ThrowError(_ errorType : Error) throws
    
    static func ShowError(_ errorType : Error)
    
    static func UnreconigzedError()
   
}

