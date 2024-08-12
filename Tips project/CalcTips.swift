//
//  ViewController.swift
//  Tips project
//
//  Created by Student22 on 10/08/2024.
//

import UIKit

class CalcTips: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var totalHoursLbl: UILabel!
    @IBOutlet weak var workerTime: UITextField!
    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var workers: [Worker] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the data source and delegate
                tableView.dataSource = self
                tableView.delegate = self
                
                // Register a default cell
                tableView.register(UITableViewCell.self, forCellReuseIdentifier: "WorkerCell")
            }
    
    
    @IBAction func nextButtonView(_ sender: Any) {
    }
    
    @IBAction func addWorkerButton(_ sender: Any) {
        // Ensure that both fields are not empty
        guard let name = nameInput.text, !name.isEmpty,
              let timeShift = workerTime.text, !timeShift.isEmpty else {
            // Optionally show an alert to the user if fields are empty
            let alert = UIAlertController(title: "Error", message: "Please enter both name and time shift.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        // Create a new Worker and add to the list
        let newWorker = Worker(name: name, timeShift: timeShift)
        workers.append(newWorker)
        
        // Print the new worker's details to the console
        print("Added new worker: Name: \(newWorker.name), Time Shift: \(newWorker.timeShift)")
        
        // Optionally update the UI to reflect the new worker list
        updateTotalHoursLabel()
        tableView.reloadData() // Refresh the table view

        // Clear text fields after adding the worker
        nameInput.text = ""
        workerTime.text = ""
    }
    func updateTotalHoursLabel() {
        var totalMinutes = 0
        
        for worker in workers {
            if let time = timeStringToMinutes(worker.timeShift) {
                totalMinutes += time
            }
        }
        
        // Convert total minutes to hours and minutes
        let hours = totalMinutes / 60
        let minutes = totalMinutes % 60
        
        // Update the label
        totalHoursLbl.text = String(format: "%02d:%02d", hours, minutes)
    }
    
    func timeStringToMinutes(_ timeString: String) -> Int? {
        let components = timeString.split(separator: ":")
        if components.count == 2,
           let hours = Int(components[0].trimmingCharacters(in: .whitespaces)),
           let minutes = Int(components[1].trimmingCharacters(in: .whitespaces)) {
            return hours * 60 + minutes
        }
        return nil
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return workers.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WorkerCell", for: indexPath)
            let worker = workers[indexPath.row]
            cell.textLabel?.text = "Name: \(worker.name), Time Shift: \(worker.timeShift)"
            return cell
        }
        
}

