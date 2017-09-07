//
//  Vehicles.swift
//  APISDKFront
//
//  Created by Miguel Goñi on 07/09/2017.
//  Copyright © 2017 Touchvie. All rights reserved.
//


import UIKit
import DiveApi

class Vehicles: SDKFrontModule, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    @IBOutlet weak var vehiclesMainView: UIView!
    @IBOutlet weak var vehiclesContentLabel: UILabel!
    @IBOutlet weak var vehiclesCollectionView: UICollectionView!
    
    internal var data: Single?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUpCollectionView()
        self.setUpModuleAppearance()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.vehiclesContentLabel.text = nil
    }
    
    //MARK: --SDKFrontModule delegate section
    override class func validate(_ cardDetail : CardDetailResponse) throws {
        
        guard let relations = cardDetail.getRelations(withRelationType: .movieVehicles), relations.data != nil && !relations.data!.isEmpty  else {
            try DataModelErrors.ThrowError(DataModelErrors.CreateCardDetailErrors.emptyData)
            return
        }
    }
    
    override func setCardDetail(_ _configModule: ConfigModule, _cardDetail: CardDetailResponse) {
        
        super.setCardDetail(_configModule, _cardDetail: _cardDetail)
        
        //MARK: -Set up collectionView scrollDirection after pressing "Redo" button
        if let layout = self.vehiclesCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = ApiSDKConfiguration.scrollDirection == .vertical ? .horizontal : .vertical
        }
        
        //MARK: -Set up relations
        if let relations = self.cardDetail.getRelations(withRelationType: .movieVehicles) {
            self.data = relations
            
            //MARK:--Set up "Vehicles" label appearance
            self.vehiclesContentLabel.text = ToolsUtils.getStringForLocalized(name: C.LocalizedStrings.vehicles).uppercased()
            self.vehiclesContentLabel.font = ApiSDKConfiguration.secondaryFont
            self.vehiclesContentLabel.textColor = ApiSDKConfiguration.titleColor
        }
        self.vehiclesCollectionView.reloadData()
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
                
                let widthScreen = self.vehiclesMainView.bounds.width - (C.SizeAmounts.horizontalInset * 2)
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
        return (self.data?.data?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: C.Cell.castCell, for: indexPath) as! CastCollectionViewCell
        cell.setData(relation: (self.data?.data![indexPath.row])!)
        
        return cell
    }
    
    
    //MARK:--Private sections method
    private func setUpCollectionView () {
        
        self.vehiclesCollectionView.backgroundColor = ApiSDKConfiguration.modulesBackgroundColor
         self.vehiclesCollectionView.register(UINib(nibName: C.Cell.castCollectionViewCell, bundle: Bundle(for: self.classForCoder)), forCellWithReuseIdentifier: C.Cell.castCell)
        self.vehiclesCollectionView.delegate = self
        self.vehiclesCollectionView.dataSource = self
    }
    
    private func setUpModuleAppearance () {
    
        self.vehiclesMainView.backgroundColor = ApiSDKConfiguration.modulesBackgroundColor
    }
    
}
