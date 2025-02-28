//
//  FavoritesViewController.swift
//  LoginApp
//
//  Created by Mohammad Khan on 28/02/25.
import UIKit
import RxSwift
import RxCocoa

class FavoritesViewController: UIViewController {
    private let viewModel: FavoritesViewModel
    private let disposeBag = DisposeBag()

    private let tableView: UITableView = {
        let table = UITableView()
        table.register(PostTableViewCell.self, forCellReuseIdentifier: "PostCell") // 🔹 Use custom cell
        table.estimatedRowHeight = 60 // 🔹 Estimate initial height
        table.rowHeight = UITableView.automaticDimension // 🔹 Enable auto-resizing
        return table
    }()

    init(viewModel: FavoritesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableView()
        bindViewModel()
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
    }

    private func bindViewModel() {
        viewModel.favoritePosts
            .bind(to: tableView.rx.items(cellIdentifier: "PostCell", cellType: PostTableViewCell.self)) { _, post, cell in
                cell.titleLabel.text = post.title
            }
            .disposed(by: disposeBag)

        tableView.rx.modelDeleted(Post.self)
            .subscribe(onNext: { [weak self] post in
                self?.viewModel.removeFavorite(post: post)
            })
            .disposed(by: disposeBag)
    }
}
