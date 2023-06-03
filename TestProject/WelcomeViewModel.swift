//
//  WelcomeViewModel.swift
//  TestProject
//
//  Created by Vignesh S on 03/06/23.
//

import Foundation

protocol WelcomeViewModelDelegate: AnyObject {
    func refreshView()
}


class WelcomeViewModel: NSObject {
    
    var offset = 1 // offset to send server
    var currentOffset = 1 //current offset
    var pageLimit = 20
    var welcomeList = [WelcomeModel]()
    weak var delegate: WelcomeViewModelDelegate?
    
    
    func getWelcomeList() {
        let urlString = BaseURL.welcomListURL + "?page=\(offset)&limit=\(pageLimit)"
        let url = URL(string: urlString)
        var request = URLRequest(url: url!)
        // request.httpMethod = "GET"
        print("URl >>> \(url)")
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
                    print(welcomeModels)
                    if self.offset == 1 {
                        self.addWelcomeList(welcomeModels)
                    } else {
                        self.welcomeList.append(contentsOf: welcomeModels)
                    }
                   
                    delegate?.refreshView()
                } catch {
                    print(String(describing: error))
                }
            }
        }
        task.resume()
    }
    
    private func addWelcomeList(_ modelList: [WelcomeModel]) {
        for list in modelList {
            if let index = welcomeList.firstIndex(where: { $0.id == list.id }) {
                welcomeList[index] = list
            } else {
                welcomeList.append(list)
            }
        }
    }
}
