//
//  HomeBuilder.swift
//  Chatbox
//
//  Created by Afnan Ahmed on 26/01/2024.
//

import Foundation
import UIKit

class HomeBuilder {
    func build(with navigationController: UINavigationController?) -> UIViewController {
        let vc = UIStoryboard(name: "Home", bundle: Bundle(for: HomeBuilder.self)).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        let coordinate = HomeRouter(navigationController: navigationController)
        let viewModel = HomeViewModelImpl(router: coordinate)
        vc.viewModel = viewModel
        return vc
    }
}
