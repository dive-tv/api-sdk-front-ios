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
    
        self.horizontalModuleLabel.text = relation.title
       
        self.imageView.resetImage()
        self.horizontalModulePicture.isHidden = true
        
        if(relation.image != nil){
            ToolsImageDownloader.downloadImage(url: relation.image!.thumb, disk: false) { (image : UIImage?) in
                if(image != nil){
                    self.imageView.setImage(image: image!, x: CGFloat(relation.image?.anchorX == nil ? 50 : relation.image!.anchorX), y: CGFloat(relation.image?.anchorY == nil ? 50 : relation.image!.anchorY))
                }else{
                    self.horizontalModulePicture.isHidden = false
                }
            }
        }else{
            self.horizontalModulePicture.isHidden = false
        }
    }
    
    
    @IBAction func openCard(_ sender: Any) {
        
    }
    
}
