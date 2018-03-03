//
//  Post.swift
//  MDBSocials
//
//  Created by Will Oakley on 2/20/18.
//  Copyright © 2018 Will Oakley. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage
import ObjectMapper
import Haneke

class Post: Mappable {
    var date: String?
    var description: String?
    var eventName: String?
    var imageUrl: String?
    var posterId: String?
    var posterName: String?
    var id: String?
    var image: UIImage?
    var interestedUserDictionary: Dictionary<String, String>?
    var interestedUserIds: [String]?
    var latitude: Double?
    var longitude: Double?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        date                       <- map["date"]
        description                <- map["description"]
        eventName                  <- map["name"]
        imageUrl                   <- map["pictureURL"]
        posterId                   <- map["posterId"]
        interestedUserDictionary   <- map["Interested"]
        id                         <- map["postId"]
        latitude                   <- map["latitude"]
        longitude                  <- map["longitude"]
    }
    
    func getInterestedUserIds() -> [String]{
        if interestedUserDictionary != nil && self.interestedUserIds == nil{
            self.interestedUserIds = Array(self.interestedUserDictionary!.values) as! [String]
        }
        if self.interestedUserIds == nil {
            return []
        }
        else{
            return self.interestedUserIds!
        }
    }
    
    func addInterestedUser(userID: String){
        if self.interestedUserIds == nil {
            self.interestedUserIds =  [userID]
        }
        else{
            self.interestedUserIds!.append(userID)
        }
    }
    
    func getPicture(withBlock: @escaping () -> ()) {
        if self.image == nil {
            let urlReference = Storage.storage().reference(forURL: imageUrl!)
            urlReference.getData(maxSize: 30 * 1024 * 1024) { data, error in
                if let error = error {
                    print("Error getting image")
                    print(error.localizedDescription)
                } else {
                    self.image = UIImage(data: data!)
                    withBlock()
                }
            }
        }
    }
}
