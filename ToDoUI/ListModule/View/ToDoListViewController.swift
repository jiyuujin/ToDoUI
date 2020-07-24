//
//  ToDoListViewController.swift
//  ToDoUI
//
//  Created by jiyuujin on 2020/07/22.
//  Copyright © 2020 io.kyoto.nekohack. All rights reserved.
//

import UIKit
import RealmSwift

class ToDoListViewController: UITableViewController {

    var presenter: ToDoListPresenterProtocol?

    var todoList: Results<ToDoListRealmItem>!
    var token: NotificationToken!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        presenter?.viewWillAppear()
    }

    override func awakeFromNib() {
      super.awakeFromNib()
      let realm = try! Realm()
      todoList = realm.objects(ToDoListRealmItem.self)
      token = todoList.observe { [weak self] _ in
        self?.reload()
      }
    }

    private func setupView() {
        tableView.tableFooterView = UIView()
    }

    private func reload() {
      tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let todo = todoList[indexPath.row]
        cell.textLabel?.text = todo.title
        cell.detailTextLabel?.text = todo.content
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let todoItem = todoList[indexPath.row]
            presenter?.removeTodo(todoItem)
        }
    }

    @IBAction func addTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "ToDoを追加する", message: "タイトルとその詳細を入力してください", preferredStyle: .alert)
        alertController.addTextField(configurationHandler: nil)
        alertController.addTextField(configurationHandler: nil)
        alertController.addAction(UIAlertAction(title: "確定する", style: .default, handler: { [weak self](_) in
            let titleText = alertController.textFields![0].text ?? ""
            let contentText = alertController.textFields![1].text ?? ""
            guard !titleText.isEmpty else { return }
            let todoItem = ToDoListRealmItem(value: ["title": titleText, "content": contentText])
            self?.presenter?.addTodo(todoItem)
        }))
        
        alertController.addAction(UIAlertAction(title: "キャンセル", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
}

extension ToDoListViewController: ToDoListViewProtocol {

    func showTodos(_ todos: [ToDoListRealmItem]) {
        let realm = try! Realm()
        self.todoList = realm.objects(ToDoListRealmItem.self)
    }

    func showErrorMessage(_ message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }

}
