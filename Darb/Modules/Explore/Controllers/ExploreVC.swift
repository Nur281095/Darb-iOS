//
//  ExploreVC.swift
//  Darb
//
//  Created by Naveed ur Rehman on 17/11/2022.
//

import UIKit

class ExploreVC: BaseVC {

    @IBOutlet weak var mapsBtn: UIButton!
    @IBOutlet weak var filterBtn: UIButton!
    @IBOutlet weak var colV: UICollectionView!
    @IBOutlet weak var search: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapsBtn.setTitle("", for: .normal)
        filterBtn.setTitle("", for: .normal)
        self.navigationItem.leftBarButtonItem = btnLogo(image: UIImage(named: "homeNavLogo")!)
        self.navigationItem.rightBarButtonItem = btnRight(image: "ic_noti", isOrignal: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func btnRightAction(_ sender: Any) {
        let vc = UIStoryboard.storyBoard(withName: .home).loadViewController(withIdentifier: .notificationVC) as! NotificationVC
        self.show(vc, sender: self)
    }
    
    @IBAction func filterTap(_ sender: Any) {
        let vc = UIStoryboard.storyBoard(withName: .explore).loadViewController(withIdentifier: .schoolFilterVC) as! SchoolFilterVC
        self.show(vc, sender: self)
    }
}

extension ExploreVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 238)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SchoolListCell", for: indexPath) as! SchoolListCell
        DispatchQueue.main.async {
            cell.shadV.addShadow(12)
        }
        cell.rating.set(image: UIImage(named: "ic_star")!, with: " 4.1")
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard.storyBoard(withName: .explore).loadViewController(withIdentifier: .exploreMapVC) as! ExploreMapVC
        self.show(vc, sender: self)
    }
}

