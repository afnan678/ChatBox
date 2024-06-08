//
//  MessagesModel.swift
//  Chatbox
//
//  Created by Afnan Ahmed on 31/01/2024.
//

import Foundation

struct Messages {
    
    var sender: String?
    var reciver: String?
    var messagesText: String?
    var time: String?
    var reciverRead: Bool?
    var type: String?
    var status: String?
    var mediaURL: String?
    var update: String?
    
    init(sender: String? = nil, reciver: String? = nil, messagesText: String? = nil, time: String? = nil, reciverRead: Bool? = nil, type: String? = nil, status: String? = nil, mediaURL: String? = nil, update: String? = nil) {
        self.sender = sender
        self.reciver = reciver
        self.messagesText = messagesText
        self.time = time
        self.reciverRead = reciverRead
        self.type = type
        self.status = status
        self.mediaURL = mediaURL
        self.update = update
    }
    
}
