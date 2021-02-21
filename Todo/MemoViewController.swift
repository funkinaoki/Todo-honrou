//
//  MemoViewController.swift
//  Todo
//
//  Created by 八幡尚希 on 2021/02/18.
//

import UIKit

class MemoViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var textView: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var dateButton: UIButton!
    
                    
    @IBOutlet weak var stackShortConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var stackLongConstraint: NSLayoutConstraint!
    
    var addContext: String!
    
    var addDate: String!
    
    
    let userDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.delegate = self
        
        textView.placeholder = "新規メモを入力"
        
        datePicker.isHidden = true
        
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
        formatter.dateFormat = "yyyy/MM/dd"
        addDate = formatter.string(from: sender.date)
    }
    
    //キーボード
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textView.resignFirstResponder()
        return true
    }
    
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func date(_ sender: Any) {
        //datePickerがなかったら
        if datePicker.isHidden == true{
            //datePickerを出して初期値を設定
            datePicker.isHidden = false
            addDate = DateUtils.stringFromDate(date: datePicker.date, format: "yyyy/MM/dd")
            //ボタンはremovedateにする
            dateButton.setTitle("Remove Date", for: .normal)
            dateButton.setTitleColor(UIColor(red: 1, green: 59 / 255, blue: 48 / 255, alpha: 1) , for: .normal)
            NSLayoutConstraint.deactivate([stackShortConstraint])
            NSLayoutConstraint.activate([stackLongConstraint])

        //datePickerがあったらこのボタンが押された時に
        } else {
            //datePickerをなくし、editDateには念のためnilを入れる
            datePicker.isHidden = true
            addDate = nil
            //ボタンをaddDateにする
            dateButton.setTitle("Add Date", for: .normal)
            dateButton.setTitleColor(UIColor(red: 0, green: 122 / 255, blue: 1, alpha: 1), for: .normal)
            
            NSLayoutConstraint.deactivate([stackLongConstraint])
            NSLayoutConstraint.activate([stackShortConstraint])
            
            
        }
    }

  

}
