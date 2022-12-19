//
//  ConversationsModel.swift
//  Darb
//
//  Created by Naveed ur Rehman on 29/11/2022.
//

import UIKit

class ConversationsModel: NSObject, NSCoding{
    
    var createdAt : String!
    var id : Int!
    var message : String!
    var receiver : Receiver!
    var receiverId : String!
    var seen : String!
    var sender : Sender!
    var senderId : String!
    var updatedAt : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        createdAt = dictionary["created_at"] as? String
        id = dictionary["id"] as? Int
        message = dictionary["message"] as? String
        if let receiverData = dictionary["receiver"] as? [String:Any]{
            receiver = Receiver(fromDictionary: receiverData)
        }
        receiverId = dictionary["receiver_id"] as? String
        seen = dictionary["seen"] as? String
        if let senderData = dictionary["sender"] as? [String:Any]{
            sender = Sender(fromDictionary: senderData)
        }
        senderId = dictionary["sender_id"] as? String
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
        if id != nil{
            dictionary["id"] = id
        }
        if message != nil{
            dictionary["message"] = message
        }
        if receiver != nil{
            dictionary["receiver"] = receiver.toDictionary()
        }
        if receiverId != nil{
            dictionary["receiver_id"] = receiverId
        }
        if seen != nil{
            dictionary["seen"] = seen
        }
        if sender != nil{
            dictionary["sender"] = sender.toDictionary()
        }
        if senderId != nil{
            dictionary["sender_id"] = senderId
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
         id = aDecoder.decodeObject(forKey: "id") as? Int
         message = aDecoder.decodeObject(forKey: "message") as? String
         receiver = aDecoder.decodeObject(forKey: "receiver") as? Receiver
         receiverId = aDecoder.decodeObject(forKey: "receiver_id") as? String
         seen = aDecoder.decodeObject(forKey: "seen") as? String
         sender = aDecoder.decodeObject(forKey: "sender") as? Sender
         senderId = aDecoder.decodeObject(forKey: "sender_id") as? String
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
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if message != nil{
            aCoder.encode(message, forKey: "message")
        }
        if receiver != nil{
            aCoder.encode(receiver, forKey: "receiver")
        }
        if receiverId != nil{
            aCoder.encode(receiverId, forKey: "receiver_id")
        }
        if seen != nil{
            aCoder.encode(seen, forKey: "seen")
        }
        if sender != nil{
            aCoder.encode(sender, forKey: "sender")
        }
        if senderId != nil{
            aCoder.encode(senderId, forKey: "sender_id")
        }
        if updatedAt != nil{
            aCoder.encode(updatedAt, forKey: "updated_at")
        }

    }

}
class Sender : NSObject, NSCoding{

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

class Receiver : NSObject, NSCoding{

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
