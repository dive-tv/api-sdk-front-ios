//
//  CardData.swift
//  SDKFrontiOS
//
//  Created by Jonathan Castro Miguel on 13/09/16.
//  Copyright © 2016 Touchvie. All rights reserved.
//

import Foundation
import SwiftyJSON

public class CardDetail : NSObject, Validatable{
    
    public var cardId : String;
    public var type : TypeOfCard;
    public var locale : String;
    public var title : String;
    
    public var subtitle : String?;
    public var image : SDKFrontImage?;
    public var products = [Product]();
    public var containers = Dictionary<ContainerContentType, Container>();
    public var relations = Dictionary<RelationContentType, Relation>();
    public var user : User;
    
    public lazy var matchProduct : ItemProduct? = {
        for product in self.products{
            if let matchedProduct = product as? ItemProduct{
                if(matchedProduct.isExact){
                    return matchedProduct;
                }
            }
        }
        return nil;
    }();
    
    init(_cardId : String, _type : String, _locale : String, _title : String, _image : SDKFrontImage? = nil) {
        
        self.cardId = _cardId;
        self.type = TypeOfCard(rawValue: _type)!;
        self.locale = _locale;
        self.title = _title;
        
        if(_image != nil){
            self.image = _image;
        }
        
        self.user = User(data: JSON(arrayLiteral: "{[\"is_liked\" : true]}"));
    }
    
    public init(data:JSON , relations : [Relation]? = nil){
        
        //validated variables
        self.cardId = data["card_id"].object as! String;
        self.type = TypeOfCard(rawValue: data["type"].object as! String)!;
        self.locale = data["locale"].object as! String;
        self.title = data["title"].object as! String;
        
        //non validate variables
        if let _subtitle = data["subtitle"].object as? String , _subtitle != ""{
            self.subtitle = _subtitle;
        }
        
        //Create image
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
        
        //Create products
        if let _products = data["products"].array , _products.count > 0{
            for product in _products{
                
                if let _category = product["category"].object as? String , _category == "travel"{
                    do{
                        try TravelProduct.validate(product);
                        self.products.append(TravelProduct(data: product));
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
                        try ItemProduct.validate(product);
                        self.products.append(ItemProduct(data: product));
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
        
        //Create relations
        if(relations != nil){
            for relation in relations!{
                self.relations[relation.contentType] = relation;
            }
        }
        
        
        
        //Create relations
        if let _relations = data["relations"].array , _relations.count > 0{
            for _relation in _relations{
                do{
                    try Relation.validate(_relation);
                    let _relationObject = Relation(data: _relation);
                    self.relations[_relationObject.contentType] = _relationObject;
                }
                catch DataModelErrors.CreateRelationsErrors.invalidRelationType{
                    DataModelErrors.ShowError(DataModelErrors.CreateContainerErrors.invalidContainerType);
                    //Some recover code
                }
                catch DataModelErrors.CreateRelationsErrors.invalidRelationContentType{
                    DataModelErrors.ShowError(DataModelErrors.CreateContainerErrors.invalidContainerContentType);
                    //Some recover code
                }
                catch DataModelErrors.CreateRelationsErrors.invalidData{
                    DataModelErrors.ShowError(DataModelErrors.CreateContainerErrors.invalidData);
                    //Some recover code
                }
                catch DataModelErrors.CreateRelationsErrors.emptyData{
                    DataModelErrors.ShowError(DataModelErrors.CreateContainerErrors.emptyData);
                    //Some recover code
                }
                catch DataModelErrors.CreateRelationsDataErrors.emptyData{
                    DataModelErrors.ShowError(DataModelErrors.CreateContainerDataErrors.emptyData);
                }
                catch{
                    DataModelErrors.UnreconigzedError();
                }
            }
        }
        
        //create the user object
        self.user = User(data: data["user"]);
        
    }
    
    class func validate(_ data: JSON?) throws{
        
        guard let _data = data , _data != nil else{
            try DataModelErrors.ThrowError(DataModelErrors.CreateCardDetailErrors.emptyData);
            return;
        }
        
        guard case let (_ as String, _type as String, _ as String, _ as String, _user as JSON) = (_data["card_id"].object, _data["type"].object, _data["locale"].object, _data["title"].object, _data["user"]) else{
            //Throw indavilData Error
            try DataModelErrors.ThrowError(DataModelErrors.CreateCardDetailErrors.invalidData);
            return;
        }
        
        if(TypeOfCard(rawValue: _type) == nil){
            //Throw invalid type of card Error
            try DataModelErrors.ThrowError(DataModelErrors.CreateCardDetailErrors.invalidTypeOfCard);
        }
        
        try User.validate(_user);
    }
    
}
