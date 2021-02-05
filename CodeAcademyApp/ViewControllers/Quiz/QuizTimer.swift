import Foundation

protocol QuizTimerDelegate: AnyObject {
    func quizTimerDidFire(_ quizTimer: QuizTimer)
    func quizTimerTimeInterval() -> Double
}

class QuizTimer {

    private var timer: Timer?
    weak var delegate: QuizTimerDelegate?
    
    func start() {
        guard let delegate = delegate else {
            return
        }
        timer = Timer.scheduledTimer(
            timeInterval: delegate.quizTimerTimeInterval(),
            target: self,
            selector: #selector(onTimerFired),
            userInfo: nil,
            repeats: false
        )
    }
    
    func reset() {
        stop()
        start()
    }
    
    private func stop() {
        timer?.invalidate()
        timer = nil
    }

    @objc private func onTimerFired() {
        delegate?.quizTimerDidFire(self)
    }
}
