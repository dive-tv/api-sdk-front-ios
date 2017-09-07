//
//  HorizontalListCollectionViewCell.swift
//  APISDKFront
//
//  Created by Miguel Goñi on 07/09/2017.
//  Copyright © 2017 Touchvie. All rights reserved.
//

import DiveApi

class HorizontalListWithTitleCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: AnchorImage!
    @IBOutlet weak var horizontalModuleView: UIView!
    @IBOutlet weak var horizontalModuleLabel: UILabel!
    @IBOutlet weak var horizontalModulePicture: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //MARK:--Set up content for the cell
     func setData(relation : CardDetailResponse){
    
    }
    
    
    @IBAction func openCard(_ sender: Any) {
        
    }
    
}
