//
//  HomeViewController.swift
//  Chatbox
//
//  Created by Afnan Ahmed on 26/01/2024.
//

import UIKit

class HomeViewController: UIViewController {

    var token = ""
    @IBOutlet weak var storiesCollectionView: UICollectionView!
    @IBOutlet weak var massagesTableView: UITableView!
    @IBOutlet weak var TabelViewBGView: UIView!
    var viewModel: HomeViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        ConfigureUI()
        configureTableView()
        configureCollectionView()
        observeEvent()
        if let token = UserDefaults.standard.string(forKey: "Token")  {
            viewModel.requestToGetUsers(sender: token)
        }
        // Do any additional setup after loading the view.
    }
    
    func ConfigureUI() {
        TabelViewBGView.layer.cornerRadius = 50
        TabelViewBGView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
    }
    
    
    func observeEvent() {
        viewModel.output = { [weak self] event in
            guard let self else { return }
            switch event {
            case .chatloaded:
                massagesTableView.reloadData()
            }
        }
    }
    
    
    
}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func configureTableView() {
        massagesTableView.delegate = self
        massagesTableView.dataSource = self
        massagesTableView.register(UINib(nibName: "MassagesTableViewCell", bundle: .main), forCellReuseIdentifier: "MassagesTableViewCell")
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.ChatsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MassagesTableViewCell", for: indexPath) as! MassagesTableViewCell
        cell.setupCell(data: viewModel.ChatsData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.requestTogoMessages(user: viewModel.ChatsData[indexPath.row].user)
    }
}


extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func configureCollectionView() {
        storiesCollectionView.delegate = self
        storiesCollectionView.dataSource = self
        storiesCollectionView.register(UINib(nibName: "StatusCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "StatusCollectionViewCell")
        setLayoutOfCollectionView()
    }
    func setLayoutOfCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 17
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 66,
                                 height: 82)
        storiesCollectionView.setCollectionViewLayout(layout, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StatusCollectionViewCell", for: indexPath) as! StatusCollectionViewCell
        return cell
    }
    
    
}
