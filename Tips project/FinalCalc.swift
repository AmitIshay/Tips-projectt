import UIKit

class FinalCalc: UIViewController {

    @IBOutlet weak var txtlabl: UILabel!
    @IBOutlet weak var calcTips: UIButton!
    @IBOutlet weak var enterTips: UITextField!
    @IBOutlet weak var workersTableView: UITableView!
    @IBOutlet weak var tipPerHour: UILabel! // Add the label for displaying money per hour
    
    // Properties to receive data from CalcTips
    var workers: [Worker] = []
    var totalHoursText: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the table view
        workersTableView.dataSource = self
        workersTableView.delegate = self
        
        // Register the cell class if using a basic UITableViewCell
        workersTableView.register(UITableViewCell.self, forCellReuseIdentifier: "WorkerCell")
        
        // Set the text label to show the total hours with a prefix
        if let totalHours = totalHoursText {
            txtlabl.text = "The total time is \(totalHours)"
        } else {
            txtlabl.text = "No data available"
        }
        
        // Reload the table view to display data
        workersTableView.reloadData()
    }

    @IBAction func calculateTipsPerHour(_ sender: Any) {
        guard let tipsText = enterTips.text, !tipsText.isEmpty,
              let totalHoursText = totalHoursText, !totalHoursText.isEmpty else {
            // Show an alert if any of the required fields are empty
            let alert = UIAlertController(title: "Error", message: "Please enter tips and ensure total hours are available.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
    }

        
        guard let tips = Double(tipsText),
              let totalHours = doubleFromTimeString(totalHoursText) else {
            // Show an alert if the conversion fails
            let alert = UIAlertController(title: "Error", message: "Invalid input for tips or total hours.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        let moneyPerHour = tips / totalHours
        let formattedMoneyPerHour = String(format: "%.2f", moneyPerHour)
        
        // Update the tipPerHour label with the result
        tipPerHour.text = "Money per hour: \(formattedMoneyPerHour)"
    }

    private func doubleFromTimeString(_ timeString: String) -> Double? {
        let components = timeString.split(separator: ":")
        if components.count == 2,
           let hours = Double(components[0].trimmingCharacters(in: .whitespaces)),
           let minutes = Double(components[1].trimmingCharacters(in: .whitespaces)) {
            return hours + (minutes / 60)
        }
        return nil
    }
}

extension FinalCalc: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkerCell", for: indexPath)
        let worker = workers[indexPath.row]
        cell.textLabel?.text = "Name: \(worker.name), Time Shift: \(worker.timeShift), Role: \(worker.role)"
        cell.textLabel?.font = UIFont.systemFont(ofSize: 12)
        return cell
    }
}
