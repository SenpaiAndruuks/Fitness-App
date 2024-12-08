//
//  WorkoutsVC.swift
//  Beyond Fit
//
//  Created by Andrew on 02/10/2021.
//

import UIKit

class WorkoutsVC: UIViewController {
    
    // MARK:- Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK:- Properties
    var workout: Workout!
    
    // MARK:- LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        title = workout.day
        navigationController?.navigationBar.topItem?.title = "Back"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}

// MARK:- TableView Delegate
extension WorkoutsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        workout.bodyPart
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        workout.routine.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = workout.routine[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
