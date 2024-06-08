//
//  MessagesBuilder.swift
//  Chatbox
//
//  Created by Afnan Ahmed on 26/01/2024.
//

import Foundation
import UIKit

class MessagesBuilder {
    
    func build(with navigationController: UINavigationController?, user: ContactsModel) -> UIViewController {
        let vc = UIStoryboard(name: "Messages", bundle: Bundle(for: MessagesBuilder.self)).instantiateViewController(withIdentifier: "MessagesViewController") as! MessagesViewController
        let coordinater = MessagesRouter(navigationController: navigationController)
        let viewModel = MessagesViewModelImpl(router: coordinater)
        vc.viewModel = viewModel
        vc.user = user
        return vc
    }
}
