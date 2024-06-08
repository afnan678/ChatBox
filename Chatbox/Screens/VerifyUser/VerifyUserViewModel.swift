//
//  VerifyUserViewModel.swift
//  Chatbox
//
//  Created by Afnan Ahmed on 25/01/2024.
//

import Foundation

typealias VeriyUserViewModelOutput = (VerifyUserViewModelImpl.Output) -> Void
protocol VerifyUserViewModelInput {
    
    func requestVerifyCode(code: String, number: String)
    func requestToGoUploadScreen(number: String, userId: String)
}
protocol VerifyUserViewModel: VerifyUserViewModelInput {
    var output: VeriyUserViewModelOutput? {get set}
    func requestToGohomeScreen()
}
class VerifyUserViewModelImpl: VerifyUserViewModel {
    
    var output: VeriyUserViewModelOutput?
    private var router: VerifyUserRouter?
    init(router: VerifyUserRouter? = nil) {
        self.router = router
    }
    
    func requestVerifyCode(code: String, number: String) {
        FirebaseAuthManager.getInstance().verifyCode(smsCode: code) { success, userID in
            if success {
                if let userID = userID {
                    // Use the userID as needed
                    print("Authenticated user ID: \(userID)")
                    self.requestToGoUploadScreen(number: number, userId: userID)
                } else {
                    print("Error: User ID is nil.")
                }
            } else {
                print("Verification failed.")
            }
        }
    }
    func requestToGohomeScreen() {
        router?.gotoHomeScreen()
    }
    func requestToGoUploadScreen(number: String, userId: String) {
        router?.gotoUploadScreen(number: number, userId: userId)
    }
    
    enum Output {
        case verified
        case failToVerify
    }
}
