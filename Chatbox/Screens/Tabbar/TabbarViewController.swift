//
//  TabbarViewController.swift
//  Chatbox
//
//  Created by Afnan Ahmed on 26/01/2024.
//

import UIKit

class TabbarViewController: UITabBarController {
    var tabbarnavigationController: UINavigationController!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let selectedColor   = UIColor(red: 246.0/255.0, green: 155.0/255.0, blue: 13.0/255.0, alpha: 1.0)
            let unselectedColor = UIColor(red: 16.0/255.0, green: 224.0/255.0, blue: 223.0/255.0, alpha: 1.0)

        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: unselectedColor], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: selectedColor], for: .selected)

        let vc1 = HomeBuilder().build(with: tabbarnavigationController)
        vc1.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "TabbarHeart"), tag: 0)
        vc1.tabBarItem.image = UIImage(named: "Messages")!.withRenderingMode(.alwaysOriginal)
        vc1.tabBarItem.selectedImage = UIImage(named: "MessagesSelected")!.withRenderingMode(.alwaysOriginal)

        let vc2 = CallsBuilder().build(with: tabbarnavigationController)
        vc2.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "TabbarCategorie"), tag: 1)
        vc2.tabBarItem.image = UIImage(named: "Calls")!.withRenderingMode(.alwaysOriginal)
        vc2.tabBarItem.selectedImage = UIImage(named: "CallsSelected")!.withRenderingMode(.alwaysOriginal)

        let vc3 = ContactsBuilder().build(with: tabbarnavigationController)
        vc3.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "TabbarHeart"), tag: 2)
        vc3.tabBarItem.image = UIImage(named: "Contacts")!.withRenderingMode(.alwaysOriginal)
        vc3.tabBarItem.selectedImage = UIImage(named: "ContactsSelected")!.withRenderingMode(.alwaysOriginal)

        let vc4 = SettingsBuilder().build(with: tabbarnavigationController)
        vc4.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "TabbarPlus"), tag: 3)
        vc4.tabBarItem.image = UIImage(named: "Setting")!.withRenderingMode(.alwaysOriginal)
        vc4.tabBarItem.selectedImage = UIImage(named: "SettingSelected")!.withRenderingMode(.alwaysOriginal)

        self.viewControllers = [vc1, vc2, vc3, vc4]
        self.tabBar.backgroundColor = .white
        self.tabBar.barTintColor = UIColor.black
        let lineView = UIView(frame: CGRect(x: 0, y: -10, width:tabBar.frame.size.width, height: 10))
        lineView.backgroundColor = UIColor(named: "24786D")
        tabBar.addSubview(lineView)
        let lineView2 = UIView(frame: CGRect(x: 0, y: -9, width:tabBar.frame.size.width, height: 9))
        lineView2.backgroundColor = UIColor.white
        tabBar.addSubview(lineView2)
        
    }
}
