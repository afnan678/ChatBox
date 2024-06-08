//
//  CreateUserRouter.swift
//  Chatbox
//
//  Created by Afnan Ahmed on 25/01/2024.
//

import Foundation
import UIKit

class CreateUserRouter {
    
    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController
    }
    
    func gotoVerifyScreen(number: String) {
        navigationController?.pushViewController(VerifyUserBuilder().build(with: navigationController, number: number), animated: true)
    }
}
