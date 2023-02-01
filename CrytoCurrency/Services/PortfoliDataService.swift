//
//  PortfoliDataService.swift
//  CrytoCurrency
//
//  Created by Gagan Vishal  on 2023/01/30.
//

import Foundation
import CoreData

class PortfoliDataService {
    private let persistantContainer: NSPersistentContainer
    private let persistantContainerName: String = "PortfolioContainer"
    private let entityName: String = "PortfolioEntity"
    private lazy var context: NSManagedObjectContext = {
         persistantContainer.viewContext
    }()
    
    @Published var savedEntities: [PortfolioEntity] = []
    // MARK: - init
    init() {
        persistantContainer = NSPersistentContainer(name: persistantContainerName)
        persistantContainer.loadPersistentStores { _, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.fetchPortfolios()
            }
        }
    }
    
    // MARK: - Fetch all portfolio's
    func fetchPortfolios() {
        let fetchRequest = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        do {
            savedEntities = try context.fetch(fetchRequest)
        } catch let error {
            print(error.localizedDescription)
        }
    }
}

extension PortfoliDataService {
    func updateEntity(amount: Double, coin: CryptoModel) {
        if let savedEntity = savedEntities.first(where: { $0.coinID == coin.id }) {
            if amount > 0 {
                update(amount: amount, entity: savedEntity)
            } else {
                delete(entity: savedEntity)
            }
        } else {
            add(model: coin, amount: amount)
        }
    }
}

// MARK: - Private Section
extension PortfoliDataService {
    // MARK: - add into portfolio
    private func add(model: CryptoModel, amount: Double) {
        let entity = PortfolioEntity(context: context)
        entity.coinID = model.id
        entity.amount = amount
        applyChanges()
    }
    
    // MARK: - Save entity
    private func saveEntity() {
        do {
            try context.save()
        } catch let error {
            print("error : \(error.localizedDescription)")
        }
    }
    
    // MARK: - Update
    private func update(amount: Double, entity: PortfolioEntity) {
        entity.amount = amount
        applyChanges()
    }
    
    // MARK: - Delte
    private func delete(entity: PortfolioEntity) {
        context.delete(entity)
        applyChanges()
    }
    
    // MARK: - Apple changes
    private func applyChanges() {
        saveEntity()
        fetchPortfolios()
    }
}
