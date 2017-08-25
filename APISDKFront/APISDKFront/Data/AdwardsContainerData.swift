//
//  AdwardsContainerData.swift
//  SDKFrontiOS
//
//  Created by Jonathan Castro Miguel on 24/10/16.
//  Copyright © 2016 Tagsonomy. All rights reserved.
//

import Foundation
import SwiftyJSON

class AwardsContainerData : ContainerData{
    
    var title : String;
    var nominee = [AdwardItemContainerData]();
    var winner = [AdwardItemContainerData]();
    
    init(data: JSON){
        
        //validate variables
        self.title = data["title"].object as! String;
        
        let _nominee = data["nominee"].arrayValue;
        
        for _item in _nominee{
            do{
                try AdwardItemContainerData.validate(_item);
                self.nominee.append(AdwardItemContainerData(data: _item));
            }
            catch DataModelErrors.CreateContainerDataErrors.emptyData{
                DataModelErrors.ShowError(DataModelErrors.CreateContainerDataErrors.emptyData);
            }
            catch DataModelErrors.CreateContainerDataErrors.invalidData{
                DataModelErrors.ShowError(DataModelErrors.CreateContainerDataErrors.invalidData);
            }
            catch{
                DataModelErrors.UnreconigzedError();
            }
        }
        
        let _winner = data["winner"].arrayValue;
        
        for _item in _winner{
            do{
                try AdwardItemContainerData.validate(_item);
                self.winner.append(AdwardItemContainerData(data: _item));
            }
            catch DataModelErrors.CreateContainerDataErrors.emptyData{
                DataModelErrors.ShowError(DataModelErrors.CreateContainerDataErrors.emptyData);
            }
            catch DataModelErrors.CreateContainerDataErrors.invalidData{
                DataModelErrors.ShowError(DataModelErrors.CreateContainerDataErrors.invalidData);
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
        
        guard case let (_title as String, _nominee as [JSON], _winner as [JSON]) = (_data["title"].object, _data["nominee"].array, _data["winner"].array)
            , _title != "" && (_nominee.count > 0 || _winner.count > 0) else{
                //Throw indavilData Error
                try DataModelErrors.ThrowError(DataModelErrors.CreateContainerDataErrors.invalidData);
                return;
        }
    }
}
