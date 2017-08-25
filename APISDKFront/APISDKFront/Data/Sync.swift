//
//  Sync.swift
//  SDKFrontiOS
//
//  Created by Jonathan Castro Miguel on 22/10/16.
//  Copyright © 2016 Tagsonomy. All rights reserved.
//

import Foundation
import SwiftyJSON

public class Sync : NSObject, Validatable{
    
    public var isSynchronizable : Bool;
    public var audioLangs = [String]();
    public var tvGrid : TVGrid?;
    
    init(data: JSON){
        
        //validated variables
        self.isSynchronizable = data["is_synchronizable"].boolValue;
        
        //non validated variables
        if let _audioLangs = data["audio_langs"].array , _audioLangs.count > 0{
            for item in _audioLangs{
                if let _audiolang = item.object as? String , _audiolang != ""{
                    self.audioLangs.append(_audiolang);
                }
            }
        }
        
        //non validated variables
        let _tvGrid = data["tv_grid"];
        
        if(_tvGrid != nil){
            
            do{
                try TVGrid.validate(_tvGrid);
                self.tvGrid = TVGrid(data: _tvGrid);
            }
            catch DataModelErrors.CreateTVGridErrors.emptyData{
                DataModelErrors.ShowError(DataModelErrors.CreateSourceErrors.emptyData);
            }
            catch{
                DataModelErrors.UnreconigzedError();
            }
        }

        
        super.init();
    }
    
    class func validate(_ data: JSON?) throws{
        guard let _data = data , _data != nil else{
            try DataModelErrors.ThrowError(DataModelErrors.CreateSyncErrors.emptyData);
            return;
        }
        
        if(_data["is_synchronizable"].bool == nil){
            try DataModelErrors.ThrowError(DataModelErrors.CreateSyncErrors.invalidData);
        }
    }
}
