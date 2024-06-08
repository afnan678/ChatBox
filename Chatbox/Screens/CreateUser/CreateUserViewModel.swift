//
//  CreateUserViewModel.swift
//  Chatbox
//
//  Created by Afnan Ahmed on 25/01/2024.
//

import Foundation


protocol CreateUserViewModelInput {
    func requestAuthenticate(number: String)
}

protocol CreateUserViewModel: CreateUserViewModelInput {
    func requestToGoVerifyScreen(number: String)
}

class CreateUserViewModelImpl: CreateUserViewModel {
    
    private var router: CreateUserRouter?
    
    init(router: CreateUserRouter? = nil) {
        self.router = router
    }
    
    func requestAuthenticate(number: String) {
        FirebaseAuthManager.getInstance().StartAuth(phoneNumber: number) { [weak self] success in
            guard success else {return}
            if success == true {
                self?.requestToGoVerifyScreen(number: number)
            }
        }
    }
    
    func requestToGoVerifyScreen(number: String) {
        router?.gotoVerifyScreen(number: number)
    }
}
