//
//  AuthManager.swift
//  Chatbox
//
//  Created by Afnan Ahmed on 25/01/2024.
//

import Foundation
import FirebaseAuth

class FirebaseAuthManager {
    private static let shared = FirebaseAuthManager()
    private let auth = Auth.auth()
    
    private var verificationId: String?

    private init() {
    }

    class func getInstance()-> FirebaseAuthManager {
        return shared
    }

    public func StartAuth(phoneNumber: String, compeletion: @escaping (Bool) -> Void) {
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { [weak self] verificationId, error in
            guard let verificationId = verificationId, error == nil else {
                compeletion(false)
                return
            }
            self?.verificationId = verificationId
            compeletion(true)
        }
    }
    
    public func verifyCode(smsCode: String, completion: @escaping (Bool) -> Void) {
        print(smsCode)
        guard let verificationId = verificationId else {
            completion(false)
            return
        }
        
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationId, verificationCode: smsCode)
        
        Auth.auth().signIn(with: credential) { result, error in
            if let error = error {
                print("Error signing in with phone credential: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            // Check if result is not nil if needed
            completion(true)
        }
    }
    
    
    
    public func verifyCode(smsCode: String, completion: @escaping (Bool, String?) -> Void) {
        print(smsCode)
        
        guard let verificationId = verificationId else {
            completion(false, nil)
            return
        }
        
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationId, verificationCode: smsCode)
        
        Auth.auth().signIn(with: credential) { result, error in
            if let error = error {
                print("Error signing in with phone credential: \(error.localizedDescription)")
                completion(false, nil)
                return
            }
            // Check if result is not nil and get the user ID
            if let user = result?.user {
                let userID = user.uid
                completion(true, userID)
            } else {
                // Handle the case where the result is nil
                print("Error: User information not available.")
                completion(false, nil)
            }
        }
    }
}
