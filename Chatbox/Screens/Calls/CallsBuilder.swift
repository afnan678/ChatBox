//
//  CallsBuilder.swift
//  Chatbox
//
//  Created by Afnan Ahmed on 29/01/2024.
//

import Foundation
import UIKit

class CallsBuilder {
    func build(with navigationController: UINavigationController?) -> UIViewController {
        let vc = UIStoryboard(name: "Calls", bundle: Bundle(for: CallsBuilder.self)).instantiateViewController(withIdentifier: "CallsViewController") as! CallsViewController
        let coordinator = CallsRouter(navigationController: navigationController)
        let viewModel = CallsViewModelImpl(router: coordinator)
        vc.viewModel = viewModel
        return vc
    }
}
