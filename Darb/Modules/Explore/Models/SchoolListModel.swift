//
//  SchoolListModel.swift
//  Darb
//
//  Created by Naveed ur Rehman on 29/11/2022.
//

import UIKit

class SchoolListModel: NSObject, NSCoding{
    
    var adminId : String!
    var buildings : String!
    var city : String!
    var classrooms : String!
    var createdAt : String!
    var descriptionField : String!
    var gallery : [Gallery]!
    var id : Int!
    var laborarities : String!
    var lang : String!
    var lat : String!
    var levelOfEducation : String!
    var location : String!
    var mail : String!
    var name : String!
    var offeredCurriculum : String!
    var phone : String!
    var studentType : String!
    var totalReviews : String!
    var transportation : String!
    var updatedAt : String!
    var website : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        adminId = dictionary["admin_id"] as? String
        buildings = dictionary["buildings"] as? String
        city = dictionary["city"] as? String
        classrooms = dictionary["classrooms"] as? String
        createdAt = dictionary["created_at"] as? String
        descriptionField = dictionary["description"] as? String
        gallery = [Gallery]()
        if let galleryArray = dictionary["gallery"] as? [[String:Any]]{
            for dic in galleryArray{
                let value = Gallery(fromDictionary: dic)
                gallery.append(value)
            }
        }
        id = dictionary["id"] as? Int
        laborarities = dictionary["laborarities"] as? String
        lang = dictionary["lang"] as? String
        lat = dictionary["lat"] as? String
        levelOfEducation = dictionary["level_of_education"] as? String
        location = dictionary["location"] as? String
        mail = dictionary["mail"] as? String
        name = dictionary["name"] as? String
        offeredCurriculum = dictionary["offered_curriculum"] as? String
        phone = dictionary["phone"] as? String
        studentType = dictionary["student_type"] as? String
        totalReviews = dictionary["total_reviews"] as? String
        transportation = dictionary["transportation"] as? String
        updatedAt = dictionary["updated_at"] as? String
        website = dictionary["website"] as? String
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if adminId != nil{
            dictionary["admin_id"] = adminId
        }
        if buildings != nil{
            dictionary["buildings"] = buildings
        }
        if city != nil{
            dictionary["city"] = city
        }
        if classrooms != nil{
            dictionary["classrooms"] = classrooms
        }
        if createdAt != nil{
            dictionary["created_at"] = createdAt
        }
        if descriptionField != nil{
            dictionary["description"] = descriptionField
        }
        if gallery != nil{
            var dictionaryElements = [[String:Any]]()
            for galleryElement in gallery {
                dictionaryElements.append(galleryElement.toDictionary())
            }
            dictionary["gallery"] = dictionaryElements
        }
        if id != nil{
            dictionary["id"] = id
        }
        if laborarities != nil{
            dictionary["laborarities"] = laborarities
        }
        if lang != nil{
            dictionary["lang"] = lang
        }
        if lat != nil{
            dictionary["lat"] = lat
        }
        if levelOfEducation != nil{
            dictionary["level_of_education"] = levelOfEducation
        }
        if location != nil{
            dictionary["location"] = location
        }
        if mail != nil{
            dictionary["mail"] = mail
        }
        if name != nil{
            dictionary["name"] = name
        }
        if offeredCurriculum != nil{
            dictionary["offered_curriculum"] = offeredCurriculum
        }
        if phone != nil{
            dictionary["phone"] = phone
        }
        if studentType != nil{
            dictionary["student_type"] = studentType
        }
        if totalReviews != nil{
            dictionary["total_reviews"] = totalReviews
        }
        if transportation != nil{
            dictionary["transportation"] = transportation
        }
        if updatedAt != nil{
            dictionary["updated_at"] = updatedAt
        }
        if website != nil{
            dictionary["website"] = website
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         adminId = aDecoder.decodeObject(forKey: "admin_id") as? String
         buildings = aDecoder.decodeObject(forKey: "buildings") as? String
         city = aDecoder.decodeObject(forKey: "city") as? String
         classrooms = aDecoder.decodeObject(forKey: "classrooms") as? String
         createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
         descriptionField = aDecoder.decodeObject(forKey: "description") as? String
         gallery = aDecoder.decodeObject(forKey :"gallery") as? [Gallery]
         id = aDecoder.decodeObject(forKey: "id") as? Int
         laborarities = aDecoder.decodeObject(forKey: "laborarities") as? String
         lang = aDecoder.decodeObject(forKey: "lang") as? String
         lat = aDecoder.decodeObject(forKey: "lat") as? String
         levelOfEducation = aDecoder.decodeObject(forKey: "level_of_education") as? String
         location = aDecoder.decodeObject(forKey: "location") as? String
         mail = aDecoder.decodeObject(forKey: "mail") as? String
         name = aDecoder.decodeObject(forKey: "name") as? String
         offeredCurriculum = aDecoder.decodeObject(forKey: "offered_curriculum") as? String
         phone = aDecoder.decodeObject(forKey: "phone") as? String
         studentType = aDecoder.decodeObject(forKey: "student_type") as? String
         totalReviews = aDecoder.decodeObject(forKey: "total_reviews") as? String
         transportation = aDecoder.decodeObject(forKey: "transportation") as? String
         updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String
         website = aDecoder.decodeObject(forKey: "website") as? String

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
    {
        if adminId != nil{
            aCoder.encode(adminId, forKey: "admin_id")
        }
        if buildings != nil{
            aCoder.encode(buildings, forKey: "buildings")
        }
        if city != nil{
            aCoder.encode(city, forKey: "city")
        }
        if classrooms != nil{
            aCoder.encode(classrooms, forKey: "classrooms")
        }
        if createdAt != nil{
            aCoder.encode(createdAt, forKey: "created_at")
        }
        if descriptionField != nil{
            aCoder.encode(descriptionField, forKey: "description")
        }
        if gallery != nil{
            aCoder.encode(gallery, forKey: "gallery")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if laborarities != nil{
            aCoder.encode(laborarities, forKey: "laborarities")
        }
        if lang != nil{
            aCoder.encode(lang, forKey: "lang")
        }
        if lat != nil{
            aCoder.encode(lat, forKey: "lat")
        }
        if levelOfEducation != nil{
            aCoder.encode(levelOfEducation, forKey: "level_of_education")
        }
        if location != nil{
            aCoder.encode(location, forKey: "location")
        }
        if mail != nil{
            aCoder.encode(mail, forKey: "mail")
        }
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }
        if offeredCurriculum != nil{
            aCoder.encode(offeredCurriculum, forKey: "offered_curriculum")
        }
        if phone != nil{
            aCoder.encode(phone, forKey: "phone")
        }
        if studentType != nil{
            aCoder.encode(studentType, forKey: "student_type")
        }
        if totalReviews != nil{
            aCoder.encode(totalReviews, forKey: "total_reviews")
        }
        if transportation != nil{
            aCoder.encode(transportation, forKey: "transportation")
        }
        if updatedAt != nil{
            aCoder.encode(updatedAt, forKey: "updated_at")
        }
        if website != nil{
            aCoder.encode(website, forKey: "website")
        }

    }

}

class Gallery : NSObject, NSCoding{

    var createdAt : String!
    var id : Int!
    var name : String!
    var schoolId : String!
    var updatedAt : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        createdAt = dictionary["created_at"] as? String
        id = dictionary["id"] as? Int
        name = dictionary["name"] as? String
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
        if id != nil{
            dictionary["id"] = id
        }
        if name != nil{
            dictionary["name"] = name
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
         id = aDecoder.decodeObject(forKey: "id") as? Int
         name = aDecoder.decodeObject(forKey: "name") as? String
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
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }
        if schoolId != nil{
            aCoder.encode(schoolId, forKey: "school_id")
        }
        if updatedAt != nil{
            aCoder.encode(updatedAt, forKey: "updated_at")
        }

    }

}

