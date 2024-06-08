//
//  VerifyUserBuilder.swift
//  Chatbox
//
//  Created by Afnan Ahmed on 25/01/2024.
//

import Foundation
import UIKit

class VerifyUserBuilder {
    
    func build(with navigationController: UINavigationController?, number: String) -> UIViewController {
        let vc = UIStoryboard(name: "VerifyUser", bundle: Bundle(for: VerifyUserBuilder.self)).instantiateViewController(withIdentifier: "VerifyUserViewController") as! VerifyUserViewController
        let coordinator = VerifyUserRouter(navigationController: navigationController)
        let viewModel = VerifyUserViewModelImpl(router: coordinator)
        vc.viewModel = viewModel
        vc.number = number
        return vc
    }
}
