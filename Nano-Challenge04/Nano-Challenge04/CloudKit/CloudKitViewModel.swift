//
//  CloudKitViewModel.swift
//  Nano-Challenge04
//
//  Created by Enrique Carvalho on 10/11/23.
//

import Foundation
import CloudKit

class CloudKitViewModel: ObservableObject{
    
    private var database: CKDatabase // defining a database, which is created from the container
    private var container: CKContainer // defining a container
    
//    @Published var waterCups: [WaterCup] = [] // defining an array of watercups, which will be fetched from the database
//    @Published var ml: Float = 10 // retrieving the amount of water of the last cup
    
    init(container: CKContainer) { // initializing the struct
        self.container = container
        self.database = container.privateCloudDatabase // creating the private database from the container
        
        
//        fetchWaterCups() // won't be used anymore ;(
    }
    
    func saveCup(ml: Float){ // function to save the cup as a new record
        
        let record = CKRecord(recordType: "DailyCup") // creating a record from the type of DailyCup
        let waterCup = WaterCup(record: record, ml: ml) // creating an instance of watercup, which will receive the record as a record
        record.setValuesForKeys(waterCup.convertToDictionary()) // setting the value for the record keys
        
        // saving to database
        self.database.save(record) { returnedRecord, returnedError in
            if let error = returnedError{ // safely unwrapping any errors
                print(error)
            } else {
                if let record = returnedRecord{ // debugging in case of success on save attempt.
                    print("Saved - \(record)")
                }
            }
        }
    }
    
//    func aaa() async {
//        fetchWaterCups()
//        guard let ml = waterCups.last?.ml else {
//            print("a")
//            return
//        }
//        self.ml = ml
//    }
    
//    func fetchWaterCups(){
//        let predicate = NSPredicate(value: true)
//        
//        let query = CKQuery(recordType: "DailyCup", predicate: predicate)
//        
//        let queryOperation = CKQueryOperation(query: query)
//        
//        queryOperation.recordMatchedBlock = { returnedRecID, returnedRes in
//            switch returnedRes{
//            case .success(let record):
//                guard let ml = record.value(forKey: "ml") as? Float, let date = record.value(forKey: "date") as? Date else { return }
//                let cup = WaterCup(record: record, ml: ml, date: date)
//                DispatchQueue.main.async{
//                    self.waterCups.append(cup)
//                }
//                
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//        
//        CKContainer.default().privateCloudDatabase.add(queryOperation)
//    }
    
//    func del(indexSet: IndexSet){
//        guard let index = indexSet.first else { return }
//        
//        let waterCup = waterCups[index]
//        let record = waterCup.record
//        
//        guard let record = record else { return }
//        
//        CKContainer(identifier: "iCloud.SwiftUI.API.Learning").privateCloudDatabase.delete(withRecordID: record.recordID) { [weak self] _, _ in
//            DispatchQueue.main.async {
//                self?.waterCups.remove(at: index)
//            }
//        }
//    }
    
}
