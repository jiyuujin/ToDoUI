//
//  ToDoListProtocol.swift
//  ToDoUI
//
//  Created by jiyuujin on 2020/07/22.
//  Copyright © 2020 io.kyoto.nekohack. All rights reserved.
//

import UIKit

protocol ToDoListPresenterProtocol: class {

    var view: ToDoListViewProtocol? { get set }
    var interactor: ToDoListInteractorInputProtocol? { get set }
    var router: ToDoListRouterProtocol? { get set }

    func viewWillAppear()
    func addTodo(_ todo: ToDoListRealmItem)
    func removeTodo(_ todo: ToDoListRealmItem)

}

protocol ToDoListViewProtocol: class {
    
    var presenter: ToDoListPresenterProtocol? { get set }
    
    func showTodos(_ todos: [ToDoListRealmItem])
    func showErrorMessage(_ message: String)

}

protocol ToDoListInteractorInputProtocol: class {

    var presenter: ToDoListInteractorOutputProtocol? { get set }

    func retrieveTodos()
    func saveTodo(_ todo: ToDoListRealmItem)
    func deleteTodo(_ todo: ToDoListRealmItem)

}

protocol ToDoListInteractorOutputProtocol: class {

    func didAddTodo(_ todo: ToDoListRealmItem)
    func didRemoveTodo(_ todo: ToDoListRealmItem)
    func didRetrieveTodos(_ todos: [ToDoListRealmItem])
    func onError(message: String)

}

protocol ToDoListRouterProtocol: class {

    static func createToDoListModule() -> UIViewController

}
