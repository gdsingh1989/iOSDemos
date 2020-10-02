//
//  ViewController.swift
//  iOSStateRestorationDemo
//
//  Created by GSingh on 01/10/20.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var lblNoPets: UILabel!
    @IBOutlet weak var tblPets: UITableView!
    var petsArray : [Dictionary<AnyHashable, String>] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        if let petArray = UserDefaults.standard.object(forKey: "PetsArray") as? [Dictionary<AnyHashable, String>]{
            petsArray = petArray
            self.tblPets.reloadData()
        }
        guard petsArray.count > 0 else {
            lblNoPets.isHidden = false
            tblPets.isHidden = true
            return
        }
        super.viewWillAppear(animated)
    }

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "petTableIdentifier")
        let dict = petsArray[indexPath.row]
        cell?.textLabel?.text = dict["name"]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

