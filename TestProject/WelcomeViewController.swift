//
//  ViewController.swift
//  TestProject
//
//  Created by Chandru M on 03/06/23.
//

import UIKit

class WelcomeViewController: BaseViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var authorsTableView: UITableView!
    
    //MARK: - Internal Variables
    var welcomVM = WelcomeViewModel()
    var pullRefresh = UIRefreshControl()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showNavigationBar()
        configureTableView()
        hideBackButton()
        configureUI()
        welcomVM.delegate = self
        welcomVM.getWelcomeList()
    }
    
    private func configureUI() {
        self.title = "Welcome"
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

