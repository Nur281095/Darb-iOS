//
//  SchoolFilterVC.swift
//  Darb
//
//  Created by Naveed ur Rehman on 23/11/2022.
//

import UIKit
import MultiSlider
import DropDown

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
    var acadmicLevelIndex = -1
    var curiculmIndex = -1
    var locIndex = -1
    var ratingIndex = -1
    var delegate: SchoolFilterDelegate?
    var params = [String: AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.leftBarButtonItem = btnBack(isOrignal: false)
        self.navigationItem.rightBarButtonItem = btnRight(text: "Reset", isOrignal: false)
        self.navigationItem.title = "Filter"
        
        setupSlider()
        setupData()
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
        
        acadmicLevelIndex = -1
        curiculmIndex = -1
        locIndex = -1
        ratingIndex = -1
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
            self.acadmicLevelIndex = ["Kindergarten", "Primary", "Lower Secondary", "Upper Secondary"].firstIndex(where: {$0 == levelOFEdu.capitalized}) ?? -1
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

        femaleChk.image = UIImage(named: "ic_checked_checkbox")
        maleChk.image = UIImage(named: "ic_unchecked_checkbox")
        isFemaleChk = true
        isMaleChk = false
        
        params["student_type"] = "girl" as AnyObject
    }
    @IBAction func maleTap(_ sender: Any) {

        maleChk.image = UIImage(named: "ic_checked_checkbox")
        femaleChk.image = UIImage(named: "ic_unchecked_checkbox")
        isFemaleChk = false
        isMaleChk = true
        params["student_type"] = "boy" as AnyObject
    }
    @IBAction func acdemicGradeTap(_ sender: UIButton) {
        let levels = ["Kindergarten", "Primary", "Lower Secondary", "Upper Secondary"]
        let dropDown = DropDown()
        dropDown.dataSource = levels
        
        dropDown.anchorView = sender
        dropDown.cellHeight = 51
        
        dropDown.setupCornerRadius(8)
        dropDown.textColor = .black
        
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)! + 10)
        dropDown.topOffset = CGPoint(x: 0, y: -(dropDown.anchorView?.plainView.bounds.height)! - 10)
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            params["level_of_education"] = item.lowercased() as AnyObject
            self.academicGradeTxt.text = item
            self.acadmicLevelIndex = index
        }
        if acadmicLevelIndex != -1 {
            dropDown.selectRow(acadmicLevelIndex, scrollPosition: .middle)
        }
       
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
            params["name"] = item.lowercased() as AnyObject
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
                params["reviews"] = "1" as AnyObject
            } else if index == 1 {
                params["reviews"] = "2" as AnyObject
            } else if index == 2 {
                params["reviews"] = "3" as AnyObject
            } else if index == 3 {
                params["reviews"] = "4" as AnyObject
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
        delegate?.didTapApply(params: params)
        self.goBack()
    }
    

}
