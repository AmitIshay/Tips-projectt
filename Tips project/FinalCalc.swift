import UIKit

class FinalCalc: UIViewController {
    
    @IBOutlet weak var txtlabl: UILabel!
    
    @IBOutlet weak var workersTableView: UITableView!
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
