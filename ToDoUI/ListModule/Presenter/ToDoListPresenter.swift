//
//  ToDoListPresentar.swift
//  ToDoUI
//
//  Created by jiyuujin on 2020/07/22.
//  Copyright © 2020 io.kyoto.nekohack. All rights reserved.
//

import UIKit

class ToDoListPresenter: ToDoListPresenterProtocol {

    weak var view: ToDoListViewProtocol?
    var interactor: ToDoListInteractorInputProtocol?
    var router: ToDoListRouterProtocol?

    func viewWillAppear() {
        interactor?.retrieveTodos()
    }

    func addTodo(_ todo: ToDoListRealmItem) {
        interactor?.saveTodo(todo)
    }

    func removeTodo(_ todo: ToDoListRealmItem) {
        interactor?.deleteTodo(todo)
    }

}

extension ToDoListPresenter: ToDoListInteractorOutputProtocol {

    func didRetrieveTodos(_ todos: [ToDoListRealmItem]) {
        view?.showTodos(todos)
    }
    
    func didAddTodo(_ todo: ToDoListRealmItem) {
        interactor?.retrieveTodos()
    }

    func didRemoveTodo(_ todo: ToDoListRealmItem) {
        interactor?.retrieveTodos()
    }

    func onError(message: String) {
        view?.showErrorMessage(message)
    }

}
