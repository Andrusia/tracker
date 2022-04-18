//
//  CreateSetViewController.swift
//  Tracker
//
//  Created by Andrei Panasik on 18.12.21.
//

import Foundation
import UIKit

final class CreateActivityViewController: UIViewController, CreateActivityViewble {

    var presenter: CreateActivityPresentable?

    var exerciseList: [Exercise] = []
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.didLoad()
        setupUI()
    }

    func configure(with viewModel: ExerciseListViewModel) {
        exerciseList = viewModel.exercises
    }
}

extension CreateActivityViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exerciseList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let exercise = exerciseList[indexPath.row]
        
        cell.textLabel?.text = "Exercise: " + exercise.title
        
        let details = exercise.muscleGroup.map { $0.rawValue }.joined(separator: ", ")
        cell.detailTextLabel?.text = "Muscle Group:  " + details
        
        return cell
    }
}

extension CreateActivityViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let alert = UIAlertController(title: "How much?", message: nil, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "amount"
            textField.keyboardType = .numberPad
        }
        alert.addAction(.init(title: "OK", style: .default) { _ in
            guard let value = alert.textFields?.first?.text else { return }

            if let activity = self.presenter?.didTapCreateActivity(exerciseIndex: indexPath.row, count: value),
                   activity {
                self.presenter?.didTapBack()
            } else {
                let alertAga = UIAlertController.init(title: "Ага..", message: nil, preferredStyle: .alert)
                alertAga.addAction(.init(title: "ok", style: .cancel) { _ in self.present(alert, animated: true, completion: nil) })
                self.present(alertAga, animated: true, completion: nil)
            }
        })
        
        alert.addAction(.init(title: "Cancel", style: .cancel))
        
        present(alert, animated: true)
    }
}

private extension CreateActivityViewController {
    func setupUI() {
        title = "Create"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor)
        ])
    }
}
