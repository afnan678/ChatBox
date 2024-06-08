//
//  VerifyUserRouter.swift
//  Chatbox
//
//  Created by Afnan Ahmed on 25/01/2024.
//

import Foundation
import UIKit

class VerifyUserRouter {
    
    private weak var navigationController: UINavigationController?
    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController
    }
    
    func gotoHomeScreen() {
        navigationController?.pushViewController(HomeBuilder().build(with: navigationController), animated: true)
    }
    func gotoUploadScreen(number: String, userId: String) {
        navigationController?.pushViewController(UploadDetailsBuilder().build(with: navigationController, number: number, userId: userId), animated: true)
    }
}
