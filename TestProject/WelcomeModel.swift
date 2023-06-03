//
//  WelcomeModel.swift
//  TestProject
//
//  Created by Chandru M on 03/06/23.
//

import Foundation


struct WelcomeModel: Hashable, Codable {
    var id: String?
    var author: String?
    var width: Int?
    var height: Int?
    var url: String?
    var download_url: String?
    
    private enum CodingKeys : String, CodingKey {
        case id
        case author
        case width
        case height
        case url
        case download_url
    }
    
    init(){}
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try? container.decodeIfPresent(String.self, forKey: .id)
        author = try? container.decodeIfPresent(String.self, forKey: .author)
        width = try? container.decodeIfPresent(Int.self, forKey: .width)
        height = try? container.decodeIfPresent(Int.self, forKey: .height)
        url = try? container.decodeIfPresent(String.self, forKey: .url)
        download_url = try? container.decodeIfPresent(String.self, forKey: .download_url)
    }
    
    var isSeleceted: Bool = false 
}
