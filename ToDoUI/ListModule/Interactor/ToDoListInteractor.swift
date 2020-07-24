//
//  ToDoListInteractor.swift
//  ToDoUI
//
//  Created by jiyuujin on 2020/07/22.
//  Copyright © 2020 io.kyoto.nekohack. All rights reserved.
//

import Foundation
import RealmSwift

class ToDoListInteractor: ToDoListInteractorInputProtocol {

    var todoList: [ToDoListRealmItem] = []

    let realm = try! Realm()

    weak var presenter: ToDoListInteractorOutputProtocol?

    func retrieveTodos() {
        presenter?.didRetrieveTodos(todoList)
    }

    func saveTodo(_ todo: ToDoListRealmItem) {
        let todoModel = ToDoListRealmItem()
        todoModel.title = todo.title
        todoModel.content = todo.content
        try! realm.write {
            realm.add(todoModel)
        }
        presenter?.didAddTodo(todo)
    }

    func deleteTodo(_ todo: ToDoListRealmItem) {
        let results = realm.objects(ToDoListRealmItem.self).filter("title == '" + todo.title + "'")
        try! realm.write {
            realm.delete(results)
        }
        presenter?.didRemoveTodo(todo)
    }

}
