//
//  BaseCardDetailBuilder.swift
//  SDKFrontiOS
//
//  Created by Jonathan Castro Miguel on 13/09/16.
//  Copyright © 2016 Touchvie. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import DiveApi

public protocol RestSDKFrontDelegate : class{
    func shareOptions(withcardId cardid: String)
}

private typealias completionBlockGetCard = (CardDetailResponse)->Void;

class BaseCardDetailBuilder : NSObject{
    
    internal var sdkConfiguration : ConfigurationAPISDK?;
    internal var dictSections = [String : ConfigSection]();
    internal var mainKeySection : String?;
    internal var configJSON = [String : String]();
    private weak var restSDKFrontDelegate : RestSDKFrontDelegate?;
    private var relations : [RelationModule]?;
    private var bundle : Bundle
    private var completion: (Section?) -> Void
    
    fileprivate var moduleValidator : ModuleValidator!;
    
    // MARK: Init
    /**
     The initializer.
     
     - parameter styleConfig: This is optional, by default is nil. If the user wants a style for the CardDetail need to pass a json.
     
     - parameter restSDKDelegate: This is the delegate the user need to implement to call the service of getCard. 
     
     - returns: self
     */
    init(sdkConfiguration : ConfigurationAPISDK? = nil, restSDKDelegate : RestSDKFrontDelegate, bundle : Bundle, relations : [RelationModule]? = nil, completion: @escaping (Section?) -> Void){
        
        self.bundle = bundle
        self.completion = completion
        
        super.init();
        
        self.sdkConfiguration = sdkConfiguration;
        self.restSDKFrontDelegate = restSDKDelegate;
        self.relations = relations;
        self.moduleValidator = ModuleValidator();
    }
    
    // MARK: Public Methods
    /**
     This method build a CardDetail with the modules and sections the user wants to show.
     When finished build the CardDetail this is added to the navigation controller.
     
     - parameter cardId:   The cardId to get the information of the card
     - parameter navigationController: The navigation controller of the user.
     */
    open func build(_ cardId : String, customJSON : String? = nil){
        
        ToolsUtils.adminNativeLoadingIn(show: true, backgroundColor: .black);
        var section : Section?
        
        // MARK: - DiveApi get card detail method
        DiveAPI.getCardsWithRequestBuilder(relations: .all, cardId: cardId,_completion: { _response , _error in
            
            ToolsUtils.adminNativeLoadingIn(show: false, backgroundColor: .black);
            
            if (_response?.body != nil) {
                
                if let json = self.getJSON(type: (_response?.body?.type.rawValue)!, customJSON: customJSON){
                    self.loadDataType(json)
                    self.validateSectionsAndModules((_response?.body)!)
                    
                    var validSections = [String : ConfigSection]()
                    for key in self.dictSections.keys{
                        
                        let configSection = self.dictSections[key]!
                        if(configSection.isValidSection){
                            let newConfigSection = self.createConfigSection(configSection.arrayModules);
                            if(newConfigSection.arrayModules.count > 0){
                                validSections[key] = newConfigSection;
                            }
                        }
                        
                    }
                    
                    if (validSections[self.mainKeySection!] != nil) {
                        section = CardDetailRender(_sectionsData: validSections, _mainSectionKey: self.mainKeySection, _cardDetail: (_response?.body)!, restSDKDelegate: self.restSDKFrontDelegate, sdkConfiguration: self.sdkConfiguration).createSection(self.mainKeySection!)
                    }
                    
                } else {
                    
                    //JSON TYPE DONT FIND
                }
            } else {
                // CALLING ERROR
            }
            
            self.completion(section)
            
        })
        // MARK: - Old get card detail method
        
        //        self.getCardDetail(cardId) { (cardData : CardDetail) in
        //
        //
        //            if let json = self.getJSON(type: cardData.type.rawValue, customJSON: customJSON){
        //
        //                self.loadDataType(json);
        //                self.validateSectionsAndModules(cardData);
        //
        //                var validSections = [String : ConfigSection]();
        //                for key in self.dictSections.keys{
        //                    let configSection = self.dictSections[key]!;
        //                    if(configSection.isValidSection){
        //                        let newConfigSection = self.createConfigSection(configSection.arrayModules);
        //                        if(newConfigSection.arrayModules.count > 0){
        //                            validSections[key] = newConfigSection;
        //                        }
        //                    }
        //                }
        
        // TODO: need to do the logic
        //                CardDetailRender(_sectionsData: validSections, _mainSectionKey: self.mainKeySection!, _cardDetail: cardData, _navigationController: navigationController, restSDKDelegate: self.restSDKFrontDelegate);
        //            }
        //
        //        }
    }
    
    
    
    // MARK: Private Methods
    /**
     This method call the SDKClient.
     
     - parameter cardId:          The cardId to get the information of the card
     - parameter completionBlock: The completion with the CardData.
     */
    /*fileprivate func getCardDetail(_ cardId : String, completionBlock : @escaping completionBlockGetCard){
        // TODO: need to call the sdkclient and in the response call the completion
        // For test we catch a local json
        self.restSDKFrontDelegate?.getCardRest(cardId: cardId, completion: { (json : JSON?) in
            if(json != nil){
                completionBlock(CardDetail(data: json!, relations : self.relations));
            }
            else{
                // TODO: need to do the logic
            }
        });
        /*if let path = Bundle.main.path(forResource: "card_detail_movie", ofType: "json") {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
                let json = JSON(data: data);
                if(json != nil && json.error == nil){
                    completionBlock(CardDetail(data: json));
                }
            }
        }*/
        //completionBlock(CardDetail(_cardId : "ID", _type : "person", _locale : "ES_es", _title : "Title"));
    }*/
    
    
    fileprivate func getJSON(type : String, customJSON : String?) -> JSON?{
        
        // TODO: need to find a better solution
        /*if(BlackBoard.sharedInstance.fromCarrusel && customJSON == nil && (type == "movie" || type == "chapter")){
            if let path = Bundle.main.path(forResource: "small_movie", ofType: "json") {
                if let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
                    let json = JSON(data: data);
                    if(json != nil && json.error == nil){
                        return json;
                    }
                }
            }
        }*/
        
        let value = customJSON != nil ? customJSON : self.configJSON[type];
        
        if(value != nil){
            if let path = self.bundle.path(forResource: value, ofType: "json") {
                if let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
                    let json = JSON(data: data);
                    if(json != nil && json.error == nil){
                        return json;
                    }
                }
            }
        }
        
        return nil;
        
    }
    
    fileprivate func loadDataType(_ json : JSON){
        for section in json["sections"].arrayValue{
            let configSection = ConfigSection();
            for module in section["modules"].arrayValue{
                self.addModuleType(module, configSection: configSection);
            }
            // This check if already exist the section, if exist don't do nothing
            if(self.dictSections[section["title"].stringValue] == nil){
                self.dictSections[section["title"].stringValue] = configSection;
            }
            // This is to get the main key
            if(section["main"] != nil && section["main"].boolValue && self.mainKeySection == nil){
                self.mainKeySection = section["title"].stringValue;
            }
        }
    }
    
    /**
     This method check the type of module the user wants and add to ConfigSection.
     
     - parameter module:        The json with the type of module the user wants.
     - parameter configSection: The object ConfigSection to add the modules.
     */
    fileprivate func addModuleType(_ module : JSON, configSection : ConfigSection){
        if(module["type"] != nil){
            let moduleName = module["type"].stringValue;
            if  let appName = Bundle(for: self.classForCoder).infoDictionary!["CFBundleName"] as? String {
                if(NSClassFromString("\(appName).\(moduleName)") as? NSObject.Type != nil){
                    var targets : [Target]?;
                    if (moduleName == "BiographyNavigation" || moduleName == "OverviewNavigation" || moduleName == "DescriptionNavigation") {
                        for target in module["targets"].arrayValue{
                            if(targets == nil){
                                targets = [Target]();
                            }
                            if(target["section_id"] != nil && target["text"] != nil){
                                let _target = Target(sectionId: target["section_id"].stringValue, text: target["text"].stringValue);
                                targets?.append(_target);
                            }
                        }
                        if(targets != nil && targets!.count > 0){
                            configSection.addModule(moduleName, targets: targets);
                        }
                    }
                    else{
                        configSection.addModule(moduleName, targets: targets);
                    }
                    
                }
            }
        }
    }
    
    /**
     This method validate sections and modules.
     
     - parameter cardData: The data with all the info
     */
 
    
    fileprivate func validateSectionsAndModules(_ cardData : CardDetailResponse){
        for key in self.dictSections.keys{
            let configSection = self.dictSections[key]!;
            for configModule in configSection.arrayModules{
                if(configModule.targets == nil){
                    if(self.moduleValidator.validate(cardData, moduleType: configModule.moduleName!)){
                        configModule.isValid = true;
                        if(!configSection.isValidSection){
                            configSection.isValidSection = true;
                        }
                    }
                }
            }
        }
    }
    
    /**
     This method create a new ConfigSection with valid modules.
     
     - parameter arrayModules: The array of modules
     
     - returns: Return a ConfigSection
     */
    fileprivate func createConfigSection(_ arrayModules : [ConfigModule])->ConfigSection{
        // Create a new ConfigSection
        let newConfigSection = ConfigSection();
        for configModule in arrayModules{
            // Check if is a normal module
            if(configModule.targets == nil){
                // Check if is valid and add to the new ConfigSection
                if(configModule.isValid){
                    newConfigSection.addModule(configModule.moduleName!, targets: configModule.targets);
                }
            }
            else{
                var newTargets = [Target]();
                for target in configModule.targets!{
                    // Check if the target is valid and add to the array
                    if(target.sectionId != nil && self.dictSections[target.sectionId!] != nil && self.dictSections[target.sectionId!]!.isValidSection){
                        newTargets.append(target);
                    }
                }
                // Only add the module if we have more than one target
                if(newTargets.count > 0){
                    newConfigSection.addModule(configModule.moduleName!, targets: newTargets);
                }
                
            }
        }
        return newConfigSection;
    }
    
    

}
