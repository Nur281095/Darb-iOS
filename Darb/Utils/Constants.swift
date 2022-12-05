//
//  Constants.swift
//  EyecareBrands
//
//  Created by Naveed ur Rehman on 26/08/2022.
//

import UIKit
import CoreLocation
var Appname = "Darb"

let statusRange = 200...299

struct AppColors {
    static var concrete_solid : UIColor {
        return UIColor(hexString: "#F2F2F2")
    }
    static var light_bluesh_solid : UIColor {
        return UIColor(hexString: "#F5F6FA")
    }
    static var mountain_meadow : UIColor {
        return UIColor(hexString: "#1A98883")
    }
    static var client_blue : UIColor {
        return UIColor(hexString: "#285388")
    }
    static var puerto_rico : UIColor {
        return UIColor(hexString: "#47CCAF")
    }
    static var curious_blue : UIColor {
        return UIColor(hexString: "#27A8E1")
    }
    static var lochmara : UIColor {
        return UIColor(hexString: "#0477BA")
    }
    static var ser_green : UIColor {
        return UIColor(hexString: "#5CB0B2")
    }
    static var san_juan : UIColor {
        return UIColor(hexString: "#385577")
    }
    
}

struct AppUser {
//    static var default_usr: String {
//        return AppDelegate.shared().usrTyp == .client ? "client" : "tasker"
//    }
}
struct AppFonts {
    static var roboto : String {
        return "Roboto-Regular"
    }
    static var roboto_medium : String {
        return "Roboto-Medium"
    }
    static var roboto_light : String {
        return "Roboto-Light"
    }
    static var roboto_bold : String {
        return "Roboto-Bold"
    }
}
public struct SCREEN {
    static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(SCREEN.SCREEN_WIDTH, SCREEN.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(SCREEN.SCREEN_WIDTH, SCREEN.SCREEN_HEIGHT)
}

public struct KEYS {
    static let cartID = "cart_id"
    static let address = "address"

    
    static func saveCartID(id: String){
        UserDefaults.standard.set(id, forKey: KEYS.cartID)
    }
    static func getCartID() -> String {
        return UserDefaults.standard.object(forKey: KEYS.cartID) as? String ?? "632aa99d7f157"
    }
    static func saveAddress(address: String){
        UserDefaults.standard.set(address, forKey: KEYS.address)
    }
    static func getAddress() -> String {
        return UserDefaults.standard.object(forKey: KEYS.address) as? String ?? ""
    }
}
public struct AppLocation {
    static var loc: CLLocationCoordinate2D? {
        return SceneDelegate.shared?.location?.coordinate
    }
}
