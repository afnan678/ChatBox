//
//  CallsViewModel.swift
//  Chatbox
//
//  Created by Afnan Ahmed on 29/01/2024.
//

import Foundation

protocol CallsViewModelInput {
    
}
protocol CallsViewModel {
    
}

class CallsViewModelImpl: CallsViewModel {
    
    private var router: CallsRouter?
    init(router: CallsRouter? = nil) {
        self.router = router
    }
}
