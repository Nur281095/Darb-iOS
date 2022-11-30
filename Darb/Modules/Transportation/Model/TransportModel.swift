//
//  TransportModel.swift
//  Darb
//
//  Created by Naveed ur Rehman on 29/11/2022.
//

import UIKit

class TransportModel: NSObject, NSCoding{
    
    var childId : String!
    var createdAt : String!
    var homeAddress : String!
    var id : Int!
    var schoolAddress : String!
    var status : String!
    var updatedAt : String!
    var childName : String!
    var schoolName : String!
    

    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        childId = dictionary["child_id"] as? String
        createdAt = dictionary["created_at"] as? String
        homeAddress = dictionary["home_address"] as? String
        id = dictionary["id"] as? Int
        schoolAddress = dictionary["school_address"] as? String
        status = dictionary["status"] as? String
        updatedAt = dictionary["updated_at"] as? String
        childName = dictionary["child_name"] as? String ?? ""
        schoolName = dictionary["school_name"] as? String
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if childId != nil{
            dictionary["child_id"] = childId
        }
        if createdAt != nil{
            dictionary["created_at"] = createdAt
        }
        if homeAddress != nil{
            dictionary["home_address"] = homeAddress
        }
        if id != nil{
            dictionary["id"] = id
        }
        if schoolAddress != nil{
            dictionary["school_address"] = schoolAddress
        }
        if status != nil{
            dictionary["status"] = status
        }
        if updatedAt != nil{
            dictionary["updated_at"] = updatedAt
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         childId = aDecoder.decodeObject(forKey: "child_id") as? String
         createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
         homeAddress = aDecoder.decodeObject(forKey: "home_address") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         schoolAddress = aDecoder.decodeObject(forKey: "school_address") as? String
         status = aDecoder.decodeObject(forKey: "status") as? String
         updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
    {
        if childId != nil{
            aCoder.encode(childId, forKey: "child_id")
        }
        if createdAt != nil{
            aCoder.encode(createdAt, forKey: "created_at")
        }
        if homeAddress != nil{
            aCoder.encode(homeAddress, forKey: "home_address")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if schoolAddress != nil{
            aCoder.encode(schoolAddress, forKey: "school_address")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
        if updatedAt != nil{
            aCoder.encode(updatedAt, forKey: "updated_at")
        }

    }

}
