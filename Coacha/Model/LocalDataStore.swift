//
//  LocalDataStore.swift
//  Coacha
//
//  Created by Anthony Šimek on 04.03.2022.
//

import Foundation
import Combine
import CoreData

class LocalDataStore: NSObject, ObservableObject {
    var allSportActivity = CurrentValueSubject<[SportActivityCD], Never>([])
    private let sportActivityFetchController: NSFetchedResultsController<SportActivityCD>
    
    override init() {
        let fetchRequest = SportActivityCD.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: C.dataStore.key.sportActivity.id, ascending: true)] //has to have one, fatal error
        
        sportActivityFetchController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: PersistenceController.shared.container.viewContext,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        
        super.init()
        
        sportActivityFetchController.delegate = self
    }
    
    func performFetchOfSportActivity() {
        do {
            try sportActivityFetchController.performFetch()
            debugPrint("LOCAL_STORAGE/performFetchOfSportActivity: Success")
            allSportActivity.value = sportActivityFetchController.fetchedObjects ?? []
        } catch {
            debugPrint("LOCAL_STORAGE/performFetchOfSportActivity: Error \(error.localizedDescription)")
        }
    }
    
    func add(sportActivity: SportActivity, completion: @escaping (Result<SportActivity, Error>) -> Void) {
        let newSportActivityCD = SportActivityCD(context: PersistenceController.shared.container.viewContext)
        newSportActivityCD.sportActivity = sportActivity
        
        self.saveContext { result in
            switch result {
                case .success(_):
                    completion(.success(sportActivity))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    func delete(id: UUID, completion: @escaping (Result<UUID, Error>) -> Void) {
        guard let saToBeRemoved = allSportActivity.value.first(where: { $0.id == id }) else {
            debugPrint("LOCAL_STORAGE/delete: Error: ID Not found")
            return
        }
        
        PersistenceController.shared.container.viewContext.delete(saToBeRemoved)
        
        self.saveContext { result in
            switch result {
                case .success(_):
                    completion(.success(id))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    private func saveContext(completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try PersistenceController.shared.container.viewContext.save()
            debugPrint("LOCAL_STORAGE/saveContext: Success")
            completion(.success(()))
        } catch {
            debugPrint("LOCAL_STORAGE/saveContext: Error: \(error.localizedDescription)")
            completion(.failure(error))
        }
    }
}

extension LocalDataStore: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let allSportActivity = controller.fetchedObjects as? [SportActivityCD] else { return }
        debugPrint("LOCAL_STORAGE/controllerDidChangeContent: Updating")
        self.allSportActivity.value = allSportActivity
    }
}

