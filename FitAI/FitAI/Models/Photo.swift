//
//  Photo.swift
//  FitAI
//
//  Photo model
//

import Foundation

struct Photo: Codable, Identifiable {
    let id: String
    let userId: String
    var foodEntryId: String?
    let storageURL: String
    var localPath: String?
    let fileSize: Int
    let mimeType: String
    let createdAt: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case foodEntryId = "food_entry_id"
        case storageURL = "storage_url"
        case localPath = "local_path"
        case fileSize = "file_size"
        case mimeType = "mime_type"
        case createdAt = "created_at"
    }
}

