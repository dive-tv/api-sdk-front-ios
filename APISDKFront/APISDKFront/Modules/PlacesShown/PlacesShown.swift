//
//  PlacesShown.swift
//  APISDKFront
//
//  Created by Miguel Goñi on 06/09/2017.
//  Copyright © 2017 Touchvie. All rights reserved.
//

import UIKit
import DiveApi

class PlacesShown: SDKFrontModule, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var locationCollectionView: UICollectionView!
    @IBOutlet weak var locationMainView: UIView!
    
    internal var locationData: Duple?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUpCollectionView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.locationLabel.text = nil
    }

    override class func validate(_ cardDetail : CardDetailResponse) throws {
        
        guard let relations = cardDetail.getRelations(withRelationType: .movieLocations), relations.data != nil && !relations.data!.isEmpty  else {
            try DataModelErrors.ThrowError(DataModelErrors.CreateCardDetailErrors.emptyData)
            return
        }
    }
    
    override func setCardDetail(_ _configModule: ConfigModule, _cardDetail: CardDetailResponse) {
    
         super.setCardDetail(_configModule, _cardDetail: _cardDetail)
        
        //MARK: -Set up collectionView scrollDirection after pressing "Redo" button
        if let layout = self.locationCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = ApiSDKConfiguration.scrollDirection == .vertical ? .horizontal : .vertical
        }
        
        self.locationMainView.backgroundColor = ApiSDKConfiguration.modulesBackgroundColor
        //MARK: - Set up relations
        if let relations = self.cardDetail.getRelations(withRelationType: .movieLocations) {
            
            self.locationData = relations
            self.locationLabel.text = ToolsUtils.getStringForLocalized(name: C.LocalizedStrings.location).uppercased()
            self.locationLabel.textColor = ApiSDKConfiguration.titleColor
            self.locationLabel.font = ApiSDKConfiguration.secondaryFont
        }
        self.locationCollectionView.reloadData()
    }
    
    //MARK:--Collectionview layout section
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: C.SizeAmounts.verticalInset, left: C.SizeAmounts.horizontalInset, bottom: C.SizeAmounts.verticalInset, right: C.SizeAmounts.horizontalInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return C.SizeAmounts.cellMargin
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout {
            
            if flowLayout.scrollDirection == .vertical {
                
                let widthScreen = self.locationMainView.bounds.width - (C.SizeAmounts.horizontalInset * 2)
                let cellWidth = (widthScreen / 2) - (C.SizeAmounts.cellMargin * 2) - C.SizeAmounts.cellMargin
                let cellHeight = (cellWidth * 211) / 110
                
                return CGSize (width: cellWidth, height: cellHeight)
                
            }else{
                
                return CGSize(width: 110, height: 211)
            }
            
        }
        
        return .zero
    }
    
    //MARK:-- Collection view datasource and delegate section
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.locationData?.data?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: C.Cell.castCell, for: indexPath) as! CastCollectionViewCell
        
        cell.setData(relation: (self.locationData?.data![indexPath.row])!)
        
        return cell
    }
    
    //MARK:--Private implementation
    func setUpCollectionView () {
        
        self.locationCollectionView.backgroundColor = ApiSDKConfiguration.modulesBackgroundColor
        self.locationCollectionView.register(UINib(nibName: C.Cell.castCollectionViewCell, bundle: Bundle(for: self.classForCoder)), forCellWithReuseIdentifier: C.Cell.castCell)
        self.locationCollectionView.delegate = self
        self.locationCollectionView.dataSource = self
       
    }
    
}
