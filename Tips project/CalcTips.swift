import UIKit

class CalcTips: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var totalHoursLbl: UILabel!
    @IBOutlet weak var workerTime: UITextField!
    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var rolePicker: UIPickerView!
    @IBOutlet weak var tableView: UITableView!

    var workers: [Worker] = []
    var selectedRole = "Bartender" // Default role
    let roles = ["Bartender", "Waiter"] // Available roles

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the data source and delegate
        tableView.dataSource = self
        tableView.delegate = self
        rolePicker.dataSource = self
        rolePicker.delegate = self
        
        // Register a default cell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "WorkerCell")
        
        // Set up the workerTime text field with a time picker
        setupTimePicker()
        
        // Set self as delegate for text fields
        workerTime.delegate = self
        nameInput.delegate = self
    }

    private func setupTimePicker() {
        let timePicker = UIDatePicker()
        timePicker.datePickerMode = .time
        timePicker.addTarget(self, action: #selector(timeChanged(_:)), for: .valueChanged)
        workerTime.inputView = timePicker
    }

    @objc private func timeChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        workerTime.text = dateFormatter.string(from: sender.date)
    }

    @IBAction func nextButtonView(_ sender: Any) {
    
        self.performSegue(withIdentifier: "goToFinal", sender: self)
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
        let newWorker = Worker(name: name, timeShift: timeShift, role: selectedRole)
        workers.append(newWorker)
        
        // Print the new worker's details to the console
        print("Added new worker: Name: \(newWorker.name), Time Shift: \(newWorker.timeShift), Role: \(newWorker.role)")
        
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
        cell.textLabel?.text = "Name: \(worker.name), Time Shift: \(worker.timeShift), Role: \(worker.role)"
        cell.textLabel?.font = UIFont.systemFont(ofSize: 12) // Change the font size here

        return cell
    }
}

// MARK: - UIPickerViewDataSource and UIPickerViewDelegate

extension CalcTips: UIPickerViewDataSource, UIPickerViewDelegate {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return roles.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return roles[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedRole = roles[row]
    }
}
