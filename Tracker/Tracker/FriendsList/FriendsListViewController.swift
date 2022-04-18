//
//  FriendsListViewController.swift
//  Tracker
//
//  Created by Andrei Panasik on 19.01.22.
//

import Foundation
import UIKit

final class FriendsListViewController: UIViewController, FriendsListViewble {

    var presenter: FriendsListPresentable?

    private let tableView = UITableView()
    private var friends: [User] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.didLoad()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tableView.isEditing = false
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.didLoad()
    }

    func configure(with viewModel: FriendsListModel) {
        friends = viewModel.friends
        tableView.reloadData()
    }
}

extension FriendsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        cell.textLabel?.text = friends[indexPath.row].login
        cell.editingAccessoryType = .detailButton

        return cell
    }
}

extension FriendsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        presenter?.didTapDeleteFriend(deleteFriend: friends.remove(at: indexPath.row) )
        tableView.deleteRows(at: [indexPath], with: .left)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //  tableView.deselectRow(at: indexPath, animated: true)
    }

}

private extension FriendsListViewController {
    private func setupUI() {
        view.backgroundColor = .white
        let username = ServiceContainer.shared.userService.currentUser?.login ?? "?"
        title = "\(username)"

        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        navigationItem.rightBarButtonItems = [ .init(systemItem: .add, primaryAction: tapAddButton(), menu: nil)]
        navigationItem.rightBarButtonItems?.append(.init(systemItem: .edit, primaryAction: tapEditButton(), menu: nil))

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func tapAddButton() -> UIAction {
        let action = UIAction() { _ in
            self.tableView.isEditing = false
            self.presenter?.didTapAdd()
        }
        return action
    }

    private func tapEditButton() -> UIAction {
        let action = UIAction() { _ in
            self.tableView.isEditing = !self.tableView.isEditing
        }
        return action
    }
}
