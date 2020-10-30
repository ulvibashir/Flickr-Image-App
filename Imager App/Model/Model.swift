//
//  Model.swift
//  Imager App
//
//  Created by Ulvi Bashirov on 10/26/20.
//

import Foundation

struct Result: Codable {
    let photos: Photos?
    let stat: String?
}

struct Photo: Codable {
    let id: String?
    let owner: String?
    let secret: String?
    let server: String?
    let farm: Int?
    let title: String?
    let ispublic: Int?
    let isfriend: Int?
    let isfamily: Int?
}

struct Photos: Codable {
    let page: Int?
    let pages: Int?
    let perpage: Int?
    let total: Int?
    let photo: [Photo]?
}
