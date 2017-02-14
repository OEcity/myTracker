//
//  SettingsVC.swift
//  Speedometer
//
//  Created by Tom Odler on 21.01.17.
//  Copyright © 2017 Tom. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var tbvStrings : [String] = ["Cars", "Options"]
    var cellHeight : CGFloat = 70
    
    @IBOutlet weak var tbvHeight: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        tbvHeight.constant = CGFloat(tbvStrings.count * Int(cellHeight))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.title = "Settings"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tbvStrings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath)
        let label : UILabel = cell.contentView.subviews.first as! UILabel
        
        label.text = tbvStrings[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.performSegue(withIdentifier: "cars", sender: nil)
            break
        case 1:
            self.performSegue(withIdentifier: "options", sender: nil)
            break
        default:
            break
        }
    }
}
