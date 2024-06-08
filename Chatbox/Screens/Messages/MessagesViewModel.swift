//
//  MessagesViewModel.swift
//  Chatbox
//
//  Created by Afnan Ahmed on 26/01/2024.
//

import Foundation

typealias MessagesViewModelOutput = (MessagesViewModelImpl.Output) -> Void

protocol MessagesViewModelInput {
    func requestUserLisner(token: String)
    func requestTogetMessages(sender: String, reciver: String)

}

protocol MessagesViewModel: MessagesViewModelInput {
    
    var output: MessagesViewModelOutput? {get set}
    func requestToGoBack()
    func requestTSaveChat(sender: String, reciver: String)
    func requestTSaveMessage(sender: String, reciver: String, messages: String)
    var user: User? {get set}
    var messages: [Messages] {get}
    
}

class MessagesViewModelImpl: MessagesViewModel {
    
    var messages: [Messages] = []
    var user: User?
    
    var output: MessagesViewModelOutput?
    private var router: MessagesRouter?
    init(router: MessagesRouter? = nil) {
        self.router = router
    }
    
    func requestToGoBack() {
        router?.goToBackScreen()
    }
    
    func requestUserLisner(token: String) {
        FirebaseManager().getUsersLisnerFirestore(collectionPath: "Users", token: token) { [self] result in
            
            if let userData = result {
                let tempUser = User(id: userData[0]["id"] as! String, serialNo: userData[0]["serialNo"] as! Int, name: userData[0]["name"] as! String, phoneNo: userData[0]["phoneNo"] as! String, about: userData[0]["about"] as! String, email: userData[0]["email"] as! String, password: userData[0]["password"] as! String, online: userData[0]["online"] as! Bool, createdAt: userData[0]["createdAt"] as! String, lastSeen: userData[0]["lastSeen"] as! String, updatedAt: userData[0]["UpdateAt"] as! String, profileUrl: userData[0]["profileUrl"] as! String, chats: userData[0]["chats"] as! [String])
                user = tempUser
                self.output?(.userChangeLisen)
            }
        }
    }
    
    func requestTSaveChat(sender: String, reciver: String) {

        FirebaseManager().getChatDocumentIDs(sender: sender, receiver: reciver) { [self] documentIDs in
            print("Chat Document IDs where sender and receiver exist: \(documentIDs)")
            if documentIDs != [] {
                print(documentIDs[0])
                var sendStatus = ""
                if user?.online == true {
                    sendStatus = "deliver"
                } else {
                    sendStatus = "sent"
                }
                let newMessageData: [String: Any] = [
                    "sender": "\(sender)",
                    "reciver": "\(reciver)",
                    "messagesText": "\(messages)",
                    "time": "\(getCurrentDateTime())",
                    "reciverRead": false,
                    "parent": "\(documentIDs[0])",
                    "type": "1 to 1",
                    "status": sendStatus,
                    "mediaURL": "",
                    "update": ""
                ]
                
                FirebaseManager().saveMessageData(newMessageData: newMessageData) { result in
                    print(result)
                    let documentIDToUpdate = documentIDs[0]
                    let updatedData: [String: Any] = [
                        "users": ["\(sender)","\(reciver)"],
                        "type": "Test",
                        "lastmessage": "hello",
                        "lastmessagetype": "text",
                        "unseenmessages": "2",
                        "messagesId": "123",
                        "photes": "no"
                    ]

                        FirebaseManager().updateChatData(documentID: documentIDToUpdate, updatedChatData: updatedData) { success in
                        if success {
                            print("Chat data updated successfully")
                        } else {
                            print("Failed to update chat data")
                        }
                    }
                }
            } else {
                print("empaty")
                let newChatData: [String: Any] = [
                    "users": ["\(sender)","\(reciver)"],
                    "type": "Test",
                    "lastmessage": "hello",
                    "lastmessagetype": "text",
                    "unseenmessages": "2",
                    "messagesId": "123",
                    "photes": "no"
                ]
                FirebaseManager().saveChatData(newChatData: newChatData) { result in
                    
                    if let result = result {
                        self.requestTSaveChat(sender: sender, reciver: reciver)
                    }
                }
            }
        }
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    func requestTSaveMessage(sender: String, reciver: String, messages: String) {
        
        FirebaseManager().getChatDocumentIDs(sender: sender, receiver: reciver) { [self] documentIDs in
            print("Chat Document IDs where sender and receiver exist: \(documentIDs)")
            if documentIDs != [] {
                print(documentIDs[0])
                var sendStatus = ""
                if user?.online == true {
                    sendStatus = "deliver"
                } else {
                    sendStatus = "send"
                }
                let newMessageData: [String: Any] = [
                    "sender": "\(sender)",
                    "reciver": "\(reciver)",
                    "messagesText": "\(messages)",
                    "time": "\(getCurrentDateTime())",
                    "reciverRead": false,
                    "parent": "\(documentIDs[0])",
                    "type": "1 to 1",
                    "status": sendStatus,
                    "mediaURL": "",
                    "update": ""
                ]
                
                FirebaseManager().saveMessageData(newMessageData: newMessageData) { result in
                    print(result)
                    let documentIDToUpdate = documentIDs[0]
                    let updatedData: [String: Any] = [
                        "users": ["\(sender)","\(reciver)"],
                        "type": "Text",
                        "lastmessage": "\(messages)",
                        "lastmessagetype": "text",
                        "unseenmessages": "2",
                        "messagesId": "\(sender)",
                        "lastMessageTime": "\(getCurrentDateTime())",
                        "photes": "no"
                    ]
                        FirebaseManager().updateChatData(documentID: documentIDToUpdate, updatedChatData: updatedData) { success in
                        if success {
                            print("Chat data updated successfully")
                        } else {
                            print("Failed to update chat data")
                        }
                    }
                }
            } else {
                print("empaty")
                let newChatData: [String: Any] = [
                    "users": ["\(sender)","\(reciver)"],
                    "type": "Text",
                    "lastmessage": "",
                    "lastmessagetype": "text",
                    "unseenmessages": "2",
                    "messagesId": "123",
                    "lastMessageTime": "\(getCurrentDateTime())",
                    "photes": "no"
                ]
                FirebaseManager().saveChatData(newChatData: newChatData) { result in
                    
                    if let result = result {
                        self.requestTogetMessages(sender: sender, reciver: reciver)
                        self.requestTSaveMessage(sender: sender, reciver: reciver, messages: messages)
                    }
                }
            }
        }
    }
    
    
    
    func requestTogetMessages(sender: String, reciver: String) {

        FirebaseManager().getChatDocumentIDs(sender: sender, receiver: reciver) { [self] documentIDs in
            print("Chat Document IDs where sender and receiver exist: \(documentIDs)")
            if documentIDs != [] {
                print(documentIDs[0])
                
                FirebaseManager().getMessagesWithTypeOne(parentId: "\(documentIDs[0])") { result in
                    print(result ?? "")
                    if let messages = result {
                        self.messages = []
                        
                        var dataArray = messages
                        
                        dataArray.sort { (dict1, dict2) -> Bool in
                            if let time1 = dict1["time"] as? String, let time2 = dict2["time"] as? String {
                                return time1 < time2
                            }
                            return false
                        }
                        
                        for message in dataArray {
                            let tempMessage = Messages(sender: (message["sender"] as! String), reciver: (message["reciver"] as! String), messagesText: (message["messagesText"] as! String), time: (message["time"] as! String), reciverRead: (message["reciverRead"] as! Bool), type: (message["type"] as! String), status: (message["status"] as! String), mediaURL: (message["mediaURL"] as! String), update: (message["update"] as! String))
                            
                            self.messages.append(tempMessage)
                        }
                        self.output?(.chatLoad)

                    }
                }
                
 
            }
        }
    }
        
        
        
        func getCurrentDateTime() -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let currentDateTime = Date()
            let formattedDateTime = dateFormatter.string(from: currentDateTime)
            return formattedDateTime
        }
        
        
        enum Output {
            case userChangeLisen
            case chatLoad
        }
        
    }

