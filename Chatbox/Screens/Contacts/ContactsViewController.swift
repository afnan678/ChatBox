//
//  ContactsViewController.swift
//  Chatbox
//
//  Created by Afnan Ahmed on 29/01/2024.
//

import UIKit

class ContactsViewController: UIViewController {

    var viewModel: ContactsViewModel!
    
    @IBOutlet weak var tableViewBGView: UIView!
    @IBOutlet weak var callsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureTableView()
        observeEvent()
        viewModel.requestgetUser()
        
        // Do any additional setup after loading the view.
    }
    
    func configureUI() {
        tableViewBGView.layer.cornerRadius = 50
        tableViewBGView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    func observeEvent() {
        viewModel.output = { [weak self] event in
            guard let self else { return }
            switch event {
            case .contactLoad:
                callsTableView.reloadData()
            }
        }
    }
}

extension ContactsViewController:UITableViewDelegate, UITableViewDataSource {
    func configureTableView() {
        callsTableView.delegate = self
        callsTableView.dataSource = self
        callsTableView.register(UINib(nibName: "ContactsTableViewCell", bundle: .main), forCellReuseIdentifier: "ContactsTableViewCell")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.Contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactsTableViewCell", for: indexPath) as! ContactsTableViewCell
        cell.setupCell(contact: viewModel.Contacts[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let token = UserDefaults.standard.string(forKey: "Token"), token == viewModel.Contacts[indexPath.row].id  {
            
        } else {
            viewModel.requestToGoMessageScreen(user: viewModel.Contacts[indexPath.row])
        }
    }
}
