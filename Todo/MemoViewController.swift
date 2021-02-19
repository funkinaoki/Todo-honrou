//
//  MemoViewController.swift
//  Todo
//
//  Created by 八幡尚希 on 2021/02/18.
//

import UIKit

class MemoViewController: UIViewController {
    
    @IBOutlet var textView: UITextField!
    
    var addContext: String!
    
    var addDate: String!
    
    let userDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func toMain() {
        performSegue(withIdentifier: "toMainView", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMainView" {
            let ViewController = segue.destination as! ViewController
            ViewController.addContext = self.addContext
            if addDate != nil{
                ViewController.addDate = self.addDate
            }else{
                ViewController.addDate = ""
            }
        }
    }
    
    
    @IBAction func save() {
        addContext = textView.text
        toMain()
    }
    
    
    @IBAction func changeDate(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        
        addDate = formatter.string(from: sender.date)
        
        
    }
    
    
    
    
    
    
    
    
    

  

}
