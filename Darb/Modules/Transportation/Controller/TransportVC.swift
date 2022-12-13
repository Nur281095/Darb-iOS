//
//  TransportVC.swift
//  Darb
//
//  Created by Naveed ur Rehman on 25/11/2022.
//

import UIKit
import LocationPicker
import MapKit
import SwiftyJSON
import DropDown

class TransportVC: BaseVC {
    
    @IBOutlet weak var selectChildTxt: UITextField!
    @IBOutlet weak var locTxt: UITextField!
    @IBOutlet weak var mapsBtn: UIButton!

    var childs = [Child]()
    var childID = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.leftBarButtonItem = btnBack(isOrignal: false)
        self.navigationItem.title = "Transportation"
        mapsBtn.setTitle("", for: .normal)
        getChilds()
    }

    func getChilds() {
        self.childs.removeAll()
        Util.shared.showSpinner()
        ALF.shared.doGetData(parameters: [:], method: "childs") { response in
            Util.shared.hideSpinner()
            print(response)
            DispatchQueue.main.async {
                let json = JSON(response)
                if let status = json["status_code"].int {
                    if statusRange.contains(status) {
                        if let data = response["data"] as? [[String: Any]] {
                            for d in data {
                                self.childs.append(Child(fromDictionary: d))
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
    
    @IBAction func childTap(_ sender: UIButton) {
        let dropDown = DropDown()
        dropDown.dataSource = childs.map({$0.firstName + $0.lastName})
        
        dropDown.anchorView = sender
        dropDown.cellHeight = 51
        
        dropDown.setupCornerRadius(8)
        dropDown.textColor = .black
        
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)! + 10)
        dropDown.topOffset = CGPoint(x: 0, y: -(dropDown.anchorView?.plainView.bounds.height)! - 10)
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.selectChildTxt.text = item
            self.childID = self.childs[index].id
        }
        
        dropDown.width = sender.frame.width
        dropDown.direction = .any
        dropDown.show()
    }
    
    @IBAction func locTap(_ sender: UIButton) {
        let locationPicker = LocationPickerViewController()

        // you can optionally set initial location
        let placemark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 37.331686, longitude: -122.030656), addressDictionary: nil)
        let location = Location(name: "1 Infinite Loop, Cupertino", location: nil, placemark: placemark)
        locationPicker.location = location

        // button placed on right bottom corner
        locationPicker.showCurrentLocationButton = true // default: true

        // default: navigation bar's `barTintColor` or `UIColor.white`
        locationPicker.currentLocationButtonBackground = .blue

        // ignored if initial location is given, shows that location instead
        locationPicker.showCurrentLocationInitially = true // default: true

        locationPicker.mapType = .standard // default: .Hybrid

        // for searching, see `MKLocalSearchRequest`'s `region` property
        locationPicker.useCurrentLocationAsHint = true // default: false

        locationPicker.searchBarPlaceholder = "Search places" // default: "Search or enter an address"

        locationPicker.searchHistoryLabel = "Previously searched" // default: "Search History"

        // optional region distance to be used for creation region when user selects place from search results
        locationPicker.resultRegionDistance = 500 // default: 600

        locationPicker.completion = { location in
            // do some awesome stuff with location
            self.locTxt.text = location?.name
        }

        navigationController?.pushViewController(locationPicker, animated: true)
    }
    
    @IBAction func submitTap(_ sender: UIButton) {
        
        if childID == 0 {
            self.showTool(msg: "Please select a child", state: .error)
            return
        }
        let locValid = Validator.validateString(text: locTxt.text, type: "Location")
        if !locValid.0 {
            print(locValid.1)
            self.showTool(msg: locValid.1, state: .error)
            return
        }
        var dic = [String: AnyObject]()
        dic["child_id"] = childID as AnyObject
        dic["home_address"] = locTxt.text as AnyObject
        dic["status"] = "pending" as AnyObject
        
        Util.shared.showSpinner()
        ALF.shared.doPostData(parameters: dic, method: "transportations") { response in
            Util.shared.hideSpinner()
            print(response)
            DispatchQueue.main.async {
                let json = JSON(response)
                if let status = json["status_code"].int {
                    if statusRange.contains(status) {
                        self.showTool(msg: json["message"].string ?? "Transportation created successfully!", state: .success)
                        self.goBackWithDelay()
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
