//
//  CarsListVC.swift
//  Speedometer
//
//  Created by Tom Odler on 21.01.17.
//  Copyright © 2017 Tom. All rights reserved.
//

import UIKit
import CoreData

class CarsListVC: UIViewController, NSFetchedResultsControllerDelegate, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tbvHeight: NSLayoutConstraint!
    var height : CGFloat = 150
    var fetchController : NSFetchedResultsController<Car>!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initFetch()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = fetchController.sections{
            return sections.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchController.sections {
            let sectionsInfo = sections[section]
            return sectionsInfo.numberOfObjects
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "carsCell", for: indexPath) as! CarsCell
        self.configureCell(cell: cell, at: indexPath as NSIndexPath)
        return cell
    }
    
    func configureCell(cell:CarsCell, at:NSIndexPath){
        let myCar : Car = fetchController.object(at: at as IndexPath)
        cell.configureCell(car: myCar)
    }

    
    func initFetch(){
        let fetchRequest : NSFetchRequest<Car> = Car.fetchRequest()
        let descriptor = NSSortDescriptor.init(key: "brand", ascending: true)
        fetchRequest.sortDescriptors = [descriptor]
        
        let controller = NSFetchedResultsController.init(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext , sectionNameKeyPath: nil, cacheName: nil)
    
        do{
            try controller.performFetch()
            fetchController = controller
            
        } catch {
            let myError = error as NSError
            print("\(myError)")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let myCar = fetchController.object(at: indexPath)
        self.performSegue(withIdentifier: "carDetail", sender: myCar)
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.endUpdates()
        
        let myNumber = controller.fetchedObjects?.count
        tbvHeight.constant = CGFloat(myNumber! * 150)
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            if let indexPath = indexPath{
                tableView .deleteRows(at: [indexPath], with: .fade)
            }
            break
        case .insert:
            if let myIP = newIndexPath {
                tableView.insertRows(at: [myIP], with: .fade)
            }
            break
        case .move:
            if let indexPath = indexPath{
                tableView.deleteRows(at: [indexPath], with: .fade)
                
                if let myNewIP = newIndexPath{
                    tableView.insertRows(at: [myNewIP], with: .fade)
                }
            }
            break
            
        case .update:
            if let indexPath = indexPath {
                let cell = tableView.cellForRow(at: indexPath ) as! CarsCell
                self.configureCell(cell: cell, at: indexPath as NSIndexPath)
            }
            break
        }
    }
    
    @IBAction func addTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "carDetail", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller : CarDetailVC = segue.destination as! CarDetailVC
        controller.myCar = sender as! Car?
    }
    

}
