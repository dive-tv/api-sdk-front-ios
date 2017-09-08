//
//  Vehicles.swift
//  APISDKFront
//
//  Created by Miguel Goñi on 07/09/2017.
//  Copyright © 2017 Touchvie. All rights reserved.
//


import UIKit
import DiveApi

class Vehicles: HorizontalModule  {
    
   
    internal var data: Single?

    //MARK: --Validation module
    override class func validate(_ cardDetail : CardDetailResponse) throws {
        
        guard let relations = cardDetail.getRelations(withRelationType: .movieVehicles), relations.data != nil && !relations.data!.isEmpty  else {
            try DataModelErrors.ThrowError(DataModelErrors.CreateCardDetailErrors.emptyData)
            return
        }
    }
    
    override func setCardDetail(_ _configModule: ConfigModule, _cardDetail: CardDetailResponse) {
        
        super.setCardDetail(_configModule, _cardDetail: _cardDetail)
        
        //MARK: -Set up relations
        if let relations = self.cardDetail.getRelations(withRelationType: .movieVehicles) {
            self.data = relations
            self.setUpCollectionView()
            
            //MARK:--Set up "Vehicles" label appearance
            self.horizontalModuleLabel.text = ToolsUtils.getStringForLocalized(name: C.LocalizedStrings.vehicles)
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
        return (self.data?.data?.count)!
    }
    
   override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: C.Cell.horizontalModuleWithTitleId, for: indexPath) as! HorizontalListWithTitleCollectionViewCell
        cell.setData(relation: (self.data?.data![indexPath.row])!)
        
        return cell
    }
    
    //MARK:--Private sections method
    private func setUpCollectionView () {
        
       self.horizontalCollectionView.register(UINib(nibName: C.Cell.horizontalListWithTitleCollectionViewCell, bundle: Bundle(for: self.classForCoder)), forCellWithReuseIdentifier:  C.Cell.horizontalModuleWithTitleId)
    }
}
