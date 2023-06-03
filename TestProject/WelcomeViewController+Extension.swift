//
//  WelcomeViewController+Extension.swift
//  TestProject
//
//  Created by Chandru M on 03/06/23.
//


import UIKit

//MARK: -  UITableViewDelegate, UITableViewDataSource
extension WelcomeViewController: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        welcomVM.welcomeList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let welocomData = welcomVM.welcomeList[indexPath.row]
        let imgHeight = welocomData.imageHeight > maximumImageWidth ? maximumImageWidth :  welocomData.imageHeight
        //adding image height & bottom view height & author content size
        return CGFloat(imgHeight + 80) + welocomData.contentSize.height
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let welocomData = welcomVM.welcomeList[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIds.welcomeTableViewCell, for: indexPath) as? WelcomeTableViewCell {
            cell.configureCell(welocomData)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let welocomData = welcomVM.welcomeList[indexPath.row]
        let popupVC = PopupViewController(nibName: "PopupViewController", bundle: nil)
        popupVC.modalPresentationStyle = .overCurrentContext
        popupVC.welcomeData =  welocomData
        popupVC.delegate = self
        self.present(popupVC, animated: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y + scrollView.frame.height >= scrollView.contentSize.height {
            //increase current offset 
            welcomVM.currentOffset += 1
            welcomVM.offset = welcomVM.currentOffset
            welcomVM.getWelcomeList()
        }
    }

}

//MARK: - WelcomeViewModelDelegate
extension WelcomeViewController: WelcomeViewModelDelegate {
    
    func refreshView() {
        DispatchQueue.main.async {
            self.pullRefresh.endRefreshing()
            self.authorsTableView.reloadData()
        }
       
    }
}

//MARK: - PopupViewControllerDelegate
extension WelcomeViewController: PopupViewControllerDelegate {
    
    func leftTapAction(_ welcomeData: WelcomeModel) {
    }
    
    func rightTapAction(_ welcomeData: WelcomeModel) {
       if let index = welcomVM.welcomeList.firstIndex(where: { $0.id == welcomeData.id }) {
           welcomVM.welcomeList[index].isSeleceted.toggle()
           let cellIndexPath = IndexPath(row: index, section: 0)
           let cell = authorsTableView.cellForRow(at: cellIndexPath) as! WelcomeTableViewCell
           cell.setCheckBoxView(welcomVM.welcomeList[index])
        }
    }
    
    
}
