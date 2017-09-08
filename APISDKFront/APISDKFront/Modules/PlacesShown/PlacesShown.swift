//
//  PlacesShown.swift
//  APISDKFront
//
//  Created by Miguel Goñi on 06/09/2017.
//  Copyright © 2017 Touchvie. All rights reserved.
//

import UIKit
import DiveApi

class PlacesShown: HorizontalModule  {
    
   
    //MARK:--Variable that holds all the data of this module
    internal var locationData: Duple?
    
    
    //MARK:--Validantion module
    override class func validate(_ cardDetail : CardDetailResponse) throws {
        
        guard let relations = cardDetail.getRelations(withRelationType: .movieLocations), relations.data != nil && !relations.data!.isEmpty  else {
            try DataModelErrors.ThrowError(DataModelErrors.CreateCardDetailErrors.emptyData)
            return
        }
    }
    //MARK:--Set up card detail content
    override func setCardDetail(_ _configModule: ConfigModule, _cardDetail: CardDetailResponse) {
    
         super.setCardDetail(_configModule, _cardDetail: _cardDetail)
        
       
        //MARK: - Set up relations
        if let relations = self.cardDetail.getRelations(withRelationType: .movieLocations) {
            
            self.locationData = relations
            self.setUpCollectionView()
            self.horizontalModuleLabel.text = ToolsUtils.getStringForLocalized(name: C.LocalizedStrings.location)
            self.horizontalModuleLabel.font = ApiSDKConfiguration.secondaryFont
            self.horizontalModuleLabel.textColor = ApiSDKConfiguration.titleColor

        }
        self.horizontalCollectionView.reloadData()
    }
    
    
    //MARK:-- Collection view datasource and delegate section
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return C.Amounts.horizontalNumberofSections
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.locationData?.data?.count)!
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: C.Cell.horizontalModuleWithTitleId, for: indexPath) as! HorizontalListWithTitleCollectionViewCell
        cell.setData(relation: (self.locationData?.data![indexPath.row].from)!)
        
        return cell
    }
    
    //MARK:--Private implementation
    func setUpCollectionView() {
        self.horizontalCollectionView.register(UINib(nibName: C.Cell.horizontalListWithTitleCollectionViewCell, bundle: Bundle(for: self.classForCoder)), forCellWithReuseIdentifier:  C.Cell.horizontalModuleWithTitleId)
    }
}
