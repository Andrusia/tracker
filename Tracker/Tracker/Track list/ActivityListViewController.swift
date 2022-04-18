//
//  ActivityListViewController.swift
//  Tracker
//
//  Created by Andrei Panasik on 12.12.21.
//

import UIKit

final class ActivityListViewController: UIViewController, ActivityListViewable {
    var presenter: ActivityListPresentable?

    private let tableView = UITableView()
    private var sections: [ActivityListViewModel.Section] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        presenter?.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.viewDidLoad()
    }

    func configure(with viewModel: ActivityListViewModel) {
        sections = viewModel.sections
        tableView.reloadData()
    }
}

extension ActivityListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].activities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let activity = sections[indexPath.section].activities[indexPath.row]
        cell.textLabel?.text = activity.exercise.rawValue + " " + String(activity.amount)
        cell.detailTextLabel?.text = activity.hoursAndMinutes
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].activities.first?.dateForSection
    }
}

extension ActivityListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

private extension ActivityListViewController {
    
    func setupUI() {
        title = "Activities: "
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.sectionHeaderHeight = 50
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor)
        ])

        navigationItem.setLeftBarButton(.init(
            title: "Sign out", primaryAction: .init(handler: { _ in self.goToLoginVC() }), menu: nil), animated: true)
        navigationItem.rightBarButtonItem = .init(
            systemItem: .add,
            primaryAction: .init(handler: { _ in self.didTapAdd() }), menu: nil)
        navigationItem.rightBarButtonItems?.append(.init(systemItem: .trash, primaryAction: .init(handler: { _ in self.clearTableView() }), menu: nil))
    }
    
    func didTapAdd() {
        presenter?.didTapAddActivity()
    }

    func goToLoginVC() {
        presenter?.didTapLogout()
    }
    
    func clearTableView() {
        presenter?.didTapRemoveAll()
        tableView.reloadData()
    }
}
