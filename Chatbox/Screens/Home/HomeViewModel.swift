//
//  HomeViewModel.swift
//  Chatbox
//
//  Created by Afnan Ahmed on 26/01/2024.
//

import Foundation

typealias HomeViewModelOutput = (HomeViewModelImpl.Output) -> Void

protocol HomeViewModelInput {
    func requestTogoMessages(user: ContactsModel)
}

protocol HomeViewModel: HomeViewModelInput {
    func requestToGetUsers(sender: String)
    var output: HomeViewModelOutput? {get set}
    var ChatsData: [HomeModel] {get}
}

class HomeViewModelImpl: HomeViewModel {
    var output: HomeViewModelOutput?
    
    var ChatsData: [HomeModel] = []
    
    private var router: HomeRouter?
    init(router: HomeRouter? = nil) {
        self.router = router
    }
    
    func requestTogoMessages(user: ContactsModel) {
        router?.gotoMessagesScreen(user: user)
    }
    
    
    func requestToGetUsers(sender: String) {
        FirebaseManager().getChatDocumentForHome(sender: sender) { documents in
            print("Chat Document IDs where sender exists: \(documents)n\n\n\n\n")
            for document in documents {
                
                self.ChatsData = []
                
                
                let ids = document["users"] as! [String]
                var userId = ""
                for id in ids {
                    if id != sender {
                        userId = id
                    }
                }
                
                let chat = Chats(id: document["documentID"] as! String, users: document["users"] as! [String], type: document["type"] as! String, lastmessage: document["lastmessage"] as! String, lastmessagetype: document["lastmessagetype"] as! String, lastmessageTime: document["lastMessageTime"] as! String, unseenmessages: document["unseenmessages"] as! String, messagesId: document["messagesId"] as! String, photes: document["photes"] as! String)
                
                
                                
                FirebaseManager().getUserData(userId: userId) { userData in
                    if let user = userData {
                        
                        var userData = ContactsModel(id: user["id"] as! String, serialNo: user["serialNo"] as! Int, name: user["name"] as! String, phoneNo: user["phoneNo"] as! String, about: user["about"] as! String, email: user["email"] as! String, password: user["password"] as! String, online: user["online"] as! Bool, createdAt: user["createdAt"] as! String, lastSeen: user["lastSeen"] as! String, updatedAt: user["UpdateAt"] as! String, profileUrl: user["profileUrl"] as! String, chats: user["chats"] as! [String])
                        
                        if self.ChatsData.isEmpty {
                            self.ChatsData.append(HomeModel(chat: chat, user: userData))
                        }
                        else {
                            var index = -1
                            for i in 0 ..< self.ChatsData.count {
                                if userData.id == self.ChatsData[i].user.id {
                                    index = i
                                }
                            }
                            
                            if index != -1 {
                                self.ChatsData[index].user = userData
                            } else {
                                self.ChatsData.append(HomeModel(chat: chat, user: userData))

                            }
                            
                        }
                    } else {
                        print("User not found or error retrieving data.")
                    }
                    self.ChatsData.sort { (dict1, dict2) -> Bool in
                        if let time1 = dict1.chat.lastmessageTime as? String, let time2 = dict2.chat.lastmessageTime as? String {
                            return time2 < time1
                        }
                        return false
                    }
                    self.output?(.chatloaded)
                }
            }
        }
    }
    
    enum Output {
        case chatloaded
    }
    
}
