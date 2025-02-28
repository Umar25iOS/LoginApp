//
//  HomeViewController.swift
//  LoginApp
//
//  Created by Mohammad Khan on 28/02/25.
import UIKit

class HomeViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // ✅ Step 1: Create ViewModel Instances
        let postsViewModel = PostsViewModel()
        let favoritesViewModel = FavoritesViewModel()

        // ✅ Step 2: Create ViewControllers and Inject ViewModels
        let postsVC = PostsViewController(viewModel: postsViewModel)
        let favoritesVC = FavoritesViewController(viewModel: favoritesViewModel)

        // ✅ Step 3: Wrap Each ViewController in a NavigationController
        let postsNav = UINavigationController(rootViewController: postsVC)
        let favoritesNav = UINavigationController(rootViewController: favoritesVC)

        // ✅ Step 4: Set Tab Bar Icons and Titles
        postsNav.tabBarItem = UITabBarItem(title: "Posts", image: UIImage(systemName: "list.bullet"), tag: 0)
        favoritesNav.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "star.fill"), tag: 1)

        // ✅ Step 5: Assign ViewControllers to the TabBarController
        self.viewControllers = [postsNav, favoritesNav]

        // ✅ Step 6: Configure the Tab Bar Appearance (Optional)
        tabBar.tintColor = .systemBlue
        tabBar.backgroundColor = .white
    }
}
