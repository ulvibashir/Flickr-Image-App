//
//  Network.swift
//  Imager App
//
//  Created by Ulvi Bashirov on 10/26/20.
//

import Foundation
import Alamofire

struct Network {
    static let url = URL(string: "https://www.flickr.com/services/rest/")!
    
  
    
    static func getImagesArray(page: Int, completion: @escaping (Result) -> ()) {
        
        
        let params: [String: String] = [
            "api_key": NetworkUtility.apiKey,
            "method": NetworkUtility.method,
            "format": NetworkUtility.format,
            "per_page": "\(NetworkUtility.perPage)",
            "page": "\(page)"
            
        ]
        
        AF.request(url, method: .get, parameters: params).responseData(completionHandler: { response in
            if let jsonData = response.data {
                do {
                    var str = String(data: jsonData, encoding: .utf8)
                    str = str?.replacingOccurrences(of: "jsonFlickrApi(", with: "")
                    str = str?.replacingOccurrences(of: ")", with: "")
                    let data = str?.data(using: .utf8)
                    let res = try JSONDecoder().decode(Result.self, from: data!)
                    completion(res)
                    
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        })
    }
    
    static func getImage(photo: Photo) -> String {
        return "https://farm\(String(describing: photo.farm ?? 0)).staticflickr.com/\(String(describing: photo.server ?? ""))/\(String(describing: photo.id ?? ""))_\(String(describing: photo.secret ?? "")).jpg"
    }
}
