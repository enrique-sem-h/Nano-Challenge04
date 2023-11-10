//
//  CloudKitViewModel.swift
//  Nano-Challenge04
//
//  Created by Enrique Carvalho on 10/11/23.
//

import Foundation
import CloudKit

class CloudKitViewModel: ObservableObject{
    
    private var database: CKDatabase
    private var container: CKContainer
    
    @Published var waterCups: [WaterCup] = []
    @Published var ml: Float = 10
    
    init(container: CKContainer) {
        self.container = container
        self.database = container.privateCloudDatabase
        
        fetchWaterCups()
    }
    
    func saveCup(ml: Float){
        
        let record = CKRecord(recordType: "DailyCup")
        let waterCup = WaterCup(record: record, ml: ml)
        record.setValuesForKeys(waterCup.convertToDictionary())
        
        // saving to database
        self.database.save(record) { returnedRecord, returnedError in
            if let error = returnedError{
                print(error)
            } else {
                if let record = returnedRecord{
                    print("Saved - \(record)")
                }
            }
        }
    }
    
    func aaa() async {
        fetchWaterCups()
        guard let ml = waterCups.last?.ml else {
            print("a")
            return
        }
        self.ml = ml
    }
    
    func fetchWaterCups(){
        let predicate = NSPredicate(value: true)
        
        let query = CKQuery(recordType: "DailyCup", predicate: predicate)
        
        let queryOperation = CKQueryOperation(query: query)
        
        queryOperation.recordMatchedBlock = { returnedRecID, returnedRes in
            switch returnedRes{
            case .success(let record):
                guard let ml = record.value(forKey: "ml") as? Float, let date = record.value(forKey: "date") as? Date else { return }
                let cup = WaterCup(record: record, ml: ml, date: date)
                DispatchQueue.main.async{
                    self.waterCups.append(cup)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        CKContainer.default().privateCloudDatabase.add(queryOperation)
    }
    
    func del(indexSet: IndexSet){
        guard let index = indexSet.first else { return }
        
        let waterCup = waterCups[index]
        let record = waterCup.record
        
        guard let record = record else { return }
        
        CKContainer(identifier: "iCloud.SwiftUI.API.Learning").privateCloudDatabase.delete(withRecordID: record.recordID) { [weak self] _, _ in
            DispatchQueue.main.async {
                self?.waterCups.remove(at: index)
            }
        }
    }
    
    
}
