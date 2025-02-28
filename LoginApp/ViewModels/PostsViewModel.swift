//
//  PostsViewModel.swift
//  LoginApp
//
//  Created by Mohammad Khan on 28/02/25.
import Foundation
import RealmSwift
import RxSwift
import RxCocoa

class PostsViewModel {
    private let realm = try! Realm()
    private let disposeBag = DisposeBag()
    private var notificationToken: NotificationToken?

    let posts: BehaviorRelay<[Post]> = BehaviorRelay(value: [])

    init() {
        observePosts()
    }

    private func observePosts() {
        let storedPosts = realm.objects(Post.self)

        // Observe changes in posts dynamically
        notificationToken = storedPosts.observe { [weak self] changes in
            switch changes {
            case .initial(let posts), .update(let posts, _, _, _):
                self?.posts.accept(Array(posts))
            case .error(let error):
                print("Error observing posts: \(error)")
            }
        }
    }

    deinit {
        notificationToken?.invalidate()
    }

    func toggleFavorite(post: Post) {
        try! realm.write {
            post.isFavorite.toggle()
        }
    }
}
