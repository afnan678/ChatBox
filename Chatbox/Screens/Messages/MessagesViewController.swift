//
//  MessagesViewController.swift
//  Chatbox
//
//  Created by Afnan Ahmed on 26/01/2024.
//

import UIKit

class MessagesViewController: UIViewController {

    @IBOutlet weak var userActiveLabel: UILabel!
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var cemaraButton: UIButton!
    @IBOutlet weak var voiceRecordButton: UIButton!
    @IBOutlet weak var sendMessageButton: UIButton!
    @IBOutlet weak var messagesTextField: UITextField!
    @IBOutlet weak var MessagesTableView: UITableView!
    
    var user: ContactsModel?
    var viewModel: MessagesViewModel!
    var usender = ""
    var reciver = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUITableView()
        configureFields()
        scrollToLastRow()
        observeEvent()
        if let token = UserDefaults.standard.string(forKey: "Token")  {
            usender = token
        }
        reciver = user?.id ?? ""
        configureUI(name: user?.name ?? "", url: user?.profileUrl ?? "", active: user?.online ?? false)
        viewModel.requestUserLisner(token: user?.id ?? "")
        // Do any additional setup after loading the view.
    }
    @IBAction func goBackButtonPressed(_ sender: Any) {
        viewModel.requestToGoBack()
    }
    
    @IBAction func sendMessagesButtonClick(_ sender: Any) {
        
        viewModel.requestTSaveMessage(sender: usender, reciver: reciver, messages: messagesTextField.text ?? "")
        messagesTextField.text = ""
    }
    func configureUI(name: String, url: String, active: Bool) {
        userNameLabel.text = name
        if let url = URL(string: url) {
            GetImage.getImage(url: url, image: userProfileImage)
        }
        if active == true {
            userActiveLabel.text = "Online"
        } else {
            userActiveLabel.text = "Offline"
        }
        
        viewModel.requestTogetMessages(sender: usender, reciver: reciver)
    }
    
    
    func observeEvent() {
        viewModel.output = { [weak self] event in
            guard let self else { return }
            switch event {
            case .userChangeLisen:
                print(viewModel.user ?? "")
                configureUI(name: viewModel.user?.name ?? "", url: viewModel.user?.profileUrl ?? "", active: viewModel.user?.online ?? false)
            case .chatLoad:
                MessagesTableView.reloadData()
                scrollToLastRow()
            }
        }
    }
}


extension MessagesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func configureUITableView() {
        MessagesTableView.delegate = self
        MessagesTableView.dataSource = self
        MessagesTableView.register(UINib(nibName: "SendMessagesTableViewCell", bundle: .main), forCellReuseIdentifier: "SendMessagesTableViewCell")
        MessagesTableView.register(UINib(nibName: "RecivedMessagesTableViewCell", bundle: .main), forCellReuseIdentifier: "RecivedMessagesTableViewCell")

    }
    func scrollToLastRow() {
        let lastSection = MessagesTableView.numberOfSections - 1
        let lastRow = MessagesTableView.numberOfRows(inSection: lastSection) - 1

        if lastSection >= 0 && lastRow >= 0 {
            let indexPath = IndexPath(row: lastRow, section: lastSection)
            MessagesTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var user = ""
        if let token = UserDefaults.standard.string(forKey: "Token")  {
            user = token
        }
        
        if viewModel.messages[indexPath.row].sender ?? "" == user {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SendMessagesTableViewCell", for: indexPath) as! SendMessagesTableViewCell
            cell.configureUI(message: viewModel.messages[indexPath.row])
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecivedMessagesTableViewCell", for: indexPath) as! RecivedMessagesTableViewCell
            cell.configureUI(message: viewModel.messages[indexPath.row])
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
           if indexPath.row == 10 - 1 {
                //Perform action
        }
    }
}

extension MessagesViewController: UITextFieldDelegate {
    
    
    func configureFields() {
        messagesTextField.delegate = self
    }
    // MARK: - UITextFieldDelegate
     func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
         // Get the updated text after the user's input
         let updatedText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
         // Check if the first character is not an empty space or if the entire text is empty
         if updatedText.isEmpty || !CharacterSet.whitespaces.contains(updatedText.first!.unicodeScalars.first!) {
             cemaraButton.isHidden = true
             voiceRecordButton.isHidden = true
             sendMessageButton.isHidden = false
             if updatedText.isEmpty {
                 print("Text field is empty")
                 cemaraButton.isHidden = false
                 voiceRecordButton.isHidden = false
                 sendMessageButton.isHidden = true
             }
             return true
         } else {
             cemaraButton.isHidden = false
             voiceRecordButton.isHidden = false
             sendMessageButton.isHidden = true
             
             return false
         }
     }
}
