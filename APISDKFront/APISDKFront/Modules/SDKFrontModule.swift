//
//  Module.swift
//  SDKFrontiOS
//
//  Created by Jonathan Castro Miguel on 13/09/16.
//  Copyright © 2016 Touchvie. All rights reserved.
//

import UIKit
import DiveApi

open class SDKFrontModule : UICollectionViewCell, Validatable{
    
    internal var cardDetail : CardDetailResponse!;
   
    internal var configModule : ConfigModule!;
    internal var maxItems = 10;
    internal var visibleItems = 15;
    
    weak var sectionDelegate : SectionDelegate?;
    weak var cardDelegate : CardDetailDelegate?;
    
    /**
     sets the data for the cell and configures the cell.
     
     - parameter _configModule: the configuration of the module
     - parameter _cardData:     the data to display in the cell
     */
    
  
    
    func setCardDetail (_ _configModule : ConfigModule, _cardDetail : CardDetailResponse) {
        
        self.cardDetail = _cardDetail;
        self.configModule = _configModule;
    }
    
    
    func setIndexPathsAnalytics(indexPath : IndexPath, indexPathsAnalytics : [IndexPath]){
        
        
    }
    
    class func validate(_ data: CardDetailResponse) throws {
        
        /*guard case let (trees as [JSON]) = (data["trees"].array)
            where trees.count > 0 else {
                
                //ThrowError
                try CardDetailErrors.ThrowError(CardDetailErrors.CreateCardDetailErrors.invalidData);
                return;
        }*/
    }
    
   

}
