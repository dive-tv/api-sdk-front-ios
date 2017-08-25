//
//  SeasonContainerData.swift
//  SDKFrontiOS
//
//  Created by Jonathan Castro Miguel on 24/10/16.
//  Copyright © 2016 Tagsonomy. All rights reserved.
//

import Foundation
import SwiftyJSON

public class SeasonsContainerData : ContainerData{
    
    public var seasonIndex : Int;
    public var chapters = [Chapter]();
    public var creators : String?;
    public var image : SDKFrontImage?;
    public var year : Int;
    
    init(data: JSON){
        
        //validated variables
        self.seasonIndex = data["season_index"].intValue;
        self.year = data["year"].intValue;
        
        if let _chapters = data["chapters"].array , _chapters.count > 0{
            for _chapter in _chapters{
                do{
                    try Chapter.validate(_chapter);
                    self.chapters.append(Chapter(data: _chapter));
                }
                catch DataModelErrors.CreateChapterErrors.emptyData{
                    DataModelErrors.ShowError(DataModelErrors.CreateChapterErrors.emptyData);
                    //Some recover code
                }
                catch DataModelErrors.CreateChapterErrors.invalidData{
                    DataModelErrors.ShowError(DataModelErrors.CreateChapterErrors.invalidData);
                    //Some recover code
                }
                catch{
                    //Throw error for validate
                    DataModelErrors.UnreconigzedError();
                    //Some recorver code
                }
            }
        }
        
        //non validated variables
        if let _creators = data["creators"].object as? String , _creators != ""{
            self.creators = _creators;
        }
        
        //Create image
        let _image = data["image"];
        
        if(_image != nil){
            do{
                //validate data
                try SDKFrontImage.validate(_image);
                self.image = SDKFrontImage(data: _image);
            }
            catch DataModelErrors.CreateImageErrors.emptyData{
                DataModelErrors.ShowError(DataModelErrors.CreateImageErrors.emptyData);
                //Some recover code
            }
            catch DataModelErrors.CreateImageErrors.invalidData{
                DataModelErrors.ShowError(DataModelErrors.CreateImageErrors.invalidData);
                //Some recover code
            }
            catch{
                //Throw error for validate
                DataModelErrors.UnreconigzedError();
                //Some recorver code
            }
        }
        
        super.init();
    }
    
    override class func validate(_ data: JSON?) throws{
        guard let _data = data , _data != nil else{
            try DataModelErrors.ThrowError(DataModelErrors.CreateContainerDataErrors.emptyData);
            return;
        }
        
        guard let _ = _data["chapters"].array, _data["season_index"].int != nil && _data["year"].int != nil else{
            try DataModelErrors.ThrowError(DataModelErrors.CreateContainerDataErrors.invalidData);
            return;
        }
    }
}

