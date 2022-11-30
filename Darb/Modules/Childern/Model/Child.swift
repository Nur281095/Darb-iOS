//
//  Child.swift
//  Darb
//
//  Created by Naveed ur Rehman on 22/11/2022.
//

import UIKit

class Child: NSObject, NSCoding{
    
    var birthCertificate : BirthCertificate!
    var createdAt : String!
    var dob : String!
    var enrollementStatus : String!
    var firstName : String!
    var grade : Grade!
    var gradeId : String!
    var healthReport : BirthCertificate!
    var id : Int!
    var lastName : String!
    var nationalId : String!
    var portraitPhoto : BirthCertificate!
    var school : SchoolListModel!
    var schoolId : String!
    var subjects : [String]!
    var transportLocation : String!
    var updatedAt : String!
    var userId : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        if let birthCertificateData = dictionary["birth_certificate"] as? [String:Any]{
            birthCertificate = BirthCertificate(fromDictionary: birthCertificateData)
        }
        createdAt = dictionary["created_at"] as? String
        dob = dictionary["dob"] as? String
        enrollementStatus = dictionary["enrollement_status"] as? String
        firstName = dictionary["first_name"] as? String
        if let gradeData = dictionary["grade"] as? [String:Any]{
            grade = Grade(fromDictionary: gradeData)
        }
        gradeId = dictionary["grade_id"] as? String
        if let healthReportData = dictionary["health_report"] as? [String:Any]{
            healthReport = BirthCertificate(fromDictionary: healthReportData)
        }
        id = dictionary["id"] as? Int
        lastName = dictionary["last_name"] as? String
        nationalId = dictionary["national_id"] as? String
        if let portraitPhotoData = dictionary["portrait_photo"] as? [String:Any]{
            portraitPhoto = BirthCertificate(fromDictionary: portraitPhotoData)
        }
        if let schoolData = dictionary["school"] as? [String:Any]{
            school = SchoolListModel(fromDictionary: schoolData)
        }
        schoolId = dictionary["school_id"] as? String
        subjects = dictionary["subjects"] as? [String]
        transportLocation = dictionary["transport_location"] as? String
        updatedAt = dictionary["updated_at"] as? String
        userId = dictionary["user_id"] as? String
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if birthCertificate != nil{
            dictionary["birth_certificate"] = birthCertificate.toDictionary()
        }
        if createdAt != nil{
            dictionary["created_at"] = createdAt
        }
        if dob != nil{
            dictionary["dob"] = dob
        }
        if enrollementStatus != nil{
            dictionary["enrollement_status"] = enrollementStatus
        }
        if firstName != nil{
            dictionary["first_name"] = firstName
        }
        if grade != nil{
            dictionary["grade"] = grade.toDictionary()
        }
        if gradeId != nil{
            dictionary["grade_id"] = gradeId
        }
        if healthReport != nil{
            dictionary["health_report"] = healthReport.toDictionary()
        }
        if id != nil{
            dictionary["id"] = id
        }
        if lastName != nil{
            dictionary["last_name"] = lastName
        }
        if nationalId != nil{
            dictionary["national_id"] = nationalId
        }
        if portraitPhoto != nil{
            dictionary["portrait_photo"] = portraitPhoto.toDictionary()
        }
        if school != nil{
            dictionary["school"] = school.toDictionary()
        }
        if schoolId != nil{
            dictionary["school_id"] = schoolId
        }
        if subjects != nil{
            dictionary["subjects"] = subjects
        }
        if transportLocation != nil{
            dictionary["transport_location"] = transportLocation
        }
        if updatedAt != nil{
            dictionary["updated_at"] = updatedAt
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
         birthCertificate = aDecoder.decodeObject(forKey: "birth_certificate") as? BirthCertificate
         createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
         dob = aDecoder.decodeObject(forKey: "dob") as? String
         enrollementStatus = aDecoder.decodeObject(forKey: "enrollement_status") as? String
         firstName = aDecoder.decodeObject(forKey: "first_name") as? String
         grade = aDecoder.decodeObject(forKey: "grade") as? Grade
         gradeId = aDecoder.decodeObject(forKey: "grade_id") as? String
         healthReport = aDecoder.decodeObject(forKey: "health_report") as? BirthCertificate
         id = aDecoder.decodeObject(forKey: "id") as? Int
         lastName = aDecoder.decodeObject(forKey: "last_name") as? String
         nationalId = aDecoder.decodeObject(forKey: "national_id") as? String
         portraitPhoto = aDecoder.decodeObject(forKey: "portrait_photo") as? BirthCertificate
         school = aDecoder.decodeObject(forKey: "school") as? SchoolListModel
         schoolId = aDecoder.decodeObject(forKey: "school_id") as? String
         subjects = aDecoder.decodeObject(forKey: "subjects") as? [String]
         transportLocation = aDecoder.decodeObject(forKey: "transport_location") as? String
         updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String
         userId = aDecoder.decodeObject(forKey: "user_id") as? String

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
    {
        if birthCertificate != nil{
            aCoder.encode(birthCertificate, forKey: "birth_certificate")
        }
        if createdAt != nil{
            aCoder.encode(createdAt, forKey: "created_at")
        }
        if dob != nil{
            aCoder.encode(dob, forKey: "dob")
        }
        if enrollementStatus != nil{
            aCoder.encode(enrollementStatus, forKey: "enrollement_status")
        }
        if firstName != nil{
            aCoder.encode(firstName, forKey: "first_name")
        }
        if grade != nil{
            aCoder.encode(grade, forKey: "grade")
        }
        if gradeId != nil{
            aCoder.encode(gradeId, forKey: "grade_id")
        }
        if healthReport != nil{
            aCoder.encode(healthReport, forKey: "health_report")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if lastName != nil{
            aCoder.encode(lastName, forKey: "last_name")
        }
        if nationalId != nil{
            aCoder.encode(nationalId, forKey: "national_id")
        }
        if portraitPhoto != nil{
            aCoder.encode(portraitPhoto, forKey: "portrait_photo")
        }
        if school != nil{
            aCoder.encode(school, forKey: "school")
        }
        if schoolId != nil{
            aCoder.encode(schoolId, forKey: "school_id")
        }
        if subjects != nil{
            aCoder.encode(subjects, forKey: "subjects")
        }
        if transportLocation != nil{
            aCoder.encode(transportLocation, forKey: "transport_location")
        }
        if updatedAt != nil{
            aCoder.encode(updatedAt, forKey: "updated_at")
        }
        if userId != nil{
            aCoder.encode(userId, forKey: "user_id")
        }

    }

}

class Grade : NSObject, NSCoding{

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

class BirthCertificate : NSObject, NSCoding{

    var createdAt : String!
    var fileableId : String!
    var fileableType : String!
    var id : Int!
    var name : String!
    var updatedAt : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        createdAt = dictionary["created_at"] as? String
        fileableId = dictionary["fileable_id"] as? String
        fileableType = dictionary["fileable_type"] as? String
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
         fileableId = aDecoder.decodeObject(forKey: "fileable_id") as? String
         fileableType = aDecoder.decodeObject(forKey: "fileable_type") as? String
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
