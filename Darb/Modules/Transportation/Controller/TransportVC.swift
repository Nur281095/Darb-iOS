//
//  TransportVC.swift
//  Darb
//
//  Created by Naveed ur Rehman on 25/11/2022.
//

import UIKit
import LocationPicker
import MapKit

class TransportVC: BaseVC {
    
    @IBOutlet weak var selectChildTxt: UITextField!
    @IBOutlet weak var locTxt: UITextField!
    @IBOutlet weak var mapsBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.leftBarButtonItem = btnBack(isOrignal: false)
        self.navigationItem.title = "Transportation"
        mapsBtn.setTitle("", for: .normal)
    }

    @IBAction func childTap(_ sender: UIButton) {
        
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
            self.locTxt.text = location?.address    
        }

        navigationController?.pushViewController(locationPicker, animated: true)
    }
    
    @IBAction func submitTap(_ sender: UIButton) {
        let vc = UIStoryboard.storyBoard(withName: .transport).loadViewController(withIdentifier: .transportListVC) as! TransportListVC
        self.show(vc, sender: self)
    }
}
