//
//  Overview.swift
//  APISDKFront
//
//  Created by Miguel Goñi on 04/09/2017.
//  Copyright © 2017 Touchvie. All rights reserved.
//

import UIKit
import DiveApi

class Overview: SDKFrontModule {
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var contentText: UITextView!
    @IBOutlet weak var overviewView: UIView!
    @IBOutlet weak var sourceHeaderLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.contentText.text = nil
        self.sourceLabel.text = nil
    }
    
    override func setCardDetail(_ _configModule: ConfigModule, _cardDetail: CardDetailResponse) {
        
        super.setCardDetail(_configModule, _cardDetail: _cardDetail)
        
        //MARK:- Set up background, colors and fonts
        self.overviewView.backgroundColor = ApiSDKConfiguration.modulesBackgroundColor
        
        //MARK:- Set up content text

        if let overViewContainer = self.cardDetail.getContainer(withModelType: .overview) {
            
            //MARK:-- Set up content text inside the Synopsis module
            self.contentText.font = ApiSDKConfiguration.secondaryFont
            self.contentText.textColor = ApiSDKConfiguration.synopsisTextColor
            self.contentText.backgroundColor = ApiSDKConfiguration.modulesBackgroundColor
            self.contentText.text = overViewContainer.data[0].text
            
            //MARK:-- Set up title in the Synopsis module
            self.headerLabel.text = ToolsUtils.getStringForLocalized(name: C.LocalizedStrings.synopsis).uppercased()
            self.headerLabel.textColor = ApiSDKConfiguration.titleColor
            self.headerLabel.font = ApiSDKConfiguration.secondaryFont
            
            //MARK:-- Set up content of the source
            self.sourceLabel.font =  ApiSDKConfiguration.buttonFont
            self.sourceHeaderLabel.font = ApiSDKConfiguration.buttonFont
            self.sourceHeaderLabel.textColor = ApiSDKConfiguration.greenLabelColor
            self.sourceLabel.textColor = ApiSDKConfiguration.titleColor
            self.sourceLabel.text = overViewContainer.data[0].source?.name
            
            //MARK:-- This method allows the textView of the synopsis to start from the top
            self.setSynopSisTextScroll()
        }
    }
    
    //TODO:--handling url from source still to be defined
    @IBAction func openSource(_ sender: Any) {
    }
    
    private func setSynopSisTextScroll() {
        
        DispatchQueue.main.async {
            
            let desiredOffset = CGPoint(x: 0, y: -self.contentText.contentInset.top)
            self.contentText.setContentOffset(desiredOffset, animated: false)
        }
    }
    
}
