//
//  ProductData.swift
//  SDKFrontiOS
//
//  Created by Jonathan Castro Miguel on 14/10/16.
//  Copyright © 2016 Tagsonomy. All rights reserved.
//

import Foundation
import SwiftyJSON

public class Product : Validatable{
    public var productId : String;
    public var category : ProductCategory;
    public var title : String;
    public var source : Source?;
    public var image : String;
    public var url : String;
    public var isUpToDate : Bool;
    public var price : Float;
    public var currency : String;
    
    init(data: JSON){
        //validated variables
        self.productId = data["product_id"].object as! String;
        self.category = ProductCategory(rawValue: data["category"].object as! String)!;
        self.title = data["title"].object as! String;
        self.image = data["image"].object as! String;
        self.url = data["url"].object as! String;
        self.isUpToDate = data["is_up_to_date"].boolValue;
        self.price = data["price"].floatValue;
        self.currency = data["currency"].object as! String;
        
        //non validate variables
        let _source = data["source"];
        
        if(_source != nil){
            
            do{
                try Source.validate(_source);
                self.source = Source(data: _source);
            }
            catch DataModelErrors.CreateSourceErrors.emptyData{
                DataModelErrors.ShowError(DataModelErrors.CreateSourceErrors.emptyData);
            }
            catch DataModelErrors.CreateSourceErrors.invalidData{
                DataModelErrors.ShowError(DataModelErrors.CreateSourceErrors.invalidData);
            }
            catch{
                DataModelErrors.UnreconigzedError();
            }
        }
    }
    
    class func validate(_ data: JSON?) throws {
    
        guard let _data = data , _data != nil else{
            try DataModelErrors.ThrowError(DataModelErrors.CreateProductErrors.emptyData);
            return;
        }
        
        guard case let (_productId as String, _category as String, _title as String, _image as String, _url as String, _ as Bool, _ as Float, _currency as String) = (_data["product_id"].object, _data["category"].object, _data["title"].object, _data["image"].object, _data["url"].object, _data["is_up_to_date"].boolValue, _data["price"].float, _data["currency"].object)
            , _productId != "" && _category != "" && _title != "" && _image != "" && _url != "" && _currency != "" else{
            //Throw indavilData Error
            try DataModelErrors.ThrowError(DataModelErrors.CreateProductErrors.invalidData);
            return;
        }
        
        if(ProductCategory(rawValue: _category) == nil){
            //Throw invalid type of card Error
            try DataModelErrors.ThrowError(DataModelErrors.CreateProductErrors.invalidCategoryOfProduct);
        }
        
    }
}
