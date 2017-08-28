//
//  MovieHeader.swift
//  APISDKFront
//
//  Created by Carlos Bailon Perez on 25/08/2017.
//  Copyright © 2017 Touchvie. All rights reserved.
//

import UIKit
import DiveApi

class MovieHeader: SDKFrontModule {
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setCardDetail(_ _configModule: ConfigModule, _cardDetail: CardDetailResponse) {
        super.setCardDetail(_configModule, _cardDetail: _cardDetail)
        
        self.topLabel.text = "\(self.bounds.width)"
        self.rightLabel.text = "\(self.bounds.height)"
    }

}
