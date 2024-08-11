import Foundation

// Define the Worker class conforming to Codable for serialization
class Worker: Codable {
    // Private storage properties
        private var _workerName: String
        private var _timeShiftWorker: String
        private var _exchangeTimeShiftWorker: Double
        private var _workerType: String
        private var _totalMoneyWorker: Int
        private var _startTimeWorker: String
        private var _finishTimeWorker: String

        // Public getters and setters
        public var workerName: String {
            get {
                return _workerName
            }
            set {
                _workerName = newValue
            }
        }

        public var timeShiftWorker: String {
            get {
                return _timeShiftWorker
            }
            set {
                _timeShiftWorker = newValue
            }
        }

        public var exchangeTimeShiftWorker: Double {
            get {
                return _exchangeTimeShiftWorker
            }
            set {
                _exchangeTimeShiftWorker = newValue
            }
        }

        public var workerType: String {
            get {
                return _workerType
            }
            set {
                _workerType = newValue
            }
        }

        public var totalMoneyWorker: Int {
            get {
                return _totalMoneyWorker
            }
            set {
                _totalMoneyWorker = newValue
            }
        }

        public var startTimeWorker: String {
            get {
                return _startTimeWorker
            }
            set {
                _startTimeWorker = newValue
            }
        }

        public var finishTimeWorker: String {
            get {
                return _finishTimeWorker
            }
            set {
                _finishTimeWorker = newValue
            }
        }

        // Initializer
        public init(workerName: String, timeShiftWorker: String, exchangeTimeShiftWorker: Double,
                    workerType: String, totalMoneyWorker: Int, startTimeWorker: String, finishTimeWorker: String) {
            self._workerName = workerName
            self._timeShiftWorker = timeShiftWorker
            self._exchangeTimeShiftWorker = exchangeTimeShiftWorker
            self._workerType = workerType
            self._totalMoneyWorker = totalMoneyWorker
            self._startTimeWorker = startTimeWorker
            self._finishTimeWorker = finishTimeWorker
        }
    // Implement CustomStringConvertible
    public var description: String {
        return "Worker(name: \(workerName), timeShift: \(timeShiftWorker), exchangeTimeShift: \(exchangeTimeShiftWorker), type: \(workerType), totalMoney: \(totalMoneyWorker), startTime: \(startTimeWorker), finishTime: \(finishTimeWorker))"
    }
}
