//
//  CarDetailVC.swift
//  Speedometer
//
//  Created by Tom Odler on 22.01.17.
//  Copyright © 2017 Tom. All rights reserved.
//

import UIKit

class CarDetailVC: UIViewController {
    @IBOutlet weak var brandTf: UITextField!
    @IBOutlet weak var modelTf: UITextField!
    @IBOutlet weak var yearTf: UITextField!
    @IBOutlet weak var engineCapacityTf: UITextField!
    @IBOutlet weak var fuelTf: UITextField!
    @IBOutlet weak var consumptionTf: UITextField!
    @IBOutlet weak var tripsTbv: UITableView!
    
    var myCar : Car?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let existingCar = myCar{
            brandTf.text = existingCar.brand
            modelTf.text = existingCar.model
            yearTf.text = "\(existingCar.year)"
            engineCapacityTf.text = "\(existingCar.engineCapacity)"
            fuelTf.text = existingCar.fuel
            consumptionTf.text = "\(existingCar.consumption)"
        } else {
            myCar = CoreDataManager.sharedInstance.createNewCar()
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        myCar?.brand = brandTf.text
        myCar?.model = modelTf.text
        myCar?.year = 2001//Int16(yearTf.text!)!
        myCar?.engineCapacity = 1.6//(engineCapacityTf.text?.toDouble())!
        myCar?.fuel = "benzin"//fuelTf.text
        myCar?.consumption = 8.5//(consumptionTf.text?.toDouble())!
        
        appD.saveContext()
        _ = self.navigationController?.popViewController(animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

    extension String {
        func toDouble() -> Double? {
            return NumberFormatter().number(from: self)?.doubleValue
        }
    }
