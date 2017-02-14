//
//  CoreDataManager.swift
//  Speedometer
//
//  Created by Tom Odler on 07.02.17.
//  Copyright © 2017 Tom. All rights reserved.
//

import UIKit
import CoreData

let appD = UIApplication.shared.delegate as! AppDelegate
let managedObjectContext = appD.persistentContainer.viewContext

class CoreDataManager {
    
    static let sharedInstance = CoreDataManager()
    
    private init(){
        print("coreDataManager initialized")
    }
    
    func createNewCar() -> Car {
        let newCar = Car(entity: NSEntityDescription.entity(forEntityName: "Car", in: managedObjectContext)!, insertInto: managedObjectContext)
        return newCar
    }
    
    

    
}
