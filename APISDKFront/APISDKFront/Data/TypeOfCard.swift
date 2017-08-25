//
//  TypeOfCard.swift
//  SDKFrontiOS
//
//  Created by Jonathan Castro Miguel on 13/09/16.
//  Copyright © 2016 Touchvie. All rights reserved.
//

import DiveApi

public enum TypeOfCard : String{
    case    Movie = "movie",
            Serie = "serie",
            Chapter = "chapter",
            Person = "person",
            Character = "character",
            Vehicle = "vehicle",
            Fashion = "fashion",
            Home = "home",
            Technology = "technology",
            Art = "art",
            Look = "look",
            Weapon = "weapon",
            LeisureSport = "leisure_sport",
            HealthBeauty = "health_beauty",
            FoodDrink = "food_drink",
            FaunaFlora = "fauna_flora",
            Business = "business",
            Location = "location",
            Historic = "historic",
            OST = "ost",
            Song = "song",
            Trivia = "trivia",
            Reference = "reference",
            //LOCAL
            Commercial = "commercial",
            Empty = "empty",
            Feedback = "feedback",
            Info = "info"
    
    
    public static func getContainerContentType(type : CardDetailResponse.ModelType) -> ContainerContentType{
        switch type{
        case .movie:
            return ContainerContentType.Movie;
        case .chapter:
            return ContainerContentType.Chapter;
        case .serie:
            return ContainerContentType.Serie;
        default:
            return ContainerContentType.Movie;
        }
    }
}
