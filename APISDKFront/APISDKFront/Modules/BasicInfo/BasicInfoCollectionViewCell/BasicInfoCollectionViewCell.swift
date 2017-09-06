//
//  BasicInfoCollectionViewCell.swift
//  APISDKFront
//
//  Created by Miguel Goñi on 06/09/2017.
//  Copyright © 2017 Touchvie. All rights reserved.
//

import UIKit
import DiveApi

class BasicInfoCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var basicDataTitleLabel: UILabel!
    @IBOutlet weak var basicDataContentLabel: UILabel!
    @IBOutlet weak var basicInfoView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(data: ListingData) {
        
        //MARK: -Set up data cell
        self.basicDataTitleLabel.text = data.text
        self.basicDataContentLabel.text = data.value
        
        //MARK: -Set up cell background color
        self.basicInfoView.backgroundColor = ApiSDKConfiguration.modulesBackgroundColor
        self.basicDataTitleLabel.font = ApiSDKConfiguration.buttonFont
        self.basicDataTitleLabel.textColor = ApiSDKConfiguration.titleColor
        
        self.basicDataContentLabel.font = ApiSDKConfiguration.buttonFont
        self.basicDataContentLabel.textColor = ApiSDKConfiguration.synopsisTextColor
        
     
    }
}
