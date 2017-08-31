//
//  MovieHeader.swift
//  APISDKFront
//
//  Created by Carlos Bailon Perez on 28/08/2017.
//  Copyright © 2017 Touchvie. All rights reserved.
//

import UIKit
import DiveApi

class MovieHeader: SDKFrontModule {

    @IBOutlet weak var posterImageview: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var typeView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var saveBtnLabel: UILabel!
    @IBOutlet weak var saveView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.posterImageview.image = nil
        self.typeLabel.text = nil
        self.titleLabel.text = nil
        self.directorLabel.text = nil
        self.genresLabel.text = nil
        self.timeLabel.text = nil
        self.saveBtnLabel.text = nil
    }
    
    override func setCardDetail(_ _configModule: ConfigModule, _cardDetail: CardDetailResponse) {
        super.setCardDetail(_configModule, _cardDetail: _cardDetail)
        
        self.posterImageview.downloadImage(_url: cardDetail.image?.thumb, viewMode: .scaleAspectFill, bundle: Bundle(for: self.classForCoder))
        
        self.typeLabel.font = SDKConfiguration.secondaryFont
        self.typeLabel.text = self.cardDetail.type.rawValue.capitalized
        self.typeLabel.textColor = SDKConfiguration.titleColor
        self.typeView.backgroundColor = SDKConfiguration.modulesBackgroundColor
        
        self.titleLabel.text = self.cardDetail.title
        self.titleLabel.font = SDKConfiguration.primaryFont
        self.titleLabel.textColor = SDKConfiguration.titleColor
        
        self.saveView.isHidden = SDKConfiguration.pocketSave
        
        self.saveView.backgroundColor = SDKConfiguration.buttonBackgroundColor
        self.saveBtnLabel.font = SDKConfiguration.buttonFont
        self.saveBtnLabel.textColor = SDKConfiguration.buttonLabelColor
        self.saveBtnLabel.text = ApiSDKUtils.getStringForLocalized(name: "ADD_LIKE_BTN")
        
        
        
        if let catalogContainer = self.cardDetail.getContainer(withModelType: .movie) {
         
            self.directorLabel.font = SDKConfiguration.secondaryFont
            self.directorLabel.textColor = SDKConfiguration.secondaryColor
            self.setProducers()
        
            self.genresLabel.font = SDKConfiguration.secondaryFont
            self.genresLabel.textColor = SDKConfiguration.cliclableColor
            self.setGenres(catalogContainer.data[0].genres)
            
            self.timeLabel.font = SDKConfiguration.secondaryFont
            self.timeLabel.textColor = SDKConfiguration.secondaryColor
            self.setDuration(catalogContainer.data.first!.runtime)
        }
    }
    
    
    private func setProducers(){
        self.directorLabel.text = "";
        
        for relation in self.cardDetail.relations! {
            
            switch relation.type {
                
            case .single:
                let relationDuple = relation as? Single
                
                if relationDuple?.contentType == .directors {
                    
                    var values = [String : String]()
                    for singleRelation in (relationDuple?.data)! {
                        values[singleRelation.title] = singleRelation.cardId
                    }
                    
                    let keysStr = values.keys.joined(separator: ", ")
                    var ranges = [NSRange]()
                    for value in values.keys{
                        let range = (keysStr as NSString).range(of: value)
                        ranges.append(range)
                    }
                    
                    self.directorLabel.text = keysStr
                    //self.directorLabel.selectableRanges = ranges
                    
                    //self.directorLabel.selectionHandler
                    //self.directorLabel.configFontAttributedString(keysStr, textToChange: keysStr, fontName: self.labelProducer.font!);
                    /*self.directorLabel.addSelectableRanges(ranges: ranges, completion: { (value : String) in
                        if let cardId = values[value]{
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "openCardNotification"), object: cardId);
                        }
                    })*/
                }
                break
                
            default:
                break
            }
        }
    }
    
    private func setGenres(_ genres : [String]){
        var text = "";
        var i = 0;
        for genre in genres{
            //let string = "CATALOG_MOVIE_FILTER_GENRE_\(genre.uppercaseString)";
            let string = genre;
            if(i == genres.count - 1){
                //text = text + NSLocalizedString(string, comment: "");
                text = text + NSLocalizedString(string, comment: "");
            }
            else{
                //text = text + NSLocalizedString(string, comment: "") + " · ";
                text = text + NSLocalizedString(string, comment: "") + ", ";
            }
            i += 1;
            
        }
        
        self.genresLabel.text = text;
    }
    
    private func setDuration(_ duration : Int32?){
        
        if let duration = duration, duration != 0 {
            
            self.timeView.isHidden = false
            
            if(duration > 59){
                let hour = duration / 60;
                let minutes = duration - (hour * 60);
                var stringMinutes = "00";
                if(minutes > 0){
                    if(minutes < 10){
                        stringMinutes = "0\(minutes)";
                    }
                    else{
                        stringMinutes = "\(minutes)";
                    }
                    
                }
                self.timeLabel.text = "\(hour)\(NSLocalizedString("HOURS_SHORT", comment: "")) \(stringMinutes)\(NSLocalizedString("MINUTES_SHORT", comment: ""))";
                
            }
            else{
                self.timeLabel.text = "\(duration) \(NSLocalizedString("MINUTES_SHORT", comment: ""))";
            }
        }
        else{
            self.timeView.isHidden = true
        }
        
    }
    @IBAction func touchSaveBtn(_ sender: UIButton) {
        
    }
    
}
