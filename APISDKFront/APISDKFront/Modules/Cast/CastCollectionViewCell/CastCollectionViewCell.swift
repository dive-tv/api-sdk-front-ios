//
//  CastCollectionViewCell.swift
//  APISDKFront
//
//  Created by Miguel Goñi on 05/09/2017.
//  Copyright © 2017 Touchvie. All rights reserved.
//

import UIKit
import DiveApi

class CastCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageViewCast: AnchorImage!
    @IBOutlet weak var viewName: UIView!
    @IBOutlet weak var labelName: UILabel!

    @IBOutlet weak var imageNoPhoto: UIImageView!
    
    private var data: DupleData!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //MARK:--Set up action in orher to handle how to open a card
    
    @IBAction func openCard(_ sender: Any) {
        
    }
    
   
    func setData(relation : DupleData){
    
        self.data = relation
        self.labelName.text = relation.from.title
        
        self.imageViewCast.resetImage()
        self.imageNoPhoto.isHidden = true
        
        if(relation.from.image != nil){
            ToolsImageDownloader.downloadImage(url: relation.from.image!.thumb, disk: false) { (image : UIImage?) in
                if(image != nil){
                    self.imageViewCast.setImage(image: image!, x: CGFloat(relation.from.image?.anchorX == nil ? 50 : relation.from.image!.anchorX), y: CGFloat(relation.from.image?.anchorY == nil ? 50 : relation.from.image!.anchorY))
                }else{
                    self.imageNoPhoto.isHidden = false
                }
            }
        }else{
            self.imageNoPhoto.isHidden = false
        }
    }
    

}
