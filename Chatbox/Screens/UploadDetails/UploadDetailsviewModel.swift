//
//  UploadDetailsviewModel.swift
//  Chatbox
//
//  Created by Afnan Ahmed on 29/01/2024.
//

import Foundation
import UIKit

typealias UploadDetailsviewModelOutput = (UploadDetailsviewModelImpl.Output) -> Void

protocol UploadDetailsviewModelInput {
    func createRequest(ProfileImg: UIImage, id: String, serialNo: String ,name: String, phoneNo: String)
}

protocol UploadDetailsviewModel: UploadDetailsviewModelInput {
    var output: UploadDetailsviewModelOutput? {get set}
    func requestTogoHomeScreen()
    
}

class UploadDetailsviewModelImpl: UploadDetailsviewModel {
    var output: UploadDetailsviewModelOutput?
    private var router: UploadDetailsRouter?
    init(router: UploadDetailsRouter? = nil) {
        self.router = router
    }
    
    func createRequest(ProfileImg: UIImage, id: String, serialNo: String ,name: String, phoneNo: String) {
        var serialNo = 0
        FirebaseManager().uploadImage(ProfileImg, imageName: id) { url in
            
            FirebaseManager().getMaxSerialNo(collectionPath: "Users") { maxSerialNo in
                if let maxNo = maxSerialNo {
                    print("Max SerialNo: \(maxNo)")
                    serialNo = (maxNo + 1)
                } else {
                    serialNo = 1
                    print("No documents in the collection or an error occurred.")
                }
                let currentDateTime = self.getCurrentDateTime()
                let dec = ["id": id, "serialNo": serialNo, "name": name, "phoneNo": phoneNo, "about": "Here there i'm using chatbox", "email": "", "password": "", "online": true, "lastSeen": currentDateTime, "createdAt": currentDateTime, "UpdateAt": currentDateTime ,"profileUrl": url!.absoluteString, "chats": ["",""] ] as [String: Any]
                FirebaseManager().saveInFirestore(collectionPath: "Users", documentId: id, data: dec)  { sucess in
                    if sucess == "Data saved successfully" {
                        self.output?(.useradded)
                        UserDefaults.standard.set("Home", forKey: "Screen")
                        UserDefaults.standard.set("\(id)", forKey: "Token")
                        self.requestTogoHomeScreen()
                    }
                    else {
                        self.output?(.FaildToAdd)
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
    func requestTogoHomeScreen() {
        router?.goToHomeScreen()
    }
    enum Output {
        case addUser
        case useradded
        case FaildToAdd
    }
}
