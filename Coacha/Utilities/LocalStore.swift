//
//  LocalStore.swift
//  Coacha
//
//  Created by Anthony Šimek on 04.03.2022.
//

import Foundation
import Combine
import CoreData

class LocalStore: NSObject, ObservableObject {
    var allSportActivity = CurrentValueSubject<[SportActivityCD], Never>([])
    private let sportActivityFetchController: NSFetchedResultsController<SportActivityCD>
    
    static let shared: LocalStore = LocalStore()
    
    private override init() {
        let fetchRequest = SportActivityCD.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)] //has to have one, fatal error
        
        sportActivityFetchController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: PersistenceController.shared.container.viewContext,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        
        super.init()
        
        sportActivityFetchController.delegate = self
        
        do {
            try sportActivityFetchController.performFetch()
            allSportActivity.value = sportActivityFetchController.fetchedObjects ?? []
        } catch {
            debugPrint("LOCAL_STORAGE/init: Error \(error.localizedDescription)")
        }
    }
    
    func add() {
        let newSportActivityCD = SportActivityCD(context: PersistenceController.shared.container.viewContext)
        newSportActivityCD.sportActivity = SportActivity(name: "TEST_CD", place: "PLACE_CD", duration: 69)
        
        do {
            try PersistenceController.shared.container.viewContext.save()
            debugPrint(">>> SAVED")
        } catch {
            debugPrint(">>> ERROR: \(error.localizedDescription)")
        }
    }
    
//    func update(withID: id: UUID) {
//
//    }
//
//    func delete(id: UUID) {
//
//    }
}

extension LocalStore: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let allSportActivity = controller.fetchedObjects as? [SportActivityCD] else { return }
        debugPrint("LOCAL_STORAGE/controllerDidChangeContent: Updating")
        self.allSportActivity.value = allSportActivity
    }
}

