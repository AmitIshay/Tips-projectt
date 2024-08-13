// Worker.swift

import Foundation

class Worker {
    var name: String
    var timeShift: String
    let role: String
    
    init(name: String, timeShift: String, role: String) {
        self.name = name
        self.timeShift = timeShift
        self.role = role
    }
}
