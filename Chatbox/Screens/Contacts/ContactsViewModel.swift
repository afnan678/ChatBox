//
//  CallsViewModel.swift
//  Chatbox
//
//  Created by Afnan Ahmed on 29/01/2024.
//

import Foundation

typealias ContactsModelViewOutput = (ContactsViewModelImpl.Output) -> Void
protocol ContactsViewModelInput {
    
    func requestToGoMessageScreen(user: ContactsModel)
    
}

protocol ContactsViewModel: ContactsViewModelInput {
    func requestgetUser()
    var Contacts: [ContactsModel] {get}
    var output: ContactsModelViewOutput? {get set}
    
}
class ContactsViewModelImpl: ContactsViewModel {
    var output: ContactsModelViewOutput?
    
    var Contacts: [ContactsModel] = []
    private var router: ContactsRouter?
    init(router: ContactsRouter? = nil) {
        self.router = router
    }
    func requestgetUser() {
        FirebaseManager().getUsersFromFirestore(collectionPath: "Users") { users in
            if let users = users {
                // Handle the retrieved user data
                for user in users {
                    self.Contacts.append(ContactsModel(id: user["id"] as! String, serialNo: user["serialNo"] as! Int, name: user["name"] as! String, phoneNo: user["phoneNo"] as! String, about: user["about"] as! String, email: user["email"] as! String, password: user["password"] as! String, online: user["online"] as! Bool, createdAt: user["createdAt"] as! String, lastSeen: user["lastSeen"] as! String, updatedAt: user["UpdateAt"] as! String, profileUrl: user["profileUrl"] as! String, chats: user["chats"] as! [String]))
                }
            } else {
                print("Error retrieving data from Firestore.")
            }
            self.output?(.contactLoad)
        }
    }
    func requestToGoMessageScreen(user: ContactsModel) {
        router?.goToMessagesScreen(user: user)
    }
    
    enum Output {
        case contactLoad
    }
    
}
