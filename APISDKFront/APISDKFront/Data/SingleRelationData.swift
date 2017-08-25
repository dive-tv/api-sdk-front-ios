//
//  SingleRelationData.swift
//  SDKFrontiOS
//
//  Created by Jonathan Castro Miguel on 23/10/16.
//  Copyright © 2016 Tagsonomy. All rights reserved.
//

import Foundation
import SwiftyJSON

public class SingleRelationData : RelationData{
    
    public var card : MiniCard;
    
    init(data: JSON){
        //validated variables
        self.card = MiniCard(data: data);
    }
    
    public init(card : MiniCard) {
        self.card = card;
    }
    
     override class func validate(_ data: JSON?) throws{
        
        guard let _data = data , _data != nil else{
            try DataModelErrors.ThrowError(DataModelErrors.CreateRelationsDataErrors.emptyData);
            return;
        }
    
        try MiniCard.validate(_data);
    }
}
