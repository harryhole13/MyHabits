//
//  SceneDelegate.swift
//  MyHabits
//
//  Created by Алексей Потемин on 22.09.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
       
        guard let myWindowScene = (scene as? UIWindowScene) else { return }
        
        let habits = UINavigationController(rootViewController: HabitsViewController())
        let infoHabits = UINavigationController(rootViewController: InfoViewController())
        
        
        let tabBar = UITabBarController()
        tabBar.tabBar.backgroundColor = .white
        tabBar.setViewControllers([habits,infoHabits], animated: true)
        
        habits.tabBarItem = UITabBarItem(title: "Привычки", image: UIImage(systemName: "rectangle.grid.1x2.fill"), tag: 0)
        infoHabits.tabBarItem = UITabBarItem(title: "Информация", image: UIImage(systemName: "info.circle.fill"), tag: 1)
        
    
        
        window = UIWindow(windowScene: myWindowScene)
        window?.rootViewController = tabBar
        window?.makeKeyAndVisible()
    }




}

