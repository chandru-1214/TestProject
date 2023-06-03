//
//  ImageCache.swift
//  TestProject
//
//  Created by Chandru M on 03/06/23.
//

import UIKit


class ImageCache {
    
    
    static func storeImage(_ urlString: String, _ image: UIImage) {
        let path = NSTemporaryDirectory().appending(UUID().uuidString)
        let url = URL(fileURLWithPath: path)
        let data = image.jpegData(compressionQuality: 0.5)
        do {
            try data?.write(to: url)
        } catch {
            print("Save image error", error.localizedDescription)
        }
        
        var dict = UserDefaults.standard.object(forKey: "imageCache") as? [String: String]
        if dict == nil {
            dict = [String: String]()
        }
        
        dict?[urlString] = path
        UserDefaults.standard.set(dict, forKey: "imageCache")
        
    }
    
    
    
    static func setImage(imageView: UIImageView, urlString: String) {
        
        if let dict = UserDefaults.standard.object(forKey: "imageCache") as? [String: String],
           let imagePath = dict[urlString],
           let imageUrl = URL(string: imagePath),
           let imgData = try? Data(contentsOf: imageUrl) {
            DispatchQueue.main.async {
                imageView.image = UIImage(data: imgData)
            }
        } else {

            guard let url = URL(string: urlString) else { return }
            print(url)
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                DispatchQueue.main.async {
                    if let data = data,
                       let image = UIImage(data: data) {
                        imageView.image = image
                    }
                }
            }
            task.resume()
        }
    }
    
    
}
