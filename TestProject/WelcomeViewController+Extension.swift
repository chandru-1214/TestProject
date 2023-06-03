//
//  WelcomeViewController+Extension.swift
//  TestProject
//
//  Created by Chandru M on 03/06/23.
//


import UIKit

extension WelcomeViewController: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        welcomVM.welcomeList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let welocomData = welcomVM.welcomeList[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIds.welcomeTableViewCell, for: indexPath) as? WelcomeTableViewCell {
            cell.configureCell(welocomData)
            return cell
        }
        return UITableViewCell()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y + scrollView.frame.height >= scrollView.contentSize.height {
            print("scrollViewDidEndDecelerating")
            welcomVM.currentOffset += 1
            welcomVM.offset = welcomVM.currentOffset
            welcomVM.getWelcomeList()
        }
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
      
    }
}

extension WelcomeViewController: WelcomeViewModelDelegate {
    
    func refreshView() {
        DispatchQueue.main.async {
            self.pullRefresh.endRefreshing()
            self.authorsTableView.reloadData()
        }
       
    }
}
