//
//  ViewController.swift
//  TestProject
//
//  Created by Chandru M on 03/06/23.
//

import UIKit

class WelcomeViewController: BaseViewController {
    
    @IBOutlet weak var authorsTableView: UITableView!
    var welcomVM = WelcomeViewModel()
    var pullRefresh = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
        
        configureTableView()
        configureUI()
        welcomVM.delegate = self
        welcomVM.getWelcomeList()
    }
    
    private func configureUI() {
        pullRefresh.addTarget(self, action: #selector(handleTopRefresh), for: .valueChanged)
        pullRefresh.tintColor = UIColor.blue
        authorsTableView.addSubview(pullRefresh)
    }
    
    @objc func handleTopRefresh() {
        welcomVM.offset = 1
        welcomVM.getWelcomeList()
    }
    
    private func configureTableView() {
        authorsTableView.register(
            UINib(nibName: TableViewCellIds.welcomeTableViewCell, bundle: nil),
            forCellReuseIdentifier: TableViewCellIds.welcomeTableViewCell)
    }
    
}

