//
//  ForgotPassVC.swift
//  Darb
//
//  Created by Naveed ur Rehman on 19/11/2022.
//

import UIKit
import SwiftyJSON

class ForgotPassVC: BaseVC {
    

    @IBOutlet weak var emailTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backTap(_ sender: Any) {
        self.goBack()
    }
    
    @IBAction func continueTap(_ sender: Any) {
        self.resignAll()
        let emailValid = Validator.validateEmail(text: emailTxt.text)
        if !emailValid.0 {
            print(emailValid.1)
            self.showTool(msg: emailValid.1, state: .error)
            return
        }
        
        var dic = Dictionary<String, AnyObject>()
        dic["email"] = emailTxt.text as AnyObject
       
        print(dic)
        Util.shared.showSpinner()
        ALF.shared.doPostData(parameters: dic, method: "auth/send_forget_password_link") { response in
            Util.shared.hideSpinner()
            print(response)
            DispatchQueue.main.async {
                let json = JSON(response)
                if let status = json["status_code"].int {
                    if status == 200 {
                        self.showTool(msg: json["message"].string ?? "Verification Code sent to email", state: .success)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            let vc = UIStoryboard.storyBoard(withName: .auth).loadViewController(withIdentifier: .otpVC) as! OtpVC
                            vc.email = self.emailTxt.text!
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
