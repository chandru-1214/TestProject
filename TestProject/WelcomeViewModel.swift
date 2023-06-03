//
//  WelcomeViewModel.swift
//  TestProject
//
//  Created by Chandru M on 03/06/23.
//

import Foundation
import UIKit

protocol WelcomeViewModelDelegate: AnyObject {
    func refreshView()
}


class WelcomeViewModel: NSObject {
    
    var offset = 1 // offset to send server
    var currentOffset = 1 //current offset
    var pageLimit = 20
    var welcomeList = [WelcomeModel]()
    weak var delegate: WelcomeViewModelDelegate?
    
    
    /// Method to fetch welcome list from server
    func getWelcomeList() {
        let urlString = BaseURL.welcomListURL + "?page=\(offset)&limit=\(pageLimit)"
        let url = URL(string: urlString)
        var request = URLRequest(url: url!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self else { return }
            if error != nil {
                print(error?.localizedDescription ?? "")
            } else if let data = data {
                let decoder = JSONDecoder()
                do {
                    let welcomeModels = try decoder.decode([WelcomeModel].self, from: data)
                    self.checkAndUpdateModel(welcomeModels)
                } catch {
                    print(String(describing: error))
                }
            }
        }
        task.resume()
    }
    
    
    private func checkAndUpdateModel(_ welcomeModels: [WelcomeModel]) {
        var welcomeModels = welcomeModels
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return  }
            self.setMessagesContentSize(models: &welcomeModels)
            if self.offset == 1 {
                self.addWelcomeList(welcomeModels)
            } else {
                self.welcomeList.append(contentsOf: welcomeModels)
            }
            self.delegate?.refreshView()
        }
       
    }
    
    /// Method to add welocome data list
    /// - Parameter modelList: Denotes fetched welcome data list
    private func addWelcomeList(_ modelList: [WelcomeModel]) {
        for list in modelList {
            if let index = welcomeList.firstIndex(where: { $0.id == list.id }) {
                let isSeleceted = welcomeList[index].isSeleceted
                welcomeList[index] = list
                welcomeList[index].isSeleceted = isSeleceted
                
            } else {
                welcomeList.append(list)
            }
        }
    }
    
    
    /// Method to set cotent size of message
    /// - Parameter models: Denotes model list
    private func setMessagesContentSize(models: inout [WelcomeModel]) {
        for index in 0..<models.count {
            models[index].contentSize = getMessageContentSize(model: models[index])
        }
    }
    
    /// Method to get content size of particular model
    /// - Parameter model: Denotes model
    /// - Returns: Returns CGSize of model content
    private func getMessageContentSize(model: WelcomeModel) -> CGSize {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: maximumTextWidth, height:21))
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17)
        label.text = model.author
        var labelSize = label.sizeThatFits(CGSize(width: label.frame.width, height: CGFloat.greatestFiniteMagnitude))
        labelSize.width = (labelSize.width > maximumTextWidth ? maximumTextWidth : labelSize.width)
        labelSize.height =  (labelSize.height < minimunTextHeight ? minimunTextHeight : labelSize.height)
        return labelSize
    }
}
