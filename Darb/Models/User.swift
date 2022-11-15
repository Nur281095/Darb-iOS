//
//  User.swift
//  EyecareBrands
//
//  Created by Noblemetric Technology on 9/5/22.
//

import UIKit

class User: NSObject, NSCoding{
    
    var accessToken : String!
    var email : String!
    var mobile : String!
    var name : String!
    var profilePic : String!
    var referalCode : String!
    var userId : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        accessToken = dictionary["access_token"] as? String
        email = dictionary["email"] as? String
        mobile = dictionary["mobile"] as? String
        name = dictionary["name"] as? String
        profilePic = dictionary["profilePic"] as? String
        referalCode = dictionary["referal_code"] as? String
        userId = dictionary["user_id"] as? String
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if accessToken != nil{
            dictionary["access_token"] = accessToken
        }
        if email != nil{
            dictionary["email"] = email
        }
        if mobile != nil{
            dictionary["mobile"] = mobile
        }
        if name != nil{
            dictionary["name"] = name
        }
        if profilePic != nil{
            dictionary["profilePic"] = profilePic
        }
        if referalCode != nil{
            dictionary["referal_code"] = referalCode
        }
        if userId != nil{
            dictionary["user_id"] = userId
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         accessToken = aDecoder.decodeObject(forKey: "access_token") as? String
         email = aDecoder.decodeObject(forKey: "email") as? String
         mobile = aDecoder.decodeObject(forKey: "mobile") as? String
         name = aDecoder.decodeObject(forKey: "name") as? String
         profilePic = aDecoder.decodeObject(forKey: "profilePic") as? String
         referalCode = aDecoder.decodeObject(forKey: "referal_code") as? String
         userId = aDecoder.decodeObject(forKey: "user_id") as? String

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
    {
        if accessToken != nil{
            aCoder.encode(accessToken, forKey: "access_token")
        }
        if email != nil{
            aCoder.encode(email, forKey: "email")
        }
        if mobile != nil{
            aCoder.encode(mobile, forKey: "mobile")
        }
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }
        if profilePic != nil{
            aCoder.encode(profilePic, forKey: "profilePic")
        }
        if referalCode != nil{
            aCoder.encode(referalCode, forKey: "referal_code")
        }
        if userId != nil{
            aCoder.encode(userId, forKey: "user_id")
        }

    }

}
