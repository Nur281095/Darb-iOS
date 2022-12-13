//
//  OtpVC.swift
//  Darb
//
//  Created by Naveed ur Rehman on 19/11/2022.
//

import UIKit
import SwiftyCodeView
import SwiftyJSON

class OtpVC: BaseVC, SwiftyCodeViewDelegate {

    @IBOutlet weak var codeview: SwiftyCodeView!
    
    @IBOutlet weak var backBtn: UIButton!
    var email = ""
    var code = "" 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn.setTitle("", for: .normal)
        codeview.length = 6
        codeview.delegate = self
        codeview.becomeFirstResponder()
    }
    
    func codeView(sender: SwiftyCodeView, didFinishInput code: String) -> Bool {
        print("Entered code: ", code)
        codeview.resignFirstResponder()
        self.code = code
        self.continuieTap((Any).self)
        return true
    }
    
    @IBAction func backtap(_ sender: Any) {
        self.goBack()
    }
    
    @IBAction func continuieTap(_ sender: Any) {
        self.resignAll()
        let codeValid = Validator.validateString(text: code, type: "Code")
        if !codeValid.0 {
            print(codeValid.1)
            self.showTool(msg: codeValid.1, state: .error)
            return
        }
        
        var dic = Dictionary<String, AnyObject>()
        dic["email"] = email as AnyObject
        dic["token"] = code as AnyObject
       
        print(dic)
        Util.shared.showSpinner()
        ALF.shared.doPostData(parameters: dic, method: "auth/verify_otp") { response in
            Util.shared.hideSpinner()
            print(response)
            DispatchQueue.main.async {
                let json = JSON(response)
                if let status = json["status_code"].int {
                    if statusRange.contains(status) {
                        self.showTool(msg: json["message"].string ?? "Verification Code sent to email", state: .success)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            let token = json["reset_password_token"].stringValue
                            let vc = UIStoryboard.storyBoard(withName: .auth).loadViewController(withIdentifier: .resetPassVC) as! ResetPassVC
                            vc.resetToken = token
                            self.show(vc, sender: self)
                        }
                    } else {
                        self.showTool(msg: json["message"].string ?? "", state: .error)
                    }
                }
            }
            
        } fail: { response in
            Util.shared.hideSpinner()
            DispatchQueue.main.async {
                self.showTool(msg: response as? String ?? "Error", state: .error)
            }
        }
        
    }

}
