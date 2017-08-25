//
//  TVEvent.swift
//  SDKFrontiOS
//
//  Created by Jonathan Castro Miguel on 22/10/16.
//  Copyright © 2016 Tagsonomy. All rights reserved.
//

import Foundation
import SwiftyJSON

public class TVGrid : NSObject, Validatable{
    
    public var broadCast = [TVEvent]();
    public var upcoming = [TVEvent]();
   
    
    init(data: JSON){
        
        //validated variables
        if let _events = data["broadcast"].array , _events.count > 0{
            
            for _event in _events{
                do{
                    try TVEvent.validate(_event);
                    self.broadCast.append(TVEvent(data: _event));
                }
                catch DataModelErrors.CreateTVEventErrors.invalidData{
                    DataModelErrors.ShowError(DataModelErrors.CreateTVEventErrors.invalidData);
                    //Some recover code
                }
                catch DataModelErrors.CreateTVEventErrors.emptyData{
                    DataModelErrors.ShowError(DataModelErrors.CreateTVEventErrors.emptyData);
                    //Some recover code
                }
                catch{
                    //Throw error for validate
                    DataModelErrors.UnreconigzedError();
                    //Some recorver code
                }
            }
        }
        
        if let _events = data["upcoming"].array , _events.count > 0{
            
            for _event in _events{
                do{
                    try TVEvent.validate(_event);
                    self.upcoming.append(TVEvent(data: _event));
                }
                catch DataModelErrors.CreateTVEventErrors.invalidData{
                    DataModelErrors.ShowError(DataModelErrors.CreateTVEventErrors.invalidData);
                    //Some recover code
                }
                catch DataModelErrors.CreateTVEventErrors.emptyData{
                    DataModelErrors.ShowError(DataModelErrors.CreateTVEventErrors.emptyData);
                    //Some recover code
                }
                catch DataModelErrors.CreateMiniCardErrors.invalidData{
                    DataModelErrors.ShowError(DataModelErrors.CreateMiniCardErrors.invalidData);
                    //Some recover code
                }
                catch DataModelErrors.CreateMiniCardErrors.emptyData{
                    DataModelErrors.ShowError(DataModelErrors.CreateMiniCardErrors.emptyData);
                    //Some recover code
                }
                catch DataModelErrors.CreateMiniCardErrors.invalidTypeOfCard{
                    DataModelErrors.ShowError(DataModelErrors.CreateMiniCardErrors.emptyData);
                    //Some recover code
                }
                catch{
                    //Throw error for validate
                    DataModelErrors.UnreconigzedError();
                    //Some recorver code
                }
            }
        }
        
        super.init();
    }
    
    class func validate(_ data: JSON?) throws{
        
        guard let _data = data , _data != nil else{
            try DataModelErrors.ThrowError(DataModelErrors.CreateTVGridErrors.emptyData);
            return;
        }
    }
}
