//
//  UploadDetailsBuilder.swift
//  Chatbox
//
//  Created by Afnan Ahmed on 29/01/2024.
//

import Foundation
import UIKit

class UploadDetailsBuilder {
    func build(with navigationController: UINavigationController?, number: String, userId: String) -> UIViewController {
        let vc = UIStoryboard(name: "UploadDetails", bundle: Bundle(for: UploadDetailsBuilder.self)).instantiateViewController(withIdentifier: "UploadDetailsViewController") as! UploadDetailsViewController
        let coordinator = UploadDetailsRouter(navigationController: navigationController)
        let viewModel = UploadDetailsviewModelImpl(router: coordinator)
        vc.viewModel = viewModel
        vc.number = number
        vc.UserId = userId
        return vc
    }
}
