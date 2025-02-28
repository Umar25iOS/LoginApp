//
//  Post.swift
//  LoginApp
//
//  Created by Mohammad Khan on 28/02/25.
import Foundation
import RealmSwift

class Post: Object, Codable {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var title: String
    @Persisted var body: String
    @Persisted var isFavorite: Bool = false

    enum CodingKeys: String, CodingKey {
        case id, title, body
    }

    func toggleFavorite() {
        let realm = try! Realm()
        try? realm.write {
            self.isFavorite.toggle()
        }
    }
}
