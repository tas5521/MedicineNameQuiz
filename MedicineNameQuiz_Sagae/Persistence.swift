//
//  Persistence.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/09/28.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<5 {
            // カスタムの薬のダミーデータ
            let customMedicine = CustomMedicine(context: viewContext)
            customMedicine.brandName = "商品名"
            customMedicine.genericName = "一般名"
            // 問題のダミーデータ
            // Question型の空の集合を作成
            var questionSet: Set<Question> = []
            let questions = Question(context: viewContext)
            questions.brandName = "商品名"
            questions.genericName = "一般名"
            questions.category = "内用薬"
            questionSet.insert(questions)

            let questionList = QuestionList(context: viewContext)
            questionList.questions = NSSet()
            questionList.createdDate = Date()
            questionList.listName = "リスト名"
            questionList.questions = questionSet as NSSet
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "MedicineNameQuiz_Sagae")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
