//
//  CreateUserBuilder.swift
//  Chatbox
//
//  Created by Afnan Ahmed on 25/01/2024.
//

import Foundation
import UIKit

class CreateUserBuilder {
    
    func build(with navigationController: UINavigationController?) -> UIViewController {
        let vc = UIStoryboard(name: "Main", bundle: Bundle(for: CreateUserBuilder.self)).instantiateViewController(withIdentifier: "CreateUserViewController") as! CreateUserViewController
        let coordinator = CreateUserRouter(navigationController: navigationController)
        let viewModel = CreateUserViewModelImpl(router: coordinator)
        vc.viewModel = viewModel
        return vc
    }
}
