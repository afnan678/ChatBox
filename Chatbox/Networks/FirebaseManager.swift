//
//  FirebaseManager.swift
//  FirebaseCRUD
//
//  Created by Afnan Ahmed on 18/01/2024.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseAuth
import FirebaseFirestore

class FirebaseManager {
    
    let databaseRef = Database.database().reference()
    
    func uploadImage (_ image:UIImage, imageName: String, completion: @escaping ((_ url: URL?) -> ())){
        let storageRef = Storage.storage ().reference().child("\(imageName)Profile"+".png")
        let imgData =  image.pngData()
        let metaData = StorageMetadata()
        metaData.contentType = "image/png"
        storageRef.putData (imgData!, metadata: metaData) { (metadata, error) in
            if error == nil{
                print ("success")
                storageRef.downloadURL (completion: { (url, error) in
                    completion(url)
                })
            }else{
                print ("error in save image")
                completion(nil)
            }
        }
    }
    
    func saveInFirebase(path: String, userId: String, dec: [String: Any], completion: @escaping (String) -> Void) {
        
        let messagesRef = databaseRef.child(path).child(userId)
        // Save the data to the database
        messagesRef.setValue(dec) { error, _ in
            if let error = error {
                print("Failed to save data: \(error.localizedDescription)")
                completion("Failed to save data: \(error.localizedDescription)")
            } else {
                print("Data saved successfully")
                completion("Data saved successfully")
            }
        }
    }
    
    
    func saveInFirestore(collectionPath: String, documentId: String, data: [String: Any], completion: @escaping (String) -> Void) {
        let db = Firestore.firestore()
        let documentReference = db.collection(collectionPath).document(documentId)
        
        // Save the data to the Firestore document
        documentReference.setData(data) { error in
            if let error = error {
                print("Failed to save data: \(error.localizedDescription)")
                completion("Failed to save data: \(error.localizedDescription)")
            } else {
                print("Data saved successfully")
                completion("Data saved successfully")
            }
        }
    }
    
    
    func RetriewData(dictionory: String, completion: @escaping ([String: Any]?) -> Void){
        databaseRef.child("Emplyees").observe(.value, with: { (snapshot) -> Void in
            
            if let users = snapshot.value as? [String: Any] {
                completion(users)
            } else {
                completion(nil)
            }
        })
    }
    
    func deleteData(dictionory: String, userID: String, completion: @escaping (Error?) -> Void) {
        let databaseRef = Database.database().reference(withPath: dictionory).child(userID)
        databaseRef.removeValue { (error, _) in
            completion(error)
        }
        
    }
    
    
    
    
    
    
    
    
    func getMaxSerialNo(collectionPath: String, completion: @escaping (Int?) -> Void) {
        let db = Firestore.firestore()
        
        // Query the collection in descending order by "serialNo" and limit the result to 1
        db.collection(collectionPath)
            .order(by: "serialNo", descending: true)
            .limit(to: 1)
            .getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Error getting documents: \(error.localizedDescription)")
                    completion(nil)
                } else {
                    // Check if there are documents in the result
                    if let document = querySnapshot?.documents.first {
                        // Get the value of "serialNo" from the document
                        if let maxSerialNo = document["serialNo"] as? Int {
                            completion(maxSerialNo)
                        } else {
                            // Handle the case where "serialNo" is not an integer
                            completion(nil)
                        }
                    } else {
                        // No documents found
                        completion(nil)
                    }
                }
            }
    }
    
    //
    //    func getUsersFromFirestore(collectionPath: String, completion: @escaping ([String: Any]?, Error?) -> Void) {
    //        let db = Firestore.firestore()
    //
    //        db.collection(collectionPath).getDocuments { (querySnapshot, error) in
    //            if let error = error {
    //                print("Error getting documents: \(error.localizedDescription)")
    //                completion(nil, error)
    //            } else {
    //                var users: [[String: Any]] = []
    //
    //                for document in querySnapshot!.documents {
    //                    // Access the user data from the document
    //                    var userData = document.data()
    //
    //                    // Add the user ID to the userData dictionary
    //                    userData["userID"] = document.documentID
    //
    //                    users.append(userData)
    //                }
    //
    //                completion(users, nil)
    //            }
    //        }
    //    }
    func getUsersFromFirestore(collectionPath: String, completion: @escaping ([[String: Any]]?) -> Void) {
        let db = Firestore.firestore()
        
        db.collection(collectionPath).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error retrieving documents: \(error.localizedDescription)")
                completion(nil)
            } else {
                var users: [[String: Any]] = []
                
                for document in querySnapshot!.documents {
                    // Access the user data from the document
                    var userData = document.data()
                    
                    // Add the document ID to the userData dictionary
                    userData["documentID"] = document.documentID
                    
                    users.append(userData)
                }
                
                completion(users)
            }
        }
    }
    
    func getUsersLisnerFirestore(collectionPath: String, token: String, completion: @escaping ([[String: Any]]?) -> Void) {
        let db = Firestore.firestore()
        var count = 0
        let registration = db.collection(collectionPath).document(token)
            .addSnapshotListener { documentSnapshot, error in
                count = count + 1
                //           if count == 2 registration.remove()
                guard let document = documentSnapshot else {
                    print("Error fetching document: \(error!)")
                    return
                }
                var users: [[String: Any]] = []
                print("Current data: \(document.data())")
                var userData = document.data()
                users.append(userData!)
                completion(users)
                //my other code
            }
    }
    
    
    func userActive(token: String, online: Bool) {
        let db = Firestore.firestore()
        let userRef = db.collection("Users").document(token)
        userRef.updateData(["online": online]) { error in
            if let error = error {
                print("Error updating online status: \(error.localizedDescription)")
            } else {
                print("Online status updated successfully")
            }
        }
    }
    
    
    
    
    
    
    func saveChatData(newChatData: [String: Any], completion: @escaping (String?) -> Void) {
        let db = Firestore.firestore()
        var ref: DocumentReference?

        // Create a new document in the "chats" collection
        ref = db.collection("Chats").addDocument(data: newChatData) { error in
            if let error = error {
                print("Error adding document: \(error.localizedDescription)")
                completion(nil)
            } else {
                // Document ID is available after the document is successfully added
                if let documentID = ref?.documentID {
                    print("Document added with ID: \(documentID)")
                    completion(documentID)
            }
        }
    }
}

    func updateChatData(documentID: String, updatedChatData: [String: Any], completion: @escaping (Bool) -> Void) {
        let db = Firestore.firestore()

        // Reference to the "Chats" collection and the specific document
        let chatReference = db.collection("Chats").document(documentID)

        // Update the document with the new data
        chatReference.updateData(updatedChatData) { error in
            if let error = error {
                print("Error updating document: \(error.localizedDescription)")
                completion(false)
            } else {
                print("Document successfully updated")
                completion(true)
            }
        }
    }
    
    
    
    
    
    func getChatDocumentIDs(sender: String, receiver: String, completion: @escaping ([String]) -> Void) {
        let db = Firestore.firestore()
        let chatCollection = db.collection("Chats")

        var documentIDs: [String] = []

        // Query to retrieve documents containing at least one of the users
        chatCollection.whereField("users", arrayContainsAny: [sender, receiver]).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error.localizedDescription)")
                completion([])
            } else {
                for document in querySnapshot!.documents {
                    // Filter documents to find exact matches
                    if let users = document["users"] as? [String], users.contains(sender), users.contains(receiver) {
                        documentIDs.append(document.documentID)
                    }
                }

                completion(documentIDs)
            }
        }
    }

    
    
    
    
    
    
    func saveMessageData(newMessageData: [String: Any], completion: @escaping (String?) -> Void) {
        let db = Firestore.firestore()
        var ref: DocumentReference?
        ref = db.collection("Messages").addDocument(data: newMessageData) { error in
            if let error = error {
                print("Error adding document: \(error.localizedDescription)")
                completion(nil)
            } else {
                // Document ID is available after the document is successfully added
                let documentID = ref?.documentID
                print("Document added with ID: \(documentID ?? "unknown")")
                completion(documentID)
            }
        }
    }
    
    
    
    
    
    
    
    
    func updateMessageData(sender: String, receiver: String, timestamp: String, updatedData: [String: Any], completion: @escaping (Bool) -> Void) {
        let db = Firestore.firestore()
        
        // Query for the message with the given sender, receiver, and timestamp
        let query = db.collection("Messages")
            .whereField("sender", isEqualTo: sender)
            .whereField("reciver", isEqualTo: receiver)
            .whereField("time", isEqualTo: timestamp)
        
        query.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error querying document: \(error.localizedDescription)")
                completion(false)
            } else {
                guard let document = querySnapshot?.documents.first else {
                    print("Document not found")
                    completion(false)
                    return
                }
                
                // Update the document with the new data
                document.reference.updateData(updatedData) { error in
                    if let error = error {
                        print("Error updating document: \(error.localizedDescription)")
                        completion(false)
                    } else {
                        print("Document updated successfully")
                        completion(true)
                    }
                }
            }
        }
    }
    
    
    
    
    
    func updateMessageStatus(receiver: String, newStatus: String, completion: @escaping (Bool) -> Void) {
        let db = Firestore.firestore()

        // Query for messages with the given receiver
        let query = db.collection("Messages")
            .whereField("reciver", isEqualTo: receiver)

        query.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error querying documents: \(error.localizedDescription)")
                completion(false)
            } else {
                guard let documents = querySnapshot?.documents else {
                    print("No documents found for the receiver")
                    completion(false)
                    return
                }

                // Update the status for each document
                for document in documents {
                    document.reference.updateData(["status": newStatus]) { error in
                        if let error = error {
                            print("Error updating document: \(error.localizedDescription)")
                            completion(false)
                            return
                        }
                    }
                }

                print("Status updated successfully for the receiver")
                completion(true)
            }
        }
    }
    
    
    
    
    
    
    

    
    func appendMessageToDocument(documentID: String, newMessageData: [String: Any]) {
        let db = Firestore.firestore()
        let documentRef = db.collection("Messages").document(documentID)

        // Get the current messages array from Firestore
        documentRef.getDocument { (documentSnapshot, error) in
            if let error = error {
                print("Error fetching document: \(error.localizedDescription)")
                return
            }

            if var data = documentSnapshot?.data(),
               var messagesData = data["messages"] as? [[String: Any]] {

                // Append the new message to the array
                messagesData.append(newMessageData)

                // Update the document with the modified messages array
                documentRef.updateData(["messages": messagesData]) { error in
                    if let error = error {
                        print("Error appending message to document: \(error.localizedDescription)")
                    } else {
                        print("Message appended to document successfully")
                    }
                }
            } else {
                // If the document or messages array does not exist, create a new one
                documentRef.setData(["messages": [newMessageData]]) { error in
                    if let error = error {
                        print("Error creating document: \(error.localizedDescription)")
                    } else {
                        print("Document created with appended message successfully")
                    }
                }
            }
        }
    }
    
    
    
    
    
    
    
    func getMessagesFromDocument(collectionPath: String, messageId: String, completion: @escaping ([[String: Any]]?) -> Void) {
        let db = Firestore.firestore()
        var count = 0
        let registration = db.collection(collectionPath).document(messageId)
            .addSnapshotListener { documentSnapshot, error in
                count = count + 1
                //           if count == 2 registration.remove()
                guard let document = documentSnapshot else {
                    print("Error fetching document: \(error!)")
                    return
                }
                var users: [[String: Any]] = []
                print("Current data: \(document.data())")
                var userData = document.data()
                users.append(userData!)
                completion(users)
                //my other code
            }
    }

    
    
    
    
    
    
    func getMessagesWithTypeOne(parentId: String , completion: @escaping ([[String: Any]]?) -> Void) {
        let db = Firestore.firestore()
        let collectionReference = db.collection("Messages")

        let query = collectionReference.whereField("parent", isEqualTo: parentId)

        // Add a snapshot listener to receive real-time updates
        query.addSnapshotListener { (querySnapshot, error) in
            if let error = error {
                print("Error getting messages: \(error.localizedDescription)")
                completion(nil)
            } else {
                var messages: [[String: Any]] = []

                for document in querySnapshot!.documents {
                    if var message = document.data() as? [String: Any] {
                        message["documentID"] = document.documentID
                        messages.append(message)
                    }
                }

                completion(messages)
            }
        }
    }

    
    
    
    
//    MARK: - Home Screen Network
    
    func getChatDocumentForHome(sender: String, completion: @escaping ([[String: Any]]) -> Void) {
        let db = Firestore.firestore()
        let chatCollection = db.collection("Chats")

        var documents: [[String: Any]] = []

        // Query to retrieve documents where sender exists in the users array
        let query = chatCollection.whereField("users", arrayContains: sender)

        // Add a snapshot listener to receive real-time updates
        let listener = query.addSnapshotListener { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error.localizedDescription)")
                completion([])
            } else {
                documents.removeAll() // Clear the existing documents

                for document in querySnapshot!.documents {
                    var documentData = document.data()
                    documentData["documentID"] = document.documentID
                    documents.append(documentData)
                }

                completion(documents)
            }
        }
    }
    
    
    
    
    
    func getUserData(userId: String, completion: @escaping ([String: Any]?) -> Void) {
        let db = Firestore.firestore()
        let userDocumentRef = db.collection("Users").document(userId)

        // Add a snapshot listener to get real-time updates
        let listener = userDocumentRef.addSnapshotListener { (documentSnapshot, error) in
            if let error = error {
                print("Error getting user data: \(error.localizedDescription)")
                completion(nil)
            } else {
                if let document = documentSnapshot, document.exists {
                    let userData = document.data()
                    completion(userData)
                } else {
                    // User not found or document doesn't exist
                    completion(nil)
                }
            }
        }
    }

    
    
    
    
    
        
    }
    
    

