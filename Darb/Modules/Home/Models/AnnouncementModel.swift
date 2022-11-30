//
//  AnnouncementModel.swift
//  Darb
//
//  Created by Naveed ur Rehman on 30/11/2022.
//

import UIKit

class AnnouncementModel: NSObject, NSCoding{
    
    var createdAt : String!
    var file : File!
    var id : Int!
    var img : String!
    var link : String!
    var schoolId : String!
    var text : String!
    var updatedAt : String!
    var validTill : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        createdAt = dictionary["created_at"] as? String
        if let fileData = dictionary["file"] as? [String:Any]{
            file = File(fromDictionary: fileData)
        }
        id = dictionary["id"] as? Int
        img = dictionary["img"] as? String
        link = dictionary["link"] as? String
        schoolId = dictionary["school_id"] as? String
        text = dictionary["text"] as? String
        updatedAt = dictionary["updated_at"] as? String
        validTill = dictionary["valid_till"] as? String
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
        if file != nil{
            dictionary["file"] = file.toDictionary()
        }
        if id != nil{
            dictionary["id"] = id
        }
        if img != nil{
            dictionary["img"] = img
        }
        if link != nil{
            dictionary["link"] = link
        }
        if schoolId != nil{
            dictionary["school_id"] = schoolId
        }
        if text != nil{
            dictionary["text"] = text
        }
        if updatedAt != nil{
            dictionary["updated_at"] = updatedAt
        }
        if validTill != nil{
            dictionary["valid_till"] = validTill
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
         file = aDecoder.decodeObject(forKey: "file") as? File
         id = aDecoder.decodeObject(forKey: "id") as? Int
         img = aDecoder.decodeObject(forKey: "img") as? String
         link = aDecoder.decodeObject(forKey: "link") as? String
         schoolId = aDecoder.decodeObject(forKey: "school_id") as? String
         text = aDecoder.decodeObject(forKey: "text") as? String
         updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String
         validTill = aDecoder.decodeObject(forKey: "valid_till") as? String

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
        if file != nil{
            aCoder.encode(file, forKey: "file")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if img != nil{
            aCoder.encode(img, forKey: "img")
        }
        if link != nil{
            aCoder.encode(link, forKey: "link")
        }
        if schoolId != nil{
            aCoder.encode(schoolId, forKey: "school_id")
        }
        if text != nil{
            aCoder.encode(text, forKey: "text")
        }
        if updatedAt != nil{
            aCoder.encode(updatedAt, forKey: "updated_at")
        }
        if validTill != nil{
            aCoder.encode(validTill, forKey: "valid_till")
        }

    }

}
class File : NSObject, NSCoding{

    var createdAt : String!
    var fileableId : AnyObject!
    var fileableType : AnyObject!
    var id : Int!
    var name : String!
    var updatedAt : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        createdAt = dictionary["created_at"] as? String
        fileableId = dictionary["fileable_id"] as? AnyObject
        fileableType = dictionary["fileable_type"] as? AnyObject
        id = dictionary["id"] as? Int
        name = dictionary["name"] as? String
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
        if fileableId != nil{
            dictionary["fileable_id"] = fileableId
        }
        if fileableType != nil{
            dictionary["fileable_type"] = fileableType
        }
        if id != nil{
            dictionary["id"] = id
        }
        if name != nil{
            dictionary["name"] = name
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
         fileableId = aDecoder.decodeObject(forKey: "fileable_id") as? AnyObject
         fileableType = aDecoder.decodeObject(forKey: "fileable_type") as? AnyObject
         id = aDecoder.decodeObject(forKey: "id") as? Int
         name = aDecoder.decodeObject(forKey: "name") as? String
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
        if fileableId != nil{
            aCoder.encode(fileableId, forKey: "fileable_id")
        }
        if fileableType != nil{
            aCoder.encode(fileableType, forKey: "fileable_type")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }
        if updatedAt != nil{
            aCoder.encode(updatedAt, forKey: "updated_at")
        }

    }

}
