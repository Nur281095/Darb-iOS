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
    
    var child: Child!
    var isAdd = false
    lazy var imagePicker = ImagePicker()
    
    enum DocType {
        case birh
        case photo
        case health
    }
    var docTyp = DocType.birh
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.leftBarButtonItem = btnBack(isOrignal: false)
        self.navigationItem.title = isAdd ? "Add Child" : "Update Child"
        
        updateBtn.setTitle(isAdd ? "Add" : "Update", for: .normal)
        if child != nil {
            setData()
        }
    }
    
    func setData() {
        fNameTxt.text = child.firstName
        lNameTxt.text = child.lastName
        dobTxt.text = child.dob
        idTxt.text = child.nationalId ?? ""
        bCertTxt.text = child.birthCertificate ?? ""
        portPhotoTxt.text = child.portraitPhoto ?? ""
        heathRepTxt.text = child.healthReport ?? ""
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
    }
}

extension AddChildVC: ImagePickerDelegate {
    // MARK: - imagePickerDelegate
    func imagePickerDelegate(canUseCamera accessIsAllowed: Bool, delegatedForm: ImagePicker) {
        
    }
    
    func imagePickerDelegate(canUseGallery accessIsAllowed: Bool, delegatedForm: ImagePicker) {
        
    }
    
    func imagePickerDelegate(didSelect image: UIImage, delegatedForm: ImagePicker) {
        self.imagePicker.dismiss()
//        self.img.image = image
//        self.showSpin()
//        if let data = image.jpeg(.medium) { // convert your UIImage into Data object using png representation
//            FirebaseStorageManager().uploadImageData(data: data, serverFileName: generateCurrentTimeStamp()) { (isSuccess, url) in
//                print("uploadImageData: \(isSuccess), \(url)")
//                var data = [String: Any]()
//
//                data["image"] = url as Any
//                self.homeVM.updateUser(data, "device_uid", self.device_uid) { success, message in
//                    self.hideSpin()
//
//                }
//            }
//        }
        
    }
    
    func imagePickerDelegate(didCancel delegatedForm: ImagePicker) {
        
    }
    
    func generateCurrentTimeStamp() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy_MM_dd_hh_mm_ss"
        return (formatter.string(from: Date()) as NSString) as String
    }
}
