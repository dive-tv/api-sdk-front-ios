//
//  Cast.swift
//  APISDKFront
//
//  Created by Miguel Goñi on 05/09/2017.
//  Copyright © 2017 Touchvie. All rights reserved.
//

import UIKit
import DiveApi

class Cast: HorizontalModule {
    
    //MARK:--Variable that holds all the data of thos module
     internal var dataCast : Duple?
    
    //MARK:--Validation module
    override class func validate(_ cardDetail : CardDetailResponse) throws {
        
        guard let relations = cardDetail.getRelations(withRelationType: .casting), relations.data != nil && !relations.data!.isEmpty  else {
            try DataModelErrors.ThrowError(DataModelErrors.CreateCardDetailErrors.emptyData)
            return
        }
    }
    
    //MARK:--Set up details for the card
    override func setCardDetail(_ _configModule: ConfigModule, _cardDetail: CardDetailResponse) {
        super.setCardDetail(_configModule, _cardDetail: _cardDetail)
        
        //MARK: - Set up relations
        if let relations = self.cardDetail.getRelations(withRelationType: .casting) {
            
            self.dataCast = relations
            self.horizontalCollectionView.register(UINib(nibName: "HorizontalListWithTitleCollectionViewCell", bundle: Bundle(for: self.classForCoder)), forCellWithReuseIdentifier:  C.Cell.horizontalModuleWithTitleId)
            
            //MARK:--Set up title for the module
            self.horizontalModuleLabel.text = ToolsUtils.getStringForLocalized(name: C.LocalizedStrings.cast)
            self.horizontalModuleLabel.font = ApiSDKConfiguration.secondaryFont
            self.horizontalModuleLabel.textColor = ApiSDKConfiguration.titleColor
        }
        self.horizontalCollectionView.reloadData()
    }
    
    //MARK:--Collectionview datasource method
   override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.dataCast?.data?.count)!
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: C.Cell.horizontalModuleWithTitleId, for: indexPath) as! HorizontalListWithTitleCollectionViewCell
        cell.setData(relation: (self.dataCast?.data![indexPath.row].from)!)
        
        return cell
    }
}
