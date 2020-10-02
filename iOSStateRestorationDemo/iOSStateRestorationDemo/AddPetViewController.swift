//
//  AddPetViewController.swift
//  iOSStateRestorationDemo
//
//  Created by GSingh on 01/10/20.
//

import UIKit

class AddPetViewController: UIViewController {
    @IBOutlet weak var petNameTxtField: UITextField!
    @IBOutlet weak var petAgeTxtField: UITextField!
    
    override  func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnSaveAction(){
        guard let petName = self.petNameTxtField.text, petName.count > 0 else {
            self.showErrorAlert(message: "Please enter pet name.")
            return }
        
        guard let petAge = self.petAgeTxtField.text, petAge.count > 0 else {
        self.showErrorAlert(message: "Please enter pet age.")
        return }
        
        var dictionary: [AnyHashable:String] = [:]
        dictionary["name"] = petName
        dictionary["age"] = petAge
        if var petsArray = UserDefaults.standard.array(forKey: "PetsArray") as? [Dictionary<AnyHashable, String>]
        {
            petsArray.append(dictionary)
            UserDefaults.standard.set(petsArray, forKey: "PetsArray")
        }
        else{
            UserDefaults.standard.set([dictionary], forKey: "PetsArray")
        }
        
        self.showErrorAlert(message: "Pet saved successfully.")
        self.petNameTxtField.text = ""
        self.petAgeTxtField.text = ""
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension AddPetViewController{
    
    func showErrorAlert(message: String){
        let alert = UIAlertController.init(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    override func encodeRestorableState(with coder: NSCoder) {
        if petAgeTxtField.isFirstResponder{
            coder.encode(Int32(2), forKey: "EditField")
        }
        
        else if petNameTxtField.isFirstResponder{
            coder.encode(Int32(1), forKey: "EditField")
        }
        coder.encode(petNameTxtField.text, forKey: "nameText")
        coder.encode(petAgeTxtField.text, forKey: "ageText")
        super.encodeRestorableState(with: coder)
    }
    
    override func decodeRestorableState(with coder: NSCoder) {
        let editedField = coder.decodeInteger(forKey: "EditField")
        if let nameText = coder.decodeObject(forKey: "nameText") as? String{
            petNameTxtField.text = nameText
        }
        
        if let ageText = coder.decodeObject(forKey: "ageText") as? String{
            petAgeTxtField.text = ageText
        }
        
        if editedField == 1{
            petNameTxtField.becomeFirstResponder()
        }
        else{
            petAgeTxtField.becomeFirstResponder()
        }
        super.decodeRestorableState(with: coder)
    }
}
