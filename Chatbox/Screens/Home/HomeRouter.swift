//
//  HomeRouter.swift
//  Chatbox
//
//  Created by Afnan Ahmed on 26/01/2024.
//

import Foundation
import UIKit

class HomeRouter {
    
    private weak var navigationController: UINavigationController?
    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController
    }
    func gotoMessagesScreen(user: ContactsModel) {
        navigationController?.pushViewController(MessagesBuilder().build(with: navigationController, user: user), animated: true)
    }
}
