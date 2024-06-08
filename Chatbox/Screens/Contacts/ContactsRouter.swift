//
//  CallsRouter.swift
//  Chatbox
//
//  Created by Afnan Ahmed on 29/01/2024.
//

import Foundation
import UIKit

class ContactsRouter {
    
    private weak var navigationController: UINavigationController?
    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController
    }
    func goToMessagesScreen(user: ContactsModel) {
        navigationController?.pushViewController(MessagesBuilder().build(with: navigationController, user: user), animated: true)
    }
}
