//
//  HorizontalModule.swift
//  APISDKFront
//
//  Created by Miguel Goñi on 07/09/2017.
//  Copyright © 2017 Touchvie. All rights reserved.
//

import UIKit
import DiveApi

class HorizontalModule: SDKFrontModule, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    
    @IBOutlet weak var horizontalModuleView: UIView!
    @IBOutlet weak var horizontalModuleLabel: UILabel!
    @IBOutlet weak var horizontalCollectionView: UICollectionView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.horizontalCollectionView.delegate = self
        self.horizontalCollectionView.dataSource = self
        
        self.setUpModuleAppearance()
    }
    

    override func setCardDetail(_ _configModule: ConfigModule, _cardDetail: CardDetailResponse) {
        
        super.setCardDetail(_configModule, _cardDetail: _cardDetail)
       
        
        if let layout = self.horizontalCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = ApiSDKConfiguration.scrollDirection == .vertical ? .horizontal : .vertical
        }
    }
    
    //MARK:--UICollectionView data source
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: C.Cell.horizontalModuleWithTitleId, for: indexPath) 
        
        return cell
    }
    
    //MARK:--UIcollectionView layout section
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: C.SizeAmounts.verticalInset, left: C.SizeAmounts.horizontalInset, bottom: C.SizeAmounts.verticalInset, right: C.SizeAmounts.horizontalInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return C.SizeAmounts.cellMargin
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout {
            
            if flowLayout.scrollDirection == .vertical {
                
                let widthScreen = self.sectionDelegate!.getParentSize(indexPath: self.indexPath).width - (C.SizeAmounts.horizontalInset * 2)
                let cellWidth = (widthScreen / 2) - (C.SizeAmounts.cellMargin * 2) - C.SizeAmounts.cellMargin
                let cellHeight = (cellWidth * 211) / 110
                
                return CGSize (width: cellWidth, height: cellHeight)
                
            }else{
                return CGSize(width: 110, height: 211)
            }
        }
        
        return .zero
    }
    
    //MARK:--Private implementation
    private func setUpModuleAppearance() {
        self.horizontalCollectionView.backgroundColor = ApiSDKConfiguration.modulesBackgroundColor
        self.horizontalModuleView.backgroundColor = ApiSDKConfiguration.modulesBackgroundColor
    }
}
