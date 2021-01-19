//
//  DataManager.swift
//  YangMemo
//
//  Created by 양원석 on 2021/01/19.
//

import Foundation
import CoreData

class DataManager {
    static let shared = DataManager()
    private init() {
        //Singleton 싱글톤
         
    }
    
    var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    var memoList = [Memo]()
    
    // 데이터 불러오기
    func fetchMemo() {
        let request: NSFetchRequest<Memo> = Memo.fetchRequest()
        
        let sortByDateDesc = NSSortDescriptor(key: "insertDate", ascending: false)
        request.sortDescriptors = [sortByDateDesc]
        
        do {
            memoList = try mainContext.fetch(request)
        } catch {
            print(error)
        }
        
    }
    
    func addNewMemo(_ memo: String?) {
        // 데이터베이스 클래스인 Memo를 불러옴
        let newMemo = Memo(context: mainContext)
        newMemo.content = memo
        // 현재 날짜 저장
        newMemo.insertDate = Date()
        
        // 배열 가장 앞 부분에 출력함. (append는 뒤에 함)
        memoList.insert(newMemo, at: 0)
        saveContext()
    }
    
    // 삭제 메소드
    func deleteMemo(_ memo: Memo?) {
        // 실제로 메모가 전달된 경우에만 삭제
        if let memo = memo {
            // 실제로 메모가 삭제됨
            mainContext.delete(memo)
            saveContext()
        }
    }
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "YangMemo")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
