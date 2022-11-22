//
//  TabbarVC.swift
//  EyecareBrands
//
//  Created by Noblemetric Technology on 26/08/2022.
//

import UIKit

class TabbarVC: UITabBarController,UITabBarControllerDelegate,UINavigationControllerDelegate{
    
    //Designer
    let homeVC = UIStoryboard.storyBoard(withName: .home).loadViewController(withIdentifier: .homeVC) as! HomeVC
    let exploreVC = UIStoryboard.storyBoard(withName: .explore).loadViewController(withIdentifier: .exploreVC) as! ExploreVC
    let chatsVC = UIStoryboard.storyBoard(withName: .chat).loadViewController(withIdentifier: .conversationsVC) as! ConversationsVC
    let moreVC = UIStoryboard.storyBoard(withName: .more).loadViewController(withIdentifier: .moreVC) as! MoreVC
    
    
    init() {
        // perform some initialization here
        super.init(nibName: nil, bundle: nil)
       
        
        /********************* For home Tab *********************/
        
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "ic_home"), selectedImage: UIImage(named: "ic_home_selected"))
        homeVC.tabBarItem.tag = 0
        let homeNav = UINavigationController(rootViewController: homeVC)
        
        exploreVC.tabBarItem = UITabBarItem(title: "Explore", image: UIImage(named: "ic_explore"), selectedImage: UIImage(named: "ic_explore_selected"))
        exploreVC.tabBarItem.tag = 1
        let exploreNav = UINavigationController(rootViewController: exploreVC)
        
        chatsVC.tabBarItem = UITabBarItem(title: "Chats", image: UIImage(named: "ic_chat"), selectedImage: UIImage(named: "ic_chat_selected"))
        chatsVC.tabBarItem.tag = 2
        let chatsNav = UINavigationController(rootViewController: chatsVC)
        
        moreVC.tabBarItem = UITabBarItem(title: "More", image: UIImage(named: "ic_more"), selectedImage: UIImage(named: "ic_more_selected"))
        let moreNav = UINavigationController(rootViewController: moreVC)
       
        viewControllers = [homeNav,exploreNav,chatsNav, moreNav]
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        self.delegate = self
        self.tabBar.isTranslucent = false
        
        self.tabBar.barTintColor = UIColor(hexString: "#F9F9F9")
        self.tabBar.tintColor = UIColor(hexString: "#386AFF")
        self.tabBar.backgroundColor = UIColor(hexString: "#F9F9F9")
        self.tabBar.unselectedItemTintColor = UIColor(hexString: "#000000")
        
//        self.tabBar.layer.masksToBounds = true
//        self.tabBar.layer.cornerRadius = 20
//        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
//        UITabBar.appearance().shadowImage = UIImage()
//        UITabBar.appearance().backgroundImage = UIImage()
//        UITabBar.appearance().clipsToBounds = true
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Roboto-Regular", size: 12)!], for: .normal)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    private func findSelectedTagForTabBarController(tabBarController: UITabBarController?) {
        
        if let tabBarController = tabBarController {
            if let viewControllers = tabBarController.viewControllers {
                let selectedIndex = tabBarController.selectedIndex
                let selectedController: UIViewController? = viewControllers.count > selectedIndex ? viewControllers[selectedIndex] : nil
                if let tag = selectedController?.tabBarItem.tag {
                    //here you can use your tag
                    print(tag)
                }
            }
        }
    }
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        //findSelectedTagForTabBarController(navigationController.tabBarController)
        print("print \(viewController)")
        
        
    }
    
}

extension UITabBarController {
  func removeTabbarItemsText() {
    tabBar.items?.forEach {
      $0.title = nil
      $0.imageInsets = UIEdgeInsets(top: 11, left: 0, bottom: -11, right: 0)
    }
  }
}
