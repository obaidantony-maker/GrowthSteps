import Foundation
import SwiftUI

class UserData: ObservableObject {
    @Published var selectedCategories: [TaskCategory] = []
    @Published var dailyTasks: [DailyTask] = []
    @Published var selectedTaskIndex: Int?
    @Published var taskHistory: [DailyTask] = []
    @Published var diaryEntries: [DiaryEntry] = []
    
    private let selectedCategoriesKey = "selectedCategories"
    private let dailyTasksKey = "dailyTasks"
    private let selectedTaskIndexKey = "selectedTaskIndex"
    private let taskHistoryKey = "taskHistory"
    private let diaryEntriesKey = "diaryEntries"
    private let currentStreakKey = "currentStreak"
    private let bestStreakKey = "bestStreak"
    
    private var currentStreak: Int = 0
    private var bestStreak: Int = 0
    
    init() {
        loadData()
        checkAndResetDailyTasks()
    }
        
    func saveSelectedCategories(_ categories: [TaskCategory]) {
        selectedCategories = categories
        saveData()
    }
    
    func createNewDailyTasks() {
        let categories = selectedCategories.isEmpty ? Array(TaskCategory.allCases) : selectedCategories
        
        dailyTasks = []
        for i in 0..<3 {
            let categoryIndex = i % categories.count
            let category = categories[categoryIndex]
            let task = TaskService.getRandomTask(for: category)
            dailyTasks.append(task)
        }
        
        selectedTaskIndex = nil
        saveData()
    }
    
    func selectTask(index: Int) {
        guard index < dailyTasks.count else { return }
        
        if dailyTasks[index].status == .completed || dailyTasks[index].isCompleate {
            selectedTaskIndex = index
            return
        }
        
        selectedTaskIndex = index
        var updatedTask = dailyTasks[index]
        updatedTask.status = .select
        dailyTasks[index] = updatedTask
        
        saveData()
    }
    
    func markTaskAsCompleted() {
        guard let index = selectedTaskIndex, index < dailyTasks.count else { return }
        
        var task = dailyTasks[index]
        task.status = .completed
        task.isCompleate = true
        dailyTasks[index] = task
        
        let historyTask = DailyTask(
            id: UUID(),
            category: task.category,
            text: task.text,
            status: task.status,
            date: task.date,
            isCompleate: task.isCompleate
        )
        taskHistory.append(historyTask)
        selectedTaskIndex = nil
        updateStreaks(taskCompleted: true)
        saveData()
    }
    
    func markTaskAsNotCompleted() {
        guard let index = selectedTaskIndex, index < dailyTasks.count else { return }
        
        var task = dailyTasks[index]
        task.status = .didNotComplete
        task.isCompleate = false
        dailyTasks[index] = task
        
        let historyTask = DailyTask(
            id: UUID(),
            category: task.category,
            text: task.text,
            status: task.status,
            date: task.date,
            isCompleate: task.isCompleate
        )
        taskHistory.append(historyTask)
        selectedTaskIndex = nil
        updateStreaks(taskCompleted: false)
        saveData()
    }
    
    var allTasksCompleted: Bool {
        return dailyTasks.count == 3 && dailyTasks.allSatisfy { $0.status == .completed }
    }
    
    func addDiaryEntry(_ entry: DiaryEntry) {
        diaryEntries.append(entry)
        saveData()
    }
    
    func getCompletedTasksCount() -> Int {
        return taskHistory.filter { $0.isCompleate }.count
    }
    
    func getNotCompletedTasksCount() -> Int {
        return taskHistory.filter { !$0.isCompleate }.count
    }
    
    func getCurrentStreak() -> Int {
        return currentStreak
    }
    
    func getBestStreak() -> Int {
        return bestStreak
    }
    
    func getTasksCompletedByType(_ category: TaskCategory) -> Int {
        return taskHistory.filter { $0.category == category && $0.isCompleate }.count
    }
    
    func getJournalEntriesCount() -> Int {
        return diaryEntries.count
    }
    
    private func updateStreaks(taskCompleted: Bool) {
        if taskCompleted {
            currentStreak += 1
            if currentStreak > bestStreak {
                bestStreak = currentStreak
            }
        } else {
            currentStreak = 0
        }
        
        UserDefaults.standard.set(currentStreak, forKey: currentStreakKey)
        UserDefaults.standard.set(bestStreak, forKey: bestStreakKey)
    }
    
    func resetAllData() {
        selectedCategories = []
        dailyTasks = []
        selectedTaskIndex = nil
        taskHistory = []
        diaryEntries = []
        currentStreak = 0
        bestStreak = 0
        
        UserDefaults.standard.removeObject(forKey: selectedCategoriesKey)
        UserDefaults.standard.removeObject(forKey: dailyTasksKey)
        UserDefaults.standard.removeObject(forKey: selectedTaskIndexKey)
        UserDefaults.standard.removeObject(forKey: taskHistoryKey)
        UserDefaults.standard.removeObject(forKey: diaryEntriesKey)
        UserDefaults.standard.removeObject(forKey: currentStreakKey)
        UserDefaults.standard.removeObject(forKey: bestStreakKey)
        
        createNewDailyTasks()
    }
    
    private func checkAndResetDailyTasks() {
        if dailyTasks.isEmpty {
            createNewDailyTasks()
            return
        }
        
        let firstTaskDate = dailyTasks[0].date
        if !Calendar.current.isDateInToday(firstTaskDate) {
            for task in dailyTasks where task.status != .completed {
                var updatedTask = task
                updatedTask.status = .completed
                updatedTask.isCompleate = false
                
                let historyTask = DailyTask(
                    id: UUID(),
                    category: updatedTask.category,
                    text: updatedTask.text,
                    status: updatedTask.status,
                    date: updatedTask.date,
                    isCompleate: updatedTask.isCompleate
                )
                taskHistory.append(historyTask)
            }
            
            if !dailyTasks.contains(where: { $0.isCompleate }) {
                currentStreak = 0
                UserDefaults.standard.set(currentStreak, forKey: currentStreakKey)
            }
            
            createNewDailyTasks()
        }
    }
    
    private func saveData() {
        let encoder = JSONEncoder()
        
        if let encodedCategories = try? encoder.encode(selectedCategories) {
            UserDefaults.standard.set(encodedCategories, forKey: selectedCategoriesKey)
        }
        
        if let encodedTasks = try? encoder.encode(dailyTasks) {
            UserDefaults.standard.set(encodedTasks, forKey: dailyTasksKey)
        }
        
        if let encodedHistory = try? encoder.encode(taskHistory) {
            UserDefaults.standard.set(encodedHistory, forKey: taskHistoryKey)
        }
        
        if let encodedEntries = try? encoder.encode(diaryEntries) {
            UserDefaults.standard.set(encodedEntries, forKey: diaryEntriesKey)
        }
        
        UserDefaults.standard.set(selectedTaskIndex, forKey: selectedTaskIndexKey)
    }
    
    private func loadData() {
        let decoder = JSONDecoder()
        
        if let savedCategories = UserDefaults.standard.data(forKey: selectedCategoriesKey),
           let decodedCategories = try? decoder.decode([TaskCategory].self, from: savedCategories) {
            selectedCategories = decodedCategories
        }
        
        if let savedTasks = UserDefaults.standard.data(forKey: dailyTasksKey),
           let decodedTasks = try? decoder.decode([DailyTask].self, from: savedTasks) {
            dailyTasks = decodedTasks
        }
        
        if let savedHistory = UserDefaults.standard.data(forKey: taskHistoryKey),
           let decodedHistory = try? decoder.decode([DailyTask].self, from: savedHistory) {
            taskHistory = decodedHistory
        }
        
        if let savedEntries = UserDefaults.standard.data(forKey: diaryEntriesKey),
           let decodedEntries = try? decoder.decode([DiaryEntry].self, from: savedEntries) {
            diaryEntries = decodedEntries
        }
        
        selectedTaskIndex = UserDefaults.standard.object(forKey: selectedTaskIndexKey) as? Int
        currentStreak = UserDefaults.standard.integer(forKey: currentStreakKey)
        bestStreak = UserDefaults.standard.integer(forKey: bestStreakKey)
    }
}



enum TaskCategory: String, Codable, CaseIterable, Identifiable {
    case mind = "Mind"
    case sport = "Sport"
    case health = "Health"
    case nutrition = "Nutrition"
    case mental = "Mental"
    
    var id: String { self.rawValue }
    
    var imageName: String {
        return self.rawValue.lowercased()
    }
}

enum TaskStatus: String, Codable {
    case notStarted = "Not Started"
    case select = "Select"
    case completed = "Completed"
    case didNotComplete = "Did Not Complete"
}

struct DailyTask: Identifiable, Codable, Hashable {
    let id: UUID
    let category: TaskCategory
    let text: String
    var status: TaskStatus
    let date: Date
    var isCompleate: Bool
    
    init(id: UUID = UUID(), category: TaskCategory, text: String, status: TaskStatus = .notStarted, date: Date = Date(), isCompleate: Bool = false) {
        self.id = id
        self.category = category
        self.text = text
        self.status = status
        self.date = date
        self.isCompleate = isCompleate
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(date)
        hasher.combine(text)
    }
    
    static func == (lhs: DailyTask, rhs: DailyTask) -> Bool {
        return lhs.id == rhs.id &&
               lhs.date == rhs.date &&
               lhs.text == rhs.text &&
               lhs.category == rhs.category &&
               lhs.status == rhs.status &&
               lhs.isCompleate == rhs.isCompleate
    }
}

class TaskService {
    static let tasks: [TaskCategory: [String]] = [
        .mind: [
            "Spend 15 minutes meditating today",
            "Learn 5 new words in a foreign language",
            "Read a chapter from a non-fiction book",
            "Solve a puzzle or brain teaser",
            "Write down three things you're grateful for"
        ],
        .sport: [
            "Do 20 push-ups and 20 sit-ups",
            "Go for a 20-minute walk or jog",
            "Stretch for 10 minutes",
            "Try a new workout routine",
            "Practice balance exercises for 5 minutes"
        ],
        .health: [
            "Drink at least 8 glasses of water today",
            "Get 7-8 hours of sleep tonight",
            "Take a break from screens for 1 hour",
            "Eat a serving of fruits and vegetables with each meal",
            "Practice deep breathing for 5 minutes"
        ],
        .nutrition: [
            "Eat a healthy breakfast with protein",
            "Try a new healthy recipe",
            "Avoid sugary drinks today",
            "Prepare a meal plan for the week",
            "Replace one processed snack with a fruit or vegetable"
        ],
        .mental: [
            "Practice mindfulness for 10 minutes",
            "Write in a journal about your feelings",
            "Do something creative today",
            "Call or message a friend or family member",
            "Take a 15-minute break to do something you enjoy"
        ]
    ]
    
    static func getRandomTask(for category: TaskCategory) -> DailyTask {
        guard let categoryTasks = tasks[category], !categoryTasks.isEmpty else {
            return DailyTask(category: category, text: "Default task for \(category.rawValue)")
        }
        
        let randomText = categoryTasks.randomElement()!
        return DailyTask(category: category, text: randomText)
    }
    
    static func getRandomTask(from categories: [TaskCategory]) -> DailyTask {
        guard !categories.isEmpty else {
            return DailyTask(category: .mind, text: "Default task")
        }
        
        let randomCategory = categories.randomElement()!
        return getRandomTask(for: randomCategory)
    }
}


struct Quote: Identifiable, Codable {
    let id: UUID
    let text: String
    let author: String
    
    init(id: UUID = UUID(), text: String, author: String) {
        self.id = id
        self.text = text
        self.author = author
    }
}

// Список цитат для приложения
class QuoteService {
    static let quotes: [Quote] = [
        Quote(text: "The only way to do great work is to love what you do.", author: "Steve Jobs"),
        Quote(text: "Believe you can and you're halfway there.", author: "Theodore Roosevelt"),
        Quote(text: "It does not matter how slowly you go as long as you do not stop.", author: "Confucius"),
        Quote(text: "Success is not final, failure is not fatal: It is the courage to continue that counts.", author: "Winston Churchill"),
        Quote(text: "The future belongs to those who believe in the beauty of their dreams.", author: "Eleanor Roosevelt"),
        Quote(text: "Don't watch the clock; do what it does. Keep going.", author: "Sam Levenson"),
        Quote(text: "The secret of getting ahead is getting started.", author: "Mark Twain"),
        Quote(text: "Quality is not an act, it is a habit.", author: "Aristotle"),
        Quote(text: "The harder I work, the luckier I get.", author: "Samuel Goldwyn"),
        Quote(text: "The best way to predict the future is to create it.", author: "Peter Drucker"),
        Quote(text: "Your time is limited, don't waste it living someone else's life.", author: "Steve Jobs"),
        Quote(text: "The only limit to our realization of tomorrow will be our doubts of today.", author: "Franklin D. Roosevelt"),
        Quote(text: "The mind is everything. What you think you become.", author: "Buddha"),
        Quote(text: "Strive not to be a success, but rather to be of value.", author: "Albert Einstein"),
        Quote(text: "The way to get started is to quit talking and begin doing.", author: "Walt Disney")
    ]
    
    static func getRandomQuote() -> Quote {
        return quotes.randomElement() ?? quotes[0]
    }
}

enum Mood: String, Codable, CaseIterable, Identifiable {
    case veryGood = "Very Good"
    case good = "Good"
    case neutral = "Neutral"
    case bad = "Bad"
    case veryBad = "Very Bad"
    
    var id: String { self.rawValue }
    
    var icon: ImageResource {
        switch self {
        case .veryBad: .veryBad
        case .bad: .bad
        case .neutral: .neutral
        case .good: .good
        case .veryGood: .veryGood
        }
    }
}

struct DiaryEntry: Identifiable, Codable {
    let id: UUID
    let text: String
    let date: Date
    let mood: Mood
    
    init(id: UUID = UUID(), text: String, date: Date = Date(), mood: Mood = .neutral) {
        self.id = id
        self.text = text
        self.date = date
        self.mood = mood
    }
}
