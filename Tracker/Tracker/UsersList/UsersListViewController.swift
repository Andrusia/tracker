//
//  UsersListViewController.swift
//  Tracker
//
//  Created by Andrei Panasik on 19.01.22.
//

import Foundation
import UIKit

final class UsersListViewController: UIViewController, UsersListViewable {
    var presenter: UsersListPresentable?
    
    private let tableView = UITableView()
    private var sections: [UsersListViewModel.Section] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        presenter?.didLoad()
    }

    func configure(with viewModel: UsersListViewModel) {
        sections = viewModel.sections
        tableView.reloadData()
    }
}

extension UsersListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)

        let button = UIButton(type: .contactAdd)
        let action = UIAction() { _ in self.tapAddFriend(indexPath: indexPath) }
        button.addAction(action, for: .touchUpInside)

        cell.editingAccessoryView = button
        cell.textLabel?.text = sections[indexPath.section].users[indexPath.row].login

        return cell
    }
}

extension UsersListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        guard let cell = tableView.cellForRow(at: indexPath) else { return indexPath }

        guard cell.isSelected else {

            cell.setEditing(true, animated: true)

            return indexPath
        }
        cell.isSelected = false
        cell.setEditing(false, animated: true)

        return nil
    }

    func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
        tableView.cellForRow(at: indexPath)?.setEditing(false, animated: true)
        return indexPath
    }
}

private extension UsersListViewController {

   private func setupUI() {
        view.backgroundColor = .white
        title = "Users"
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

   private func tapAddFriend(indexPath: IndexPath) {
        let user = sections[indexPath.section].users[indexPath.row]

        presenter?.didTapAddFriendToList(newFriend: user)
        presenter?.didTapBack()
    }
}
