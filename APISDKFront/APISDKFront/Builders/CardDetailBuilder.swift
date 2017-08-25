//
//  CardDetailBuilder.swift
//  SDKFrontiOS
//
//  Created by Jonathan Castro Miguel on 13/09/16.
//  Copyright © 2016 Touchvie. All rights reserved.
//

import Foundation
import UIKit

class CardDetailBuilder : BaseCardDetailBuilder{
    
    
    // MARK: Public Methods
    /**
     This method build a CardDetail with default modules.
     When finished build the CardDetail this is added to the navigation controller.
     
     - parameter cardId:   The cardId to get the information of the card
     - parameter navigationController: The navigation controller of the user.
     */
    open func buildAll(_ cardId : String, navigationController : UINavigationController){
        // TODO: need to do the logic
    }
    
    /**
     This method allow the user to add a section.
     
     - parameter idSection:     The name of the section
     - parameter configSection: The ConfigSection with the modules the user wants to show
     - parameter isMainSection: A boolean to know if this is the main section
     
     - returns: Return the CardDetailBuilder
     */
    open func addSection(_ idSection : String, configSection : ConfigSection, isMainSection : Bool)->CardDetailBuilder{
        
        if(isMainSection && self.mainKeySection == nil){
            self.mainKeySection = idSection;
        }
        if(configSection.arrayModules.count > 0){
            if(self.dictSections[idSection] == nil){
                self.dictSections[idSection] = configSection;
            }
        }
        
        return self;
    }

}
