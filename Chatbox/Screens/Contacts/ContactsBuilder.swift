//
//  CallsBuilder.swift
//  Chatbox
//
//  Created by Afnan Ahmed on 29/01/2024.
//

import Foundation
import UIKit

class ContactsBuilder {
    func build(with navigationController: UINavigationController?) -> UIViewController {
        let vc = UIStoryboard(name: "Contacts", bundle: Bundle(for: ContactsBuilder.self)).instantiateViewController(withIdentifier: "ContactsViewController") as! ContactsViewController
        let coordinater = ContactsRouter(navigationController: navigationController)
        let viewModel = ContactsViewModelImpl(router: coordinater)
        vc.viewModel = viewModel
        return vc
    }
}
