//
//  SettingsBuilder.swift
//  Chatbox
//
//  Created by Afnan Ahmed on 29/01/2024.
//

import Foundation
import UIKit

class SettingsBuilder {
    func build(with navigationController: UINavigationController?) ->UIViewController {
        let vc = UIStoryboard(name: "Settings", bundle: Bundle(for: SettingsBuilder.self)).instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        let coordinater = SettingsRouter(navigationController: navigationController)
        let viewModel = SettingsViewModelImpl(router: coordinater)
        vc.viewModel = viewModel
        return vc
    }
}
