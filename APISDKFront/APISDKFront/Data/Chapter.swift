import Foundation
import SwiftyJSON

public class Chapter : NSObject, Validatable{
    
    public var chapterIndex : Int;
    public var cardId : String;
    public var title : String?;
    
    public var isSynchronizable : Bool = false;
    
    init(data: JSON){
        
        //validate variables
        self.chapterIndex = data["chapter_index"].intValue;
        self.cardId = data["card_id"].object as! String;
        
        super.init();
    }
    
    class func validate(_ data: JSON?) throws{
        guard let _data = data , _data != nil else{
            try DataModelErrors.ThrowError(DataModelErrors.CreateChapterErrors.emptyData);
            return;
        }
        
        guard let _cardId = _data["card_id"].object as? String
            , _cardId != "" && _data["chapter_index"] != nil else{
                //Throw indavilData Error
                try DataModelErrors.ThrowError(DataModelErrors.CreateChapterErrors.invalidData);
                return;
        }
    }
}
