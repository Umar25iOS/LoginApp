//
//  FavoritesViewModel.swift
//  LoginApp
//
//  Created by Mohammad Khan on 28/02/25.
import RealmSwift
import RxSwift
import RxCocoa

class FavoritesViewModel {
    private let realm = try! Realm()
    private let disposeBag = DisposeBag()
    private var notificationToken: NotificationToken?

    let favoritePosts: BehaviorRelay<[Post]> = BehaviorRelay(value: [])

    init() {
        observeFavorites()
    }

    private func observeFavorites() {
        let results = realm.objects(Post.self).filter("isFavorite == true")

        // Observe Realm changes dynamically
        notificationToken = results.observe { [weak self] changes in
            switch changes {
            case .initial(let posts), .update(let posts, _, _, _):
                self?.favoritePosts.accept(Array(posts))
            case .error(let error):
                print("Error observing favorites: \(error)")
            }
        }
    }

    deinit {
        notificationToken?.invalidate()
    }

    func removeFavorite(post: Post) {
        try! realm.write {
            post.isFavorite = false
        }
    }
}
