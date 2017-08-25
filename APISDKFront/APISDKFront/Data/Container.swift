//
//  ContainerData.swift
//  SDKFrontiOS
//
//  Created by Jonathan Castro Miguel on 15/10/16.
//  Copyright © 2016 Tagsonomy. All rights reserved.
//

import Foundation
import SwiftyJSON

public class Container : NSObject, Validatable{

    public var type : ContainerType;
    public var contentType : ContainerContentType;
    public var data = [ContainerData]();
    
    init(data: JSON){
        
        //validated variables
        self.type = ContainerType(rawValue: data["type"].object as! String)!;
        self.contentType = ContainerContentType(rawValue: data["content_type"].object as! String)!;
        
        super.init()
        //TODO: researdch the posibility to delete the switch
        
        //create a type of class for validate the data
        let appName = Bundle(for: self.classForCoder).infoDictionary!["CFBundleName"] as! String;
        let _containerClass = NSClassFromString(appName + "." + (self.type.rawValue).capitalized  + "ContainerData") as! ContainerData.Type;

        for item in data["data"].array!{
            do{
                try _containerClass.validate(item);
                
                switch self.type {
                case ContainerType.Text:
                    self.data.append(TextContainerData(data: item));
                case ContainerType.Listing:
                     self.data.append(ListingContainerData(data: item));
                case ContainerType.Rating:
                     self.data.append(RatingContainerData(data: item));
                case ContainerType.Map:
                     self.data.append(MapContainerData(data: item));
                case ContainerType.Link:
                     self.data.append(LinkContainerData(data: item));
                case ContainerType.Image:
                     self.data.append(ImageContainerData(data: item));
                case ContainerType.Awards:
                     self.data.append(AwardsContainerData(data: item));
                case ContainerType.Catalog:
                     self.data.append(CatalogContainerData(data: item));
                case ContainerType.Seasons:
                     self.data.append(SeasonsContainerData(data: item));
                }
                
            }
            catch DataModelErrors.CreateContainerDataErrors.emptyData{
                DataModelErrors.ShowError(DataModelErrors.CreateContainerDataErrors.emptyData);
            }
            catch DataModelErrors.CreateContainerDataErrors.invalidData{
                DataModelErrors.ShowError(DataModelErrors.CreateContainerDataErrors.invalidData);
            }
            catch{
                DataModelErrors.UnreconigzedError();
            }
        }

        
        
    }
    
    class func validate(_ data: JSON?) throws{
        
        guard let _data = data , _data != nil else{
            try DataModelErrors.ThrowError(DataModelErrors.CreateContainerErrors.emptyData);
            return;
        }
        
        guard case let (_type as String, _contentType as String, _containerData as [JSON]) = (_data["type"].object, _data["content_type"].object, _data["data"].array) , _type != "" && _contentType != "" && _containerData.count > 0 else{
            //Throw indavilData Error
            try DataModelErrors.ThrowError(DataModelErrors.CreateContainerErrors.invalidData);
            return;
        }
        
        guard let _containerType = ContainerType(rawValue: _type) else{
            //Throw invalid type of card Error
            try DataModelErrors.ThrowError(DataModelErrors.CreateContainerErrors.invalidContainerType);
            return;
        }
        
        if(ContainerContentType(rawValue: _contentType) == nil){
            //Throw invalid type of card Error
            try DataModelErrors.ThrowError(DataModelErrors.CreateContainerErrors.invalidContainerContentType);
        }
        
        //create a type of class for validate the data
        let appName = Bundle(for: self.classForCoder()).infoDictionary!["CFBundleName"] as! String;
        let _containerClass = NSClassFromString(appName + "." + (_containerType.rawValue).capitalized  + "ContainerData") as! ContainerData.Type;
        
        var validatedContainerData = 0;
        
        for item in _containerData{
            do{
                try _containerClass.validate(item);
                validatedContainerData += 1;
            }
            catch DataModelErrors.CreateContainerDataErrors.emptyData{
                DataModelErrors.ShowError(DataModelErrors.CreateContainerDataErrors.emptyData);
            }
            catch DataModelErrors.CreateContainerDataErrors.invalidData{
                DataModelErrors.ShowError(DataModelErrors.CreateContainerDataErrors.invalidData);
            }
            catch{
                DataModelErrors.UnreconigzedError();
            }
        }
        
        //if there isnt any containerData, the container is invalid
        if(validatedContainerData == 0){
            try DataModelErrors.ThrowError(DataModelErrors.CreateContainerDataErrors.emptyData);
        }
    }
}
