//
//  SchoolFilterVC.swift
//  Darb
//
//  Created by Naveed ur Rehman on 23/11/2022.
//

import UIKit
import MultiSlider

class SchoolFilterVC: BaseVC {

    @IBOutlet weak var slider: MultiSlider!
    @IBOutlet weak var maleChk: UIImageView!
    @IBOutlet weak var femaleChk: UIImageView!
    
    @IBOutlet weak var academicGradeTxt: UITextField!
    @IBOutlet weak var curiculmTxt: UITextField!
    @IBOutlet weak var locTxt: UITextField!
    @IBOutlet weak var ratingTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.leftBarButtonItem = btnBack(isOrignal: false)
        self.navigationItem.rightBarButtonItem = btnRight(text: "Reset", isOrignal: false)
        self.navigationItem.title = "Filter"
        
        setupSlider()
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
    }
    @IBAction func maleTap(_ sender: Any) {
    }
    @IBAction func acdemicGradeTap(_ sender: Any) {
    }
    @IBAction func curiculumTap(_ sender: Any) {
    }
    @IBAction func locTap(_ sender: Any) {
    }
    @IBAction func ratTap(_ sender: Any) {
    }
   
    @IBAction func applyTap(_ sender: Any) {
    }
    

}
