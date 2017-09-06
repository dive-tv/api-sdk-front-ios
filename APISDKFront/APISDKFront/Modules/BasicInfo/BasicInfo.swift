//
//  BasicInfo.swift
//  APISDKFront
//
//  Created by Miguel Goñi on 06/09/2017.
//  Copyright © 2017 Touchvie. All rights reserved.
//

import UIKit
import DiveApi


class BasicInfo: SDKFrontModule, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout   {
    
    @IBOutlet weak var basicDataLabel: UILabel!
    @IBOutlet weak var basicDataCollectionView: UICollectionView!
    @IBOutlet weak var basicDataView: UIView!
    
    fileprivate var data = [ListingData]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUpCollectionView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.basicDataLabel.text = nil
    }
    
    
    override class func validate(_ cardDetail : CardDetailResponse) throws {
        
        guard let container =  cardDetail.getContainer(withModelType: .basicData), container.data.count > 0  else {
            try DataModelErrors.ThrowError(DataModelErrors.CreateCardDetailErrors.emptyData)
            return
        }
    }
    
    override func setCardDetail(_ _configModule: ConfigModule, _cardDetail: CardDetailResponse) {
        
        super.setCardDetail(_configModule, _cardDetail: _cardDetail)
        
        //MARK: -Set up collectionView scrollDirection after pressing "Redo" button
        if let layout = self.basicDataCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = ApiSDKConfiguration.scrollDirection == .vertical ? .horizontal : .vertical
        }
        
        self.basicDataView.backgroundColor = ApiSDKConfiguration.modulesBackgroundColor
        
         if let container = self.cardDetail.getContainer(withModelType: .basicData) {
            
            //MARK:--Retrieve data in order to print content inside cell
            self.data = container.data
        
             self.layoutIfNeeded()
            self.basicDataCollectionView.reloadData()
           
        }
        
        //MARK: -Set up background basic data color and title look
        self.basicDataLabel.text = ToolsUtils.getStringForLocalized(name: C.LocalizedStrings.basicInfo).uppercased()
        self.basicDataLabel.font = ApiSDKConfiguration.secondaryFont
        self.basicDataLabel.textColor = ApiSDKConfiguration.titleColor
        self.basicDataView.backgroundColor = ApiSDKConfiguration.modulesBackgroundColor
    }
    
    //MARK:--Collectionview layout section
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: C.SizeAmounts.verticalInset, left: C.SizeAmounts.horizontalInset, bottom: C.SizeAmounts.verticalInset, right: C.SizeAmounts.horizontalInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return C.SizeAmounts.cellMargin
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 320, height: 44)
    }
    
    //MARK:-- Collection view datasource and delegate section
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: C.Cell.basicInfocell, for: indexPath) as! BasicInfoCollectionViewCell
        
        cell.setData(data: self.data[indexPath.row])
        
        return cell
    }
    
    private func setUpCollectionView() {
        self.basicDataCollectionView.backgroundColor = ApiSDKConfiguration.modulesBackgroundColor
        self.basicDataCollectionView.register(UINib(nibName: C.Cell.basicInfoCollectionViewCell, bundle: Bundle(for: self.classForCoder)), forCellWithReuseIdentifier: C.Cell.basicInfocell)
        self.basicDataCollectionView.delegate = self
        self.basicDataCollectionView.dataSource = self
    }
}
