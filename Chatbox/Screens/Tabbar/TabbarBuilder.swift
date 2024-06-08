//
//  TabbarBuilder.swift
//  Chatbox
//
//  Created by Afnan Ahmed on 26/01/2024.
//

import Foundation
import UIKit

class TabbarBuilder {
    func build(with navigationController: UINavigationController?) -> UIViewController {
        let vc = UIStoryboard(name: "Tabbar", bundle: Bundle(for: TabbarBuilder.self)).instantiateViewController(withIdentifier: "TabbarViewController") as! TabbarViewController
        vc.tabbarnavigationController = navigationController
        return vc
    }
}
