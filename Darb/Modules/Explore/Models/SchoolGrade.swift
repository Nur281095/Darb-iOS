//
//  SchoolGrade.swift
//  Darb
//
//  Created by Naveed ur Rehman on 30/11/2022.
//

import UIKit

class SchoolGrade: NSObject, NSCoding{
    
    var createdAt : String!
    var gradeName : String!
    var id : Int!
    var schoolId : String!
    var updatedAt : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        createdAt = dictionary["created_at"] as? String
        gradeName = dictionary["grade_name"] as? String
        id = dictionary["id"] as? Int
        schoolId = dictionary["school_id"] as? String
        updatedAt = dictionary["updated_at"] as? String
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if createdAt != nil{
            dictionary["created_at"] = createdAt
        }
        if gradeName != nil{
            dictionary["grade_name"] = gradeName
        }
        if id != nil{
            dictionary["id"] = id
        }
        if schoolId != nil{
            dictionary["school_id"] = schoolId
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
         createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
         gradeName = aDecoder.decodeObject(forKey: "grade_name") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         schoolId = aDecoder.decodeObject(forKey: "school_id") as? String
         updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
    {
        if createdAt != nil{
            aCoder.encode(createdAt, forKey: "created_at")
        }
        if gradeName != nil{
            aCoder.encode(gradeName, forKey: "grade_name")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if schoolId != nil{
            aCoder.encode(schoolId, forKey: "school_id")
        }
        if updatedAt != nil{
            aCoder.encode(updatedAt, forKey: "updated_at")
        }

    }

}
