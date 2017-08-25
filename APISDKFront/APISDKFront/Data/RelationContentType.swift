//
//  RelationsContentType.swift
//  SDKFrontiOS
//
//  Created by Jonathan Castro Miguel on 23/10/16.
//  Copyright © 2016 Tagsonomy. All rights reserved.
//

import Foundation

public enum RelationContentType : String{
    case
            Trivias = "trivias",
            MovieVehicles = "movie_vehicles",
            Highlighted = "highlighted",
            MovieSongs = "movie_songs",
            Recommended = "recommended",
            Directors = "directors",
            AppearsIn = "appears_in",
            FullLooks = "full_looks",
            LookFashion = "look_fashion",
            OtherLooks = "other_looks",
            Tracklist = "tracklist",
            SoundsIn = "sounds_in",
            IsPartOf = "is_part_of",
            Casting = "casting",
            MovieLocations = "movie_locations",
            Filmography = "filmography",
            WornBy = "worn_by",
            FeaturedIn = "featured_in",
            ChapterOf = "is_chapter_of",
            InterpretedBy = "played_by",
            WearLooks = "wears",
            FullHome = "full_home",
            HomeDeco = "home_deco",
            FashionSet = "fashion_set",
    
    //LOCAL RELATIONCONTENTTYPE
    
            FashionOffMovie = "fashion_off_movie",
            HomeOffMovie = "home_off_movie"
}
