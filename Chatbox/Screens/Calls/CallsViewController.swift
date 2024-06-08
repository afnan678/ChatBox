//
//  CallsViewController.swift
//  Chatbox
//
//  Created by Afnan Ahmed on 29/01/2024.
//

import UIKit

class CallsViewController: UIViewController {

    @IBOutlet weak var tableViewBGView: UIView!
    @IBOutlet weak var callsTableView: UITableView!
    var viewModel: CallsViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureTableView()

        // Do any additional setup after loading the view.
    }
    
    func configureUI() {
        tableViewBGView.layer.cornerRadius = 50
        tableViewBGView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
}

extension CallsViewController:UITableViewDelegate, UITableViewDataSource {
    func configureTableView() {
        callsTableView.delegate = self
        callsTableView.dataSource = self
        callsTableView.register(UINib(nibName: "CallsTableViewCell", bundle: .main), forCellReuseIdentifier: "CallsTableViewCell")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CallsTableViewCell", for: indexPath) as! CallsTableViewCell
        return cell
    }
}
