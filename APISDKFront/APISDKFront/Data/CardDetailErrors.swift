//
//  CardDetailErrors.swift
//  SDKFrontiOS
//
//  Created by Jonathan Castro Miguel on 13/10/16.
//  Copyright © 2016 Tagsonomy. All rights reserved.
//

import Foundation

internal class CardDetailErrors : ErrorManager{
    
    fileprivate static var ErrorMessages : [String : String] = [
        "UnrecognizableError" : "ERROR: an unrecognizable error has occurred",
        "CreateCardDetailRenderErrors" : "ERROR: The data for create a CardDetailRender is invalid"
    ]
    
    internal enum CreateCardDetailRenderErrors : Error{
        case emptyData
        case invalidData
    }
    
    //MARK: ERROR MANAGER PROTOCOL IMPLEMENTATION
    internal class func ThrowError(_ errorType : Error) throws{
        throw errorType;
    }
    
    internal class func ShowError(_ errorType : Error){
        print(ErrorMessages[String(describing: errorType.self)]);
        print(String(describing: errorType.self) + "." + String(describing: errorType));
    }
    
    internal class func UnreconigzedError(){
        print(ErrorMessages["UnrecognizableError"])
    }
}
