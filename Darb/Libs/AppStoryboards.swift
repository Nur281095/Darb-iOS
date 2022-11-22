//
//  AppStoryboards.swift
//  EyecareBrands
//
//  Created by Naveed ur Rehman on 26/08/2022.
//
import UIKit

extension UIStoryboard {
    
    //MARK:- Generic Public/Instance Methods
    
    func loadViewController(withIdentifier identifier: viewControllers) -> UIViewController {
        return self.instantiateViewController(withIdentifier: identifier.rawValue)
    }
    
    //MARK:- Class Methods to load Storyboards
    
    class func storyBoard(withName name: storyboards) -> UIStoryboard {
        return UIStoryboard(name: name.rawValue , bundle: Bundle.main)
    }
    
    class func storyBoard(withTextName name:String) -> UIStoryboard {
        return UIStoryboard(name: name , bundle: Bundle.main)
    }
    
}

enum storyboards : String {
    case auth = "Auth",
         home = "Home",
         chat = "Chat",
         explore = "Explore",
         more = "More",
         child = "Child"
}

enum viewControllers: String {
    
    //Main Storyboard
    case loginVC = "LoginVC",
         signupVC = "SignupVC",
         welcomeVC = "WelcomeVC",
         homeVC = "HomeVC",
         moreVC = "MoreVC",
         conversationsVC = "ConversationsVC",
         exploreVC = "ExploreVC",
         resetPassVC = "ResetPassVC",
         otpVC = "OtpVC",
         forgotPassVC = "ForgotPassVC",
         annoucementDetailVC = "AnnoucementDetailVC",
         notificationVC = "NotificationVC",
         childernListVC = "ChildernListVC",
         childProfileVC = "ChildProfileVC",
         schoolSubjectsVC = "SchoolSubjectsVC",
         addChildVC = "AddChildVC"
}
