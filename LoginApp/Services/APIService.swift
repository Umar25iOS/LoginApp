//
//  APIService.swift
//  LoginApp
//
//  Created by Mohammad Khan on 28/02/25.
//
import Alamofire
import RxSwift

class APIService {
    private let baseURL = "https://jsonplaceholder.typicode.com"

    func fetchPosts() -> Observable<[Post]> {
        return Observable.create { observer in
            let url = "\(self.baseURL)/posts"
            AF.request(url).responseDecodable(of: [PostDTO].self) { response in
                switch response.result {
                case .success(let postDTOs):
                    let posts = postDTOs.map { $0.toRealmPost() } // Convert DTOs to Realm objects
                    observer.onNext(posts)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
}
