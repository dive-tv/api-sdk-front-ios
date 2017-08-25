//
//  MiniCardData.swift
//  SDKFrontiOS
//
//  Created by Jonathan Castro Miguel on 14/10/16.
//  Copyright © 2016 Tagsonomy. All rights reserved.
//

import Foundation
import SwiftyJSON
import DiveApi

public class MiniCard : NSObject, Validatable{

    public var cardId : String;
    public var type : TypeOfCard;
    public var locale : String;
    public var title : String;
    public var subTitle : String?;
    public var image : SDKFrontImage?;
    public var products = [Product]();
    public var paginateKey : String?;
    public var hascontent : Bool;
    public var user : User?;
    
    public var containers = Dictionary<ContainerContentType, Container>();
    
    public init(data: JSON){
        
        //validated variables
        self.cardId = data["card_id"].object as! String;
        self.type = TypeOfCard(rawValue: data["type"].object as! String)!;
        self.locale = data["locale"].object as! String;
        self.title = data["title"].object as! String;
        self.hascontent = data["hascontent"].boolValue;

        //non validated variables
        if let _subTitle = data["subtitle"].object as? String , _subTitle != ""{
            self.subTitle = _subTitle;
        }
        
        let _user = data["user"];
        
        do{
            //validate data
            try User.validate(_user);
            self.user = User(data: _user);
        }
        catch{
            //Throw error for validate
            DataModelErrors.UnreconigzedError();
            //Some recorver code
        }
        
        
        let _image = data["image"];
        
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
        
        if let _products = data["products"].array , _products.count > 0{
            for _product in _products{
                if let _category = _product["category"].object as? String , _category == "travel"{
                    do{
                        try TravelProduct.validate(_product);
                        self.products.append(TravelProduct(data: _product));
                    }
                    catch DataModelErrors.CreateProductErrors.invalidCategoryOfProduct{
                        DataModelErrors.ShowError(DataModelErrors.CreateProductErrors.invalidCategoryOfProduct);
                        //Some recover code
                        
                    }
                    catch DataModelErrors.CreateProductErrors.invalidData{
                        DataModelErrors.ShowError(DataModelErrors.CreateProductErrors.invalidData);
                        //Some recover code
                        
                    }
                    catch DataModelErrors.CreateProductErrors.emptyData{
                        DataModelErrors.ShowError(DataModelErrors.CreateProductErrors.emptyData);
                        //Some recover code
                        
                    }
                    catch{
                        //Throw error for validate
                        DataModelErrors.UnreconigzedError();
                        //Some recorver code
                    }
                }
                else{
                    do{
                        try ItemProduct.validate(_product);
                        self.products.append(ItemProduct(data: _product));
                    }
                    catch DataModelErrors.CreateProductErrors.invalidCategoryOfProduct{
                        DataModelErrors.ShowError(DataModelErrors.CreateProductErrors.invalidCategoryOfProduct);
                        //Some recover code
                        
                    }
                    catch DataModelErrors.CreateProductErrors.invalidData{
                        DataModelErrors.ShowError(DataModelErrors.CreateProductErrors.invalidData);
                        //Some recover code
                        
                    }
                    catch DataModelErrors.CreateProductErrors.emptyData{
                        DataModelErrors.ShowError(DataModelErrors.CreateProductErrors.emptyData);
                        //Some recover code
                        
                    }
                    catch{
                        //Throw error for validate
                        DataModelErrors.UnreconigzedError();
                        //Some recorver code
                    }
                }
                
            }
        }
        
        //Create Containers
        if let _containers = data["info"].array , _containers.count > 0{
            for _container in _containers{
                do{
                    try Container.validate(_container);
                    let _containerObject = Container(data: _container);
                    self.containers[_containerObject.contentType] = _containerObject;
                }
                catch DataModelErrors.CreateContainerErrors.invalidContainerType{
                    DataModelErrors.ShowError(DataModelErrors.CreateContainerErrors.invalidContainerType);
                    //Some recover code
                }
                catch DataModelErrors.CreateContainerErrors.invalidContainerContentType{
                    DataModelErrors.ShowError(DataModelErrors.CreateContainerErrors.invalidContainerContentType);
                    //Some recover code
                }
                catch DataModelErrors.CreateContainerErrors.invalidData{
                    DataModelErrors.ShowError(DataModelErrors.CreateContainerErrors.invalidData);
                    //Some recover code
                }
                catch DataModelErrors.CreateContainerErrors.emptyData{
                    DataModelErrors.ShowError(DataModelErrors.CreateContainerErrors.emptyData);
                    //Some recover code
                }
                catch DataModelErrors.CreateContainerDataErrors.emptyData{
                    DataModelErrors.ShowError(DataModelErrors.CreateContainerDataErrors.emptyData);
                }
                catch{
                    DataModelErrors.UnreconigzedError();
                }
            }
        }
        
        if let _paginateKey = data["paginate_key"].object as? String , _paginateKey != ""{
            self.paginateKey = _paginateKey;
        }
        
        super.init();
    }
    
    
    public init(card_id : String, card : MiniCard) {
        
        
        self.cardId = card_id;
        self.type = card.type;
        self.locale = card.locale;
        self.title = card.title;
        self.subTitle = card.subTitle;
        self.image = card.image;
        self.products = card.products
        self.paginateKey = card.paginateKey;
        self.hascontent = card.hascontent;
        self.user = card.user;
        
        super.init();
    }
    
    
    public init(card_id : String, type : TypeOfCard) {
        
        
        self.cardId = card_id;
        self.type = type;
        self.locale = "";
        self.title = "";
        self.subTitle = nil
        self.image = nil;
        self.products = [Product]();
        self.paginateKey = nil;
        self.hascontent = false;
        self.user = nil;
        
        super.init();
    }
    
    
    public class func validate(_ data: JSON?) throws{
        guard let _data = data , _data != nil else{
            try DataModelErrors.ThrowError(DataModelErrors.CreateMiniCardErrors.emptyData);
            return;
        }
        
        guard case let (_cardId as String, _type as String, _locale as String, _title as String) = (_data["card_id"].object, _data["type"].object, _data["locale"].object, _data["title"].object)
            , _cardId != "" && _type != "" && _locale != "" && _title != ""  else{
                //Throw indavilData Error
                try DataModelErrors.ThrowError(DataModelErrors.CreateMiniCardErrors.invalidData);
                return;
        }
        
        if(TypeOfCard(rawValue: _type) == nil){
            //Throw invalid type of card Error
            try DataModelErrors.ThrowError(DataModelErrors.CreateCardDetailErrors.invalidTypeOfCard);
        }

    }
    
    public class func validateCardDetail(_ data: CardDetailResponse?) throws{
        guard let _data = data else{
            try DataModelErrors.ThrowError(DataModelErrors.CreateMiniCardErrors.emptyData);
            return;
        }
        
        guard case let (_cardId as String, _locale as String, _title) = (_data.cardId, _data.locale, _data.title)
            , _cardId != "" && _locale != "" && _title != ""  else{
                //Throw indavilData Error
                try DataModelErrors.ThrowError(DataModelErrors.CreateMiniCardErrors.invalidData);
                return;
        }
    }
}

