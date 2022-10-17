//
//  JsonController.swift
//  JsonPlaceHolder
//
//  Created by Chun on 2022/10/12.
//

import Foundation
import UIKit

class JsonController {
  static let shared = JsonController()
  
  let imageCache = NSCache<NSURL, UIImage>()

  // MARK: - Fetch Json Data

  func fetchJsonData(urlString: String, completion: @escaping (Result<[JsonData], Error>) -> Void) {
    if let url = URL(string: urlString) {
      URLSession.shared.dataTask(with: url) { data, response, error in
        if let data = data {
          do {
            let decoder = JSONDecoder()
            let json = try decoder.decode([JsonData].self, from: data)
            completion(.success(json))
            print("Success Get \(json.count) Data")
          } catch {
            completion(.failure(error))
            print(error)
          }
        } else if let error = error {
          completion(.failure(error))
        }
      }.resume()
    }
  }

  // MARK: - Fetch Image

  func fetchImage(urlString: String, completion: @escaping (UIImage?) -> Void) {
    if let url = URL(string: urlString) {
      if let image = imageCache.object(forKey: url as NSURL) {
        completion(image)
        return
      }
      URLSession.shared.dataTask(with: url) { data, response, error in
        if let data = data, let image = UIImage(data: data) {
          self.imageCache.setObject(image, forKey: url as NSURL)
          completion(image)
        } else {
          completion(nil)
        }
      }.resume()
    }
  }
}
