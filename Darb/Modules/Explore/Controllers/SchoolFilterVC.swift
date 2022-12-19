//
//  SchoolFilterVC.swift
//  Darb
//
//  Created by Naveed ur Rehman on 23/11/2022.
//

import UIKit
import MultiSlider
import DropDown
import SwiftyJSON

protocol SchoolFilterDelegate {
    func didTapApply(params: [String: AnyObject])
}

class SchoolFilterVC: BaseVC {

    @IBOutlet weak var slider: MultiSlider!
    @IBOutlet weak var maleChk: UIImageView!
    @IBOutlet weak var femaleChk: UIImageView!
    
    @IBOutlet weak var academicGradeTxt: UITextField!
    @IBOutlet weak var curiculmTxt: UITextField!
    @IBOutlet weak var locTxt: UITextField!
    @IBOutlet weak var ratingTxt: UITextField!
    
    var isMaleChk = false
    var isFemaleChk = false
    var acadmicLevelIndex = [Int]()
    var acadmicLevelIDs = [Int]()
    var curiculmIndex = -1
    var locIndex = -1
    var ratingIndex = -1
    var delegate: SchoolFilterDelegate?
    var params = [String: AnyObject]()
    var eduLvls = [EduLevels]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.leftBarButtonItem = btnBack(isOrignal: false)
        self.navigationItem.rightBarButtonItem = btnRight(text: "Reset", isOrignal: false)
        self.navigationItem.title = "Filter"
        getEduLvls()
        setupSlider()
        setupData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func btnRightAction(_ sender: Any) {
        params.removeAll()
        femaleChk.image = UIImage(named: "ic_unchecked_checkbox")
        maleChk.image = UIImage(named: "ic_unchecked_checkbox")
        isFemaleChk = false
        isMaleChk = false
        
        academicGradeTxt.text = ""
        curiculmTxt.text = ""
        locTxt.text = ""
        ratingTxt.text = ""
        
        acadmicLevelIndex.removeAll()
        curiculmIndex = -1
        locIndex = -1
        ratingIndex = -1
        
    }
    
    func getEduLvls() {
        self.eduLvls.removeAll()
        Util.shared.showSpinner()
        ALF.shared.doGetData(parameters: [:], method: "education_levels") { response in
            Util.shared.hideSpinner()
            print(response)
            DispatchQueue.main.async {
                let json = JSON(response)
                if let status = json["status_code"].int {
                    if statusRange.contains(status) {
                        if let data = response["data"] as? [[String: Any]] {
                            for d in data {
                                self.eduLvls.append(EduLevels(fromDictionary: d))
                            }
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
    
    func setupData() {
        if let type = params["student_type"] as? String {
            if type == "girl" {
                femaleChk.image = UIImage(named: "ic_checked_checkbox")
                maleChk.image = UIImage(named: "ic_unchecked_checkbox")
                isFemaleChk = true
                isMaleChk = false
            } else {
                maleChk.image = UIImage(named: "ic_checked_checkbox")
                femaleChk.image = UIImage(named: "ic_unchecked_checkbox")
                isFemaleChk = false
                isMaleChk = true
            }
        }
        
        if let levelOFEdu = params["level_of_education"] as? String {
            academicGradeTxt.text = levelOFEdu.capitalized
            var names = [String]()
            for i in acadmicLevelIndex {
                names.append(eduLvls[i].name)
            }
            self.academicGradeTxt.text = (names.map{String($0)}.joined(separator: ", "))
        }
        
        if let name = params["name"] as? String {
            curiculmTxt.text = name.capitalized
            self.curiculmIndex = ["Saudi General Curriculum ", "Islamic Curriculum", "American Curriculum", "British Curriculum"].firstIndex(where: {$0 == name.capitalized}) ?? -1
        }
        
        if let location = params["city"] as? String {
            locTxt.text = location.capitalized
            self.locIndex = ["Riyadh", "Jeddah", "Dammam", "Abha"].firstIndex(where: {$0 == location.capitalized}) ?? -1
        }
        
        if let reviews = params["reviews"] as? String {
            let reviewArr = ["4.0 & up", "3.0 & up", "2.0 & up", "1.0 & up"]
            self.ratingIndex = reviewArr.firstIndex(where: {$0.contains(reviews)}) ?? -1
            ratingTxt.text = reviewArr[self.ratingIndex]
        }
    }

    func setupSlider(){
        slider.addTarget(self, action: #selector(sliderChanged), for: .valueChanged)
        
        slider.valueLabelFormatter.positivePrefix = ""
        slider.valueLabelFormatter.positiveSuffix = ""
        
        slider.minimumValue = 0
        slider.maximumValue = 50
        
        slider.valueLabelPosition = .top
        slider.isValueLabelRelative = true
        slider.snapStepSize = 1
        slider.tintColor = UIColor(hexString: "#386AFF")
        
    }
    
    @objc func sliderChanged(_ slider: MultiSlider) {
        print("now thumbs are at \(slider.value)") // e.g., [1.0, 4.5, 5.0]
    }
    
    @IBAction func femaleTap(_ sender: Any) {
        if isFemaleChk {
            femaleChk.image = UIImage(named: "ic_unchecked_checkbox")
            isFemaleChk = false
        } else {
            femaleChk.image = UIImage(named: "ic_checked_checkbox")
            isFemaleChk = true
        }
    }
    @IBAction func maleTap(_ sender: Any) {
        if isMaleChk {
            maleChk.image = UIImage(named: "ic_unchecked_checkbox")
            isMaleChk = false
        } else {
            maleChk.image = UIImage(named: "ic_checked_checkbox")
            isMaleChk = true
        }
    }
    @IBAction func acdemicGradeTap(_ sender: UIButton) {
//        let levels = ["Kindergarten", "Primary", "Lower Secondary", "Upper Secondary"]
        
        let dropDown = DropDown()
        dropDown.dataSource = eduLvls.map({$0.name})
        
        dropDown.anchorView = sender
        dropDown.cellHeight = 51
        
        dropDown.setupCornerRadius(8)
        dropDown.textColor = .black
        
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)! + 10)
        dropDown.topOffset = CGPoint(x: 0, y: -(dropDown.anchorView?.plainView.bounds.height)! - 10)
//        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
//            print("Selected item: \(item) at index: \(index)")
//            params["level_of_education"] = item.lowercased() as AnyObject
//            self.academicGradeTxt.text = item
//            self.acadmicLevelIndex = index
//        }
//        if acadmicLevelIndex != -1 {
//            dropDown.selectRow(acadmicLevelIndex, scrollPosition: .middle)
//        }
        
        dropDown.multiSelectionAction = { [unowned self] (indexs :[Int], items: [String]) in
            self.acadmicLevelIndex = indexs
            self.academicGradeTxt.text = (items.map{String($0)}.joined(separator: ", "))

            let objectSet = Set(acadmicLevelIndex.map { $0 })
            dropDown.selectRows(at: objectSet)
            self.acadmicLevelIDs.removeAll()
            for i in acadmicLevelIndex {
                self.acadmicLevelIDs.append(eduLvls[i].id)
            }
        }
        
        let objectSet = Set(acadmicLevelIndex.map { $0 })
        dropDown.selectRows(at: objectSet)
       
        dropDown.width = sender.frame.width
        dropDown.direction = .any
        dropDown.show()
    }
    @IBAction func curiculumTap(_ sender: UIButton) {
        let curiculums = ["Saudi General Curriculum ", "Islamic Curriculum", "American Curriculum", "British Curriculum"]
        let dropDown = DropDown()
        dropDown.dataSource = curiculums
        
        dropDown.anchorView = sender
        dropDown.cellHeight = 51
        
        dropDown.setupCornerRadius(8)
        dropDown.textColor = .black
        
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)! + 10)
        dropDown.topOffset = CGPoint(x: 0, y: -(dropDown.anchorView?.plainView.bounds.height)! - 10)
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            params["offered_curriculum"] = item.lowercased() as AnyObject
            self.curiculmTxt.text = item
            self.curiculmIndex = index
        }
        if curiculmIndex != -1 {
            dropDown.selectRow(curiculmIndex, scrollPosition: .middle)
        }
        dropDown.width = sender.frame.width
        dropDown.direction = .any
        dropDown.show()
    }
    @IBAction func locTap(_ sender: UIButton) {
        let locations = ["Riyadh", "Jeddah", "Dammam", "Abha"]
        let dropDown = DropDown()
        dropDown.dataSource = locations
        
        dropDown.anchorView = sender
        dropDown.cellHeight = 51
        
        dropDown.setupCornerRadius(8)
        dropDown.textColor = .black
        
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)! + 10)
        dropDown.topOffset = CGPoint(x: 0, y: -(dropDown.anchorView?.plainView.bounds.height)! - 10)
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            params["city"] = item.lowercased() as AnyObject
            self.locTxt.text = item
            self.locIndex = index
        }
        if locIndex != -1 {
            dropDown.selectRow(locIndex, scrollPosition: .middle)
        }
        dropDown.width = sender.frame.width
        dropDown.direction = .any
        dropDown.show()
    }
    @IBAction func ratTap(_ sender: UIButton) {
        let ratings = ["4.0 & up", "3.0 & up", "2.0 & up", "1.0 & up"]
        let dropDown = DropDown()
        dropDown.dataSource = ratings
        
        dropDown.anchorView = sender
        dropDown.cellHeight = 51
        
        dropDown.setupCornerRadius(8)
        dropDown.textColor = .black
        
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)! + 10)
        dropDown.topOffset = CGPoint(x: 0, y: -(dropDown.anchorView?.plainView.bounds.height)! - 10)
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            if index == 0 {
                params["reviews"] = "4" as AnyObject
            } else if index == 1 {
                params["reviews"] = "3" as AnyObject
            } else if index == 2 {
                params["reviews"] = "2" as AnyObject
            } else if index == 3 {
                params["reviews"] = "1" as AnyObject
            }
            self.ratingTxt.text = item
            self.ratingIndex = index
        }
        if ratingIndex != -1 {
            dropDown.selectRow(ratingIndex, scrollPosition: .middle)
        }
        dropDown.width = sender.frame.width
        dropDown.direction = .any
        dropDown.show()
    }
   
    @IBAction func applyTap(_ sender: Any) {
        if isMaleChk && !isFemaleChk {
            params["student_type"] = "boy" as AnyObject
        } else if isFemaleChk && !isMaleChk {
            params["student_type"] = "girl" as AnyObject
        } else if isFemaleChk && isMaleChk {
            params["student_type"] = "all" as AnyObject
        }
        if let vc = self.navigationController!.viewControllers[self.navigationController!.viewControllers.count - 2] as? ExploreVC {
            vc.eduLvls = self.eduLvls
            vc.acadmicLevelIDs = self.acadmicLevelIDs
            vc.acadmicLevelIndex = self.acadmicLevelIndex
        }
        delegate?.didTapApply(params: params)
        self.goBack()
    }
    

}
