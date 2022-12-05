//
//  AddChildVC.swift
//  Darb
//
//  Created by Naveed ur Rehman on 22/11/2022.
//

import UIKit
import AAExtensions
import SwiftyJSON

class AddChildVC: BaseVC {

    @IBOutlet weak var fNameTxt: UITextField!
    @IBOutlet weak var lNameTxt: UITextField!
    @IBOutlet weak var dobTxt: UITextField!
    @IBOutlet weak var idTxt: UITextField!
    @IBOutlet weak var bCertTxt: UITextField!
    @IBOutlet weak var portPhotoTxt: UITextField!
    @IBOutlet weak var heathRepTxt: UITextField!
    @IBOutlet weak var updateBtn: UIButton!
    @IBOutlet var browseBtns: [UIButton]!
    
    var child: Child!
    var isAdd = false
    lazy var imagePicker = ImagePicker()
    
    enum DocType {
        case birh
        case photo
        case health
    }
    var docTyp = DocType.birh
    var bCertID = -1
    var healthDocID = -1
    var portPhotoID = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.leftBarButtonItem = btnBack(isOrignal: false)
        self.navigationItem.title = isAdd ? "Add Child" : "Update Child"
        
        updateBtn.setTitle(isAdd ? "Add" : "Update", for: .normal)
        if child != nil {
            setData()
        }
        for btn in browseBtns {
            btn.setTitle("", for: .normal)
        }
    }
    
    func setData() {
        fNameTxt.text = child.firstName
        lNameTxt.text = child.lastName
        dobTxt.text = child.dob
        idTxt.text = child.nationalId ?? ""
        bCertTxt.text = child.birthCertificate.name ?? ""
        portPhotoTxt.text = child.portraitPhoto.name ?? ""
        heathRepTxt.text = child.healthReport.name ?? ""
    }
    
    
    
    @IBAction func dobTap(_ sender: Any) {
        self.resignAll()
        let calendar = Calendar(identifier: .gregorian)
        let currentDate = Date()
        var components = DateComponents()
        components.calendar = calendar
        components.year = -18
        let minDate = calendar.date(byAdding: components, to: currentDate)!
        RPicker.selectDate(title: "Select Date", cancelText: "Cancel", doneText: "Done", datePickerMode: .date, selectedDate: currentDate, minDate: minDate, maxDate: nil, style: .Wheel) { (date) in
            self.dobTxt.text = date.aa_toString(fromFormat: "yyyy-MM-dd", currentTimeZone: true)
        }
    }
    
    @IBAction func bCertTap(_ sender: Any) {
        self.resignAll()
        docTyp = .birh
        imagePicker.delegate = self
        let alertVC = UIAlertController(title: "UON",
                                        message: "Please select source",
                                        preferredStyle: .actionSheet)
        alertVC.addAction(UIAlertAction(title: "Camera", style: .default, handler: { action in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.imagePicker.present(parent: self, sourceType: .camera)
            }
        }))
        alertVC.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { action in
            self.imagePicker.present(parent: self, sourceType: .photoLibrary)
        }))
        alertVC.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            
        }))
        self.present(alertVC, animated: true, completion: nil)
    }
    
    @IBAction func portPhotoTap(_ sender: Any) {
        self.resignAll()
        docTyp = .photo
        imagePicker.delegate = self
        let alertVC = UIAlertController(title: "UON",
                                        message: "Please select source",
                                        preferredStyle: .actionSheet)
        alertVC.addAction(UIAlertAction(title: "Camera", style: .default, handler: { action in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.imagePicker.present(parent: self, sourceType: .camera)
            }
        }))
        alertVC.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { action in
            self.imagePicker.present(parent: self, sourceType: .photoLibrary)
        }))
        alertVC.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            
        }))
        self.present(alertVC, animated: true, completion: nil)
    }
    
    @IBAction func healthReportTap(_ sender: Any) {
        self.resignAll()
        docTyp = .health
        imagePicker.delegate = self
        let alertVC = UIAlertController(title: "UON",
                                        message: "Please select source",
                                        preferredStyle: .actionSheet)
        alertVC.addAction(UIAlertAction(title: "Camera", style: .default, handler: { action in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.imagePicker.present(parent: self, sourceType: .camera)
            }
        }))
        alertVC.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { action in
            self.imagePicker.present(parent: self, sourceType: .photoLibrary)
        }))
        alertVC.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            
        }))
        self.present(alertVC, animated: true, completion: nil)
    }
    
    @IBAction func updateTap(_ sender: Any) {
        self.resignAll()
        let fNameValid = Validator.validateString(text: fNameTxt.text, type: "First name")
        if !fNameValid.0 {
            print(fNameValid.1)
            self.showTool(msg: fNameValid.1, state: .error)
            return
        }
        
        let lNameValid = Validator.validateString(text: fNameTxt.text, type: "Last name")
        if !lNameValid.0 {
            print(lNameValid.1)
            self.showTool(msg: lNameValid.1, state: .error)
            return
        }
        
        let dobValid = Validator.validateString(text: dobTxt.text, type: "Birthday")
        if !dobValid.0 {
            print(dobValid.1)
            self.showTool(msg: dobValid.1, state: .error)
            return
        }
        
        let idValid = Validator.validateString(text: idTxt.text, type: "National ID")
        if !idValid.0 {
            print(idValid.1)
            self.showTool(msg: idValid.1, state: .error)
            return
        }
        
        if isAdd {
            if bCertID == -1 {
                self.showTool(msg: "Birth Certificate", state: .error)
                return
            }
            
            if healthDocID == -1 {
                self.showTool(msg: "Health Report", state: .error)
                return
            }
            if portPhotoID == -1 {
                self.showTool(msg: "Portrait Photo", state: .error)
                return
            }
        } else {
            if bCertTxt.aa_isEmpty {
                self.showTool(msg: "Birth Certificate", state: .error)
                return
            }
            
            if heathRepTxt.aa_isEmpty {
                self.showTool(msg: "Health Report", state: .error)
                return
            }
            if portPhotoTxt.aa_isEmpty {
                self.showTool(msg: "Portrait Photo", state: .error)
                return
            }
        }
        
        
        
        var dic = Dictionary<String, AnyObject>()
        dic["first_name"] = fNameTxt.text as AnyObject
        dic["last_name"] = lNameTxt.text as AnyObject
        dic["dob"] = dobTxt.text as AnyObject
        dic["national_id"] = idTxt.text as AnyObject
        if bCertID != -1 {
            dic["birth_certificate"] = bCertID as AnyObject
        } else {
            dic["birth_certificate"] = child.birthCertificate.id as AnyObject
        }
        
        if healthDocID != -1 {
            dic["health_report"] = healthDocID as AnyObject
        } else {
            dic["health_report"] = child.healthReport.id as AnyObject
        }
        if portPhotoID != -1 {
            dic["portrait_photo"] = portPhotoID as AnyObject
        } else {
            dic["portrait_photo"] = child.birthCertificate.id as AnyObject
        }
        
        var method = ""
        if child != nil {
            method = "childs/\(String(describing: child.id!))"
            dic["_method"] = "PUT" as AnyObject
        } else {
            method = "childs"
        }
        print(dic)
        Util.shared.showSpinner()
        ALF.shared.doPostData(parameters: dic, method: method) { response in
            Util.shared.hideSpinner()
            print(response)
            DispatchQueue.main.async {
                let json = JSON(response)
                if let status = json["status_code"].int {
                    if statusRange.contains(status) {
                        
                        self.showTool(msg: !self.isAdd ? "Child updated successfully" : "Child added successfully", state: .success)
                        if self.isAdd {
                            self.goBackWithDelay()
                        } else {
                            self.goRootWithDelay()
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

extension AddChildVC: ImagePickerDelegate {
    // MARK: - imagePickerDelegate
    func imagePickerDelegate(canUseCamera accessIsAllowed: Bool, delegatedForm: ImagePicker) {
        
    }
    
    func imagePickerDelegate(canUseGallery accessIsAllowed: Bool, delegatedForm: ImagePicker) {
        
    }
    func imagePickerDelegate(didSelect image: UIImage, url: URL?, delegatedForm: ImagePicker) {
        
        self.imagePicker.dismiss()
        if docTyp == .birh {
            bCertTxt.text = "birthcertificate"
        } else if docTyp == .health {
            heathRepTxt.text = "healthcertificate"
        } else {
            portPhotoTxt.text = "photo"
        }
        
        self.uploadFile(file: image, name: generateCurrentTimeStamp())
    }
    
    func imagePickerDelegate(didCancel delegatedForm: ImagePicker) {
        self.imagePicker.dismiss()
    }
    
    func generateCurrentTimeStamp() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy_MM_dd_hh_mm_ss"
        return (formatter.string(from: Date()) as NSString) as String
    }
    
    func uploadFile(file: UIImage, name: String) {
        Util.shared.showSpinner()
        ALF.shared.doPostDataWithImage(parameters: [:], method: "upload_file", image: file, fileName: "name") { response in
            Util.shared.hideSpinner()
            print(response)
            DispatchQueue.main.async {
                let json = JSON(response)
                if let status = json["status_code"].int {
                    if statusRange.contains(status) {
                        if self.docTyp == .birh {
                            self.bCertID = json["data"]["id"].intValue
                        } else if self.docTyp == .health {
                            self.healthDocID = json["data"]["id"].intValue
                        } else {
                            self.portPhotoID = json["data"]["id"].intValue
                        }
                        self.showTool(msg: json["message"].string ?? "file added successfully", state: .success)
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
