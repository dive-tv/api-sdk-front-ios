//
//  CardDetail.swift
//  SDKFrontiOS
//
//  Created by Jonathan Castro Miguel on 13/09/16.
//  Copyright © 2016 Touchvie. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import DiveApi


 protocol CardDetailDelegate : class {
    func createSection (_ _keyForSection : String) -> Section
    func createSections (_ _keyForSections : [String]) -> [Section]
    func newSection(_ _keyForSection : String);
    
    func newCard(_ _key : String, _type: Int)
    
    func showListController(viewController : UIViewController);
    
    func getChapters(cardIds : [String], completion : @escaping (_ cards :[CardDetailResponse]?) -> Void);
    
    func addRemoveLike(cardId : String, like : Bool, completion : @escaping (_ statusCode : Int) -> Void)
    
    func goToRoot();
    
    func shareOptions ()
    
}

class CardDetailRender : NSObject, CardDetailDelegate {
    
    fileprivate var sectionsData : [String:ConfigSection]!;
    fileprivate var navigationController : UINavigationController!;
    fileprivate var mainSectionKey : String!;
    fileprivate var cardDetail: CardDetailResponse!
    
    private weak var restSDKDelegate : RestSDKFrontDelegate?;
    
    
    //MARK: INIT
    
    
    init(_sectionsData : [String:ConfigSection], _mainSectionKey : String!, _cardDetail : CardDetailResponse, _navigationController : UINavigationController, restSDKDelegate : RestSDKFrontDelegate?) {
        
        super.init()
        self.sectionsData = _sectionsData;
        self.navigationController = _navigationController;
        self.mainSectionKey = _mainSectionKey;
        self.cardDetail = _cardDetail
        self.restSDKDelegate = restSDKDelegate;
        
       
        self.pushMain();

    }
    deinit {
        print("CardDetail destroid")
    }
    
    
    
    
    //MARK: Private methods

    
    /**
     Pushes to the clients UINavigationViewController the main section especified by the client
     */
    fileprivate func pushMain() {
        
        if (self.sectionsData[self.mainSectionKey] != nil) {
            
            let controller = self.createSection(self.mainSectionKey);
            controller.cardDelegate = self;
            controller.isMain = true;
            self.navigationController.pushViewController(controller, animated: true);
        }
    }
    
    
    /**
     Pushes to the clients UINavigationViewController the selected section especified by the client
     
     - parameter _keyForSection: the key string of teh section
     */
    fileprivate func pushSection (_ _keyForSection : String) {
        
        if (self.mainSectionKey != _keyForSection && self.sectionsData[_keyForSection] != nil) {
            
            let controller = self.createSection(_keyForSection);
            controller.cardDelegate = self;
            self.navigationController.pushViewController(controller, animated: true);
        }
    }
    
    
    
    //MARK: Card detail delegate
    
    
    /**
     Create the section and returns it
     
     - parameter _keyForSection: the key of the section to create
     
     - returns: the section created with the delegate assigned
     */
    func createSection (_ _keyForSection : String) -> Section {
        let section = Section(nibName: "Section", bundle: Bundle(for: self.classForCoder), _configSection: self.sectionsData[_keyForSection]!, _cardDetail: self.cardDetail)
        section.cardDelegate = self;
        return section;
    }
    
    
    /**
     Create x sections and returns them.
     
     - parameter _keyForSections: array of strings with the keys of the sections
     
     - returns: array of sections created
     */
    func createSections (_ _keyForSections : [String]) -> [Section] {
        
        var sections = [Section]()
        
        for key in _keyForSections {
            let section = Section(nibName: "Section", bundle:  Bundle(for: self.classForCoder), _configSection: self.sectionsData[key]!, _cardDetail: self.cardDetail)
            section.cardDelegate = self;
            sections.append(section);
            
        }
        
        return sections;
    }
    
    
    /**
     Push a new section
     
     - parameter _keyForSection: the key of the section to push
     */
    func newSection(_ _keyForSection: String) {
        self.pushSection(_keyForSection);
    }
    
    
    /**
     Create a new card detail
     
     - parameter _key:  the id of the card to create
     - parameter _type: the type of the card to create
     */
    func newCard(_ _key: String, _type: Int) {
        //NEED TO DO THE LOGIC
    }
    
    
    /// Push a view controller with a list of items
    ///
    /// - parameter viewController: The view controller the user want to add to navigation
    func showListController(viewController: UIViewController) {
        self.navigationController.pushViewController(viewController, animated: true);
    }
    
    func getChapters(cardIds: [String], completion: @escaping ([CardDetailResponse]?) -> Void) {
//        self.restSDKDelegate?.getChapters(cardIds: cardIds, completion: { (cards : [CardDetailResponse]?) in
//            completion(cards);
//        })
    }
    
    func addRemoveLike(cardId : String, like: Bool, completion: @escaping (Int) -> Void) {
//        self.restSDKDelegate?.addRemoveLike(cardId : cardId, like: like, completion: { (statusCode : Int) in
//            completion(statusCode);
//        })
    }
    
    func goToRoot() {
        self.navigationController.popToRootViewController(animated: true);
    }
    
    func shareOptions() {
        self.restSDKDelegate?.shareOptions(withcardId: self.cardDetail.cardId)
    }
    
}
