//
//  DupleRelationData.swift
//  SDKFrontiOS
//
//  Created by Jonathan Castro Miguel on 23/10/16.
//  Copyright © 2016 Tagsonomy. All rights reserved.
//

import Foundation
import SwiftyJSON

public class DupleRelationData : RelationData{
    
    public var relType : String;
    public var from : MiniCard;
    public var to : MiniCard?;
    
    init(data: JSON){
        //validated variables
        self.relType = data["rel_type"].object as! String;
        self.from = MiniCard(data: data["from"]);
        
        let _to = data["to"];
        
        if(_to != nil){
            do{
                try MiniCard.validate(_to);
                self.to = MiniCard(data: _to);
            }
            catch DataModelErrors.CreateMiniCardErrors.emptyData{
                DataModelErrors.ShowError(DataModelErrors.CreateMiniCardErrors.emptyData);
            }
            catch DataModelErrors.CreateMiniCardErrors.invalidData{
                DataModelErrors.ShowError(DataModelErrors.CreateMiniCardErrors.invalidData);
            }
            catch DataModelErrors.CreateMiniCardErrors.invalidTypeOfCard{
                DataModelErrors.ShowError(DataModelErrors.CreateMiniCardErrors.invalidTypeOfCard);
            }
            catch{
                DataModelErrors.UnreconigzedError();
            }
        }
    }
    
    
    public init(relType : String, from : MiniCard, to : MiniCard) {
        
        self.relType = relType;
        self.from = from;
        self.to = to;
        
        super.init();

    }
    
    override class func validate(_ data: JSON?) throws{
        guard let _data = data , _data != nil else{
            try DataModelErrors.ThrowError(DataModelErrors.CreateRelationsDataErrors.emptyData);
            return;
        }
        
        guard case let (_relType as String, _from as JSON) = (_data["rel_type"].object, _data["from"])
            , _relType != ""else{
                //Throw indavilData Error
                try DataModelErrors.ThrowError(DataModelErrors.CreateRelationsDataErrors.invalidData);
                return;
        }
        
        if(_relType.isEmpty){
            //Throw invalid type of card Error
            try DataModelErrors.ThrowError(DataModelErrors.CreateRelationsDataErrors.invalidRelationContentType);
        }

        
        try MiniCard.validate(_from);
    }
}
