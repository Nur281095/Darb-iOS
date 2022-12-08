import UIKit
import Photos
import AAExtensions

import SystemConfiguration

typealias OkBlock = () -> Void
typealias cancelBlock = () -> Void
class Util: NSObject
{
    static let shared = Util()
    var container: UIView = UIView()
    var loadingView: UIView = UIView()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var isGuest = false
    var isWelcome = false
   
    class func isLoggedIn() -> Bool {
        if self.getUser() != nil {
            return true
        } else {
            return false
        }
    }
    class func getUser() -> User?{
        if let usrStr = UserDefaults.standard.object(forKey: "user") as? String {
            if let userJson = usrStr.aa_toJson {
                let usr = User(fromDictionary: userJson)
                return usr
            }
        }
        return nil
    }
    class func logout() {
        DispatchQueue.main.async {
            let domain = Bundle.main.bundleIdentifier!
            UserDefaults.standard.removePersistentDomain(forName: domain)
            UserDefaults.standard.synchronize()
            SceneDelegate.shared?.checkUserLoggedIn()
        }
    }
   
    public func isConnected() -> Bool {
        var bool = false
        let status = Reach().connectionStatus()
        switch status {
        case .unknown, .offline:
            print("Not connected")
            bool = false
        case .online(.wwan):
            print("Connected via WWAN")
            bool = true
        case .online(.wiFi):
            print("Connected via WiFi")
            bool = true
        }
        return bool
    }
    public func updateDevice(token: String) {
        
        var dic = Dictionary<String,AnyObject>()
        dic["device_id"] = token as AnyObject
        dic["device_type"] = "ios" as AnyObject
        print(dic)
        DispatchQueue.background(background: {
           
            ALF.shared.doPostData(parameters: dic, method: "update_device_token", success: { (response) in
                print(response)
                
            }) { (response) in
                
                print(response)
                
            }
        }, completion:{
            print("DeiceIdUpdate Finish")
        })
        
    }
    public func saveDicToDefaults(forKey key: String, dic: Any){
        let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: [])
        let jsonString = String(data: jsonData!, encoding: .utf8)
        
        UserDefaults.standard.set(jsonString, forKey: key)
    }
    public func getDicFromDefaults(forKey key: String) -> Any? {
        let jsonString = UserDefaults.standard.object(forKey: key) as! String
        let jsonData = jsonString.data(using: .utf8)!
        let dictionary = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableLeaves)
        return dictionary
    }
    public func getAssetThumbnail(asset: PHAsset) -> UIImage {
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        var thumbnail = UIImage()
        option.isSynchronous = true
//        manager.requestImage(for: asset, targetSize: CGSize(width: asset.pixelWidth, height: asset.pixelHeight), contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
//            thumbnail = result!
//        })
        manager.requestImageData(for: asset, options: option) { data, str, _, _ in

            if let data = data {
                thumbnail = UIImage(data: data)!
            }
        }
    
        return thumbnail
        
    }
    private func setSpinner() {
       
        let window = SceneDelegate.shared?.window
        
        loadingView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        
        activityIndicator.color = UIColor(hexString: "#ffffff")
        activityIndicator.tintColor = UIColor(hexString: "#ffffff")
        activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2,y :loadingView.frame.size.height / 2)
        loadingView.addSubview(activityIndicator)
        loadingView.center = window!.center
        self.setGradientBackground(view: loadingView)
        window?.addSubview(loadingView)
        
        window?.isUserInteractionEnabled = false

        activityIndicator.startAnimating()
    }
    public func showSpinner() {
        DispatchQueue.main.async {
            self.setSpinner()
        }
    }
    public func hideSpinner() {
        DispatchQueue.main.async {
            self.removeSpinner()
        }
    }
    private func removeSpinner() {
        let window = SceneDelegate.shared?.window
        
        activityIndicator.stopAnimating()
        window?.isUserInteractionEnabled = true
        //        uiView.isUserInteractionEnabled = true
        loadingView.removeFromSuperview()
    }
    private func setGradientBackground(view: UIView) {
        let gradientLayer = CAGradientLayer()
        for layer in view.layer.sublayers ?? [] {
            if layer.name == "gradient" {
                layer.removeFromSuperlayer()
            }
        }
        gradientLayer.colors = [UIColor(hexString: "#FE8569").cgColor, UIColor(hexString: "#FE8569").cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = view.bounds
        view.layer.layoutIfNeeded()
        
        gradientLayer.name = "gradient"
        view.layer.insertSublayer(gradientLayer, at: 0)
        view.layer.layoutIfNeeded()
    }
    class func timeAgoSinceDate(date:NSDate, numericDates:Bool) -> String {
        let calendar = NSCalendar.current
        let unitFlags: Set<Calendar.Component> = [.minute, .hour, .day, .weekOfYear, .month, .year, .second]
        let now = NSDate()
        let earliest = now.earlierDate(date as Date)
        let latest = (earliest == now as Date) ? date : now
        var components = calendar.dateComponents(unitFlags, from: earliest as Date,  to: latest as Date)
//        print(components)
        
        if (components.year! >= 2) {
            return "\(components.year!) years"
        } else if (components.year! >= 1){
            if (numericDates){
                return "1 year"
            } else {
                return "Last year"
            }
        } else if (components.month! >= 2) {
            return "\(components.month!) months"
        } else if (components.month! >= 1){
            if (numericDates){
                return "1 month"
            } else {
                return "Last month"
            }
        } else if (components.weekOfYear! >= 2) {
            return "\(components.weekOfYear!) weeks"
        } else if (components.weekOfYear! >= 1){
            if (numericDates){
                return "1 week"
            } else {
                return "Last week"
            }
        } else if (components.day! >= 2) {
            return "\(components.day!) days"
        } else if (components.day! >= 1){
            if (numericDates){
                return "1 day"
            } else {
                return "Yesterday"
            }
        } else if (components.hour! >= 2) {
            return "\(components.hour!) hours"
        } else if (components.hour! >= 1){
            if (numericDates){
                return "1 hour"
            } else {
                return "A hour"
            }
        } else if (components.minute! >= 2) {
            return "\(components.minute!) minutes"
        } else if (components.minute! >= 1){
            if (numericDates){
                return "1 minute"
            } else {
                return "A minute"
            }
        } else if (components.second! >= 3) {
            return "\(components.second!) seconds"
        } else {
            return "Just now"
        }
        
    }
    
    
    class func isConnectedToNetwork() -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                
                SCNetworkReachabilityCreateWithAddress(nil, $0)
                
            }
            
        }) else {
            
            return false
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
}

