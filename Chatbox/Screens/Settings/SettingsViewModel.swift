//
//  SettingsViewModel.swift
//  Chatbox
//
//  Created by Afnan Ahmed on 29/01/2024.
//

import Foundation

protocol SettingsViewModelInput {
    
}

protocol SettingsViewModel {
    
}

class SettingsViewModelImpl: SettingsViewModel {
    
    private var router: SettingsRouter?
    init(router: SettingsRouter? = nil) {
        self.router = router
    }
}
