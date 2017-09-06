//
//  Cast.swift
//  APISDKFront
//
//  Created by Miguel Goñi on 05/09/2017.
//  Copyright © 2017 Touchvie. All rights reserved.
//

import UIKit
import DiveApi

class Cast: SDKFrontModule, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var castLabel: UILabel!
    @IBOutlet weak var castCollectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeightConstrain: NSLayoutConstraint!
    @IBOutlet weak var castMainView: UIView!
    
    internal var dataCast : Duple?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUpCollectionView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.castLabel.text = nil
    }

    
    override class func validate(_ cardDetail : CardDetailResponse) throws {
        
        guard let relations = cardDetail.getRelations(withRelationType: .casting), relations.data != nil && !relations.data!.isEmpty  else {
            try DataModelErrors.ThrowError(DataModelErrors.CreateCardDetailErrors.emptyData)
            return
        }
    }
    
     override func setCardDetail(_ _configModule: ConfigModule, _cardDetail: CardDetailResponse) {
        
        super.setCardDetail(_configModule, _cardDetail: _cardDetail)

        //MARK: -Set up collectionView scrollDirection after pressing "Redo" button
        if let layout = self.castCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = ApiSDKConfiguration.scrollDirection == .vertical ? .horizontal : .vertical
        }
        
        //MARK: -Set up background color
        self.castMainView.backgroundColor = ApiSDKConfiguration.modulesBackgroundColor

        
        //MARK: - Set up relations
        if let relations = self.cardDetail.getRelations(withRelationType: .casting) {
            
            self.dataCast = relations
            
            //MARK: -Set up Cast module title
            self.castLabel.text = ToolsUtils.getStringForLocalized(name: C.LocalizedStrings.cast).uppercased()
            self.castLabel.textColor = ApiSDKConfiguration.titleColor
            self.castLabel.font = ApiSDKConfiguration.secondaryFont
            //self.setUpCollectionViewTitle()
        }
        
          self.castCollectionView.reloadData()
    }
    
    //MARK:-- Collection view datasource and delegate section
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.dataCast?.data?.count)!
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: C.Cell.castCell, for: indexPath) as! CastCollectionViewCell
        cell.setData(relation: (self.dataCast?.data![indexPath.row])!)
        
        return cell
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
                
                let widthScreen = self.castCollectionView.bounds.width - (C.SizeAmounts.horizontalInset * 2)
                let cellWidth = (widthScreen / 2) - (C.SizeAmounts.cellMargin * 2) - C.SizeAmounts.cellMargin
                let cellHeight = (cellWidth * 211) / 110

                return CGSize (width: cellWidth, height: cellHeight)
                
            }else{
                
                return CGSize(width: 110, height: 211)
            }
            
        }
        
        return .zero
    }
    
    func setUpCollectionViewTitle() {
        
        //TODO: - What if there´s no data
        if self.dataCast?.data == nil {
            
            self.collectionViewHeightConstrain.constant = 255
            
        }
    }
    
    private func setUpCollectionView() {
        
        self.castCollectionView.backgroundColor = ApiSDKConfiguration.modulesBackgroundColor
        self.castCollectionView.register(UINib(nibName: C.Cell.castCollectionViewCell, bundle: Bundle(for: self.classForCoder)), forCellWithReuseIdentifier: C.Cell.castCell)
        self.castCollectionView.delegate = self
        self.castCollectionView.dataSource = self
      
    }
}
