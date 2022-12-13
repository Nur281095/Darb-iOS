//
//  User.swift
//  EyecareBrands
//
//  Created by Noblemetric Technology on 9/5/22.
//

import UIKit

class User: NSObject, NSCoding{
    
    var apiToken : String!
    var createdAt : String!
    var email : String!
    var emailVerifiedAt : String!
    var firstName : String!
    var id : Int!
    var lastName : String!
    var phoneNo : String!
    var roleId : String!
    var updatedAt : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        apiToken = dictionary["api_token"] as? String
        createdAt = dictionary["created_at"] as? String
        email = dictionary["email"] as? String
        emailVerifiedAt = dictionary["email_verified_at"] as? String
        firstName = dictionary["first_name"] as? String ?? ""
        id = dictionary["id"] as? Int
        lastName = dictionary["last_name"] as? String ?? ""
        phoneNo = dictionary["phone_no"] as? String
        roleId = dictionary["role_id"] as? String
        updatedAt = dictionary["updated_at"] as? String
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if apiToken != nil{
            dictionary["api_token"] = apiToken
        }
        if createdAt != nil{
            dictionary["created_at"] = createdAt
        }
        if email != nil{
            dictionary["email"] = email
        }
        if emailVerifiedAt != nil{
            dictionary["email_verified_at"] = emailVerifiedAt
        }
        if firstName != nil{
            dictionary["first_name"] = firstName
        }
        if id != nil{
            dictionary["id"] = id
        }
        if lastName != nil{
            dictionary["last_name"] = lastName
        }
        if phoneNo != nil{
            dictionary["phone_no"] = phoneNo
        }
        if roleId != nil{
            dictionary["role_id"] = roleId
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
         apiToken = aDecoder.decodeObject(forKey: "api_token") as? String
         createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
         email = aDecoder.decodeObject(forKey: "email") as? String
         emailVerifiedAt = aDecoder.decodeObject(forKey: "email_verified_at") as? String
         firstName = aDecoder.decodeObject(forKey: "first_name") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         lastName = aDecoder.decodeObject(forKey: "last_name") as? String
         phoneNo = aDecoder.decodeObject(forKey: "phone_no") as? String
         roleId = aDecoder.decodeObject(forKey: "role_id") as? String
         updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
    {
        if apiToken != nil{
            aCoder.encode(apiToken, forKey: "api_token")
        }
        if createdAt != nil{
            aCoder.encode(createdAt, forKey: "created_at")
        }
        if email != nil{
            aCoder.encode(email, forKey: "email")
        }
        if emailVerifiedAt != nil{
            aCoder.encode(emailVerifiedAt, forKey: "email_verified_at")
        }
        if firstName != nil{
            aCoder.encode(firstName, forKey: "first_name")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if lastName != nil{
            aCoder.encode(lastName, forKey: "last_name")
        }
        if phoneNo != nil{
            aCoder.encode(phoneNo, forKey: "phone_no")
        }
        if roleId != nil{
            aCoder.encode(roleId, forKey: "role_id")
        }
        if updatedAt != nil{
            aCoder.encode(updatedAt, forKey: "updated_at")
        }

    }

}
