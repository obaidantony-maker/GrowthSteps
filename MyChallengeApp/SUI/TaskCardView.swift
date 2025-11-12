
import SwiftUI

struct TaskCardView: View {
    
    let cardNumber: Int
    let category: TaskCategory
    let task: DailyTask
    
    var body: some View {
        switch task.status {
        case .notStarted:
            StartCardView(cardNumber: cardNumber, category: category)
        case .select:
            SelectedCardView(task: task)
        case .completed:
            if #available(iOS 15.0, *) {
                CompletedCardView(cardNumber: cardNumber, category: category, task: task, isCompleted: true)
            } else {
                // Fallback on earlier versions
            }
        case .didNotComplete:
            if #available(iOS 15.0, *) {
                CompletedCardView(cardNumber: cardNumber, category: category, task: task, isCompleted: false)
            } else {
                // Fallback on earlier versions
            }
        }
    }
}
