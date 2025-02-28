//
//  PostDTO.swift
//  LoginApp
//
//  Created by Mohammad Khan on 28/02/25.
//
struct PostDTO: Decodable {
    let id: Int
    let title: String
    let body: String

    func toRealmPost() -> Post {
        let post = Post()
        post.id = id
        post.title = title
        post.body = body
        return post
    }
}
