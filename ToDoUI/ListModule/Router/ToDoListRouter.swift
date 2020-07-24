//
//  ToDoListRouter.swift
//  ToDoUI
//
//  Created by jiyuujin on 2020/07/22.
//  Copyright © 2020 io.kyoto.nekohack. All rights reserved.
//

import UIKit

class ToDoListRouter: ToDoListRouterProtocol {

    static var storyboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }

    static func createToDoListModule() -> UIViewController {
        let navController = storyboard.instantiateViewController(withIdentifier: "ToDoListNavigation") as! UINavigationController
        guard let todoViewController = navController.topViewController as? ToDoListViewController else { fatalError("Invalid View Controller") }
        let presenter: ToDoListPresenterProtocol & ToDoListInteractorOutputProtocol = ToDoListPresenter()
        let interactor: ToDoListInteractorInputProtocol = ToDoListInteractor()
        let router = ToDoListRouter()
        
        todoViewController.presenter = presenter
        presenter.view = todoViewController
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return navController
    }

}
