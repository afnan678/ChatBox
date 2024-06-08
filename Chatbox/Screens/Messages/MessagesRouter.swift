//
//  MessagesRouter.swift
//  Chatbox
//
//  Created by Afnan Ahmed on 26/01/2024.
//

import Foundation
import UIKit

class MessagesRouter {
    
    private weak var navigationController: UINavigationController?
    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController
    }
    
    func goToBackScreen() {
        navigationController?.popViewController(animated: true)
    }
}
