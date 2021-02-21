//
//  EditViewController.swift
//  Todo
//
//  Created by 八幡尚希 on 2021/02/19.
//

import UIKit

class EditViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var textView: UITextField!
    
    var editMemo: String!
    
    var editDate: String!
    
    var editArrayNumber: Int!

    @IBOutlet weak var dateButton: UIButton!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.delegate = self
        
        textView.text = editMemo
    
        
        //もし日にちが設定されていたら日にちを表示する&addDateをdeleteDateにする
        if editDate != ""{
            //元々設定したdateを表示
            let date = DateUtils.dateFromString(string: editDate, format: "yyyy/MM/dd")
            print(date)
            datePicker.date = date
            //addDateをremoveDate
            dateButton.setTitle("Remove Date", for: .normal)
            dateButton.setTitleColor(UIColor(red: 1, green: 59 / 255, blue: 48 / 255, alpha: 1) , for: .normal)
        } else {
            //date自体を非表示
            datePicker.isHidden = true
        }
        
    }
    

    @IBAction func save(_ sender: Any) {
        editMemo = textView.text
        toMain()
    }
    
    @IBAction func changeDate(_ sender: UIDatePicker) {
        editDate = DateUtils.stringFromDate(date: sender.date, format: "yyyy/MM/dd")
    }
    
    @IBAction func date(_ sender: Any) {
        //datePickerがなかったら
        if datePicker.isHidden == true{
            //datePickerを出して初期値を設定
            datePicker.isHidden = false
            editDate = DateUtils.stringFromDate(date: datePicker.date, format: "yyyy/MM/dd")
            //ボタンはremovedateにする
            dateButton.setTitle("Remove Date", for: .normal)
            dateButton.setTitleColor(UIColor(red: 1, green: 59 / 255, blue: 48 / 255, alpha: 1) , for: .normal)
        //datePickerがあったらこのボタンが押された時に
        } else {
            //datePickerをなくし、editDateには念のためnilを入れる
            datePicker.isHidden = true
            editDate = nil
            //ボタンをaddDateにする
            dateButton.setTitle("Add Date", for: .normal)
            dateButton.setTitleColor(UIColor(red: 0, green: 122 / 255, blue: 1, alpha: 1), for: .normal)
        }
    }
    
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func toMain() {
        performSegue(withIdentifier: "toMainView", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMainView" {
            let ViewController = segue.destination as! ViewController
            ViewController.editMemo = self.editMemo
            ViewController.editArrayNumber = self.editArrayNumber
            if editDate != nil{
                ViewController.editDate = self.editDate
            }else{
                ViewController.editDate = ""
            }
        }
    }
    
    //キーボード
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textView.resignFirstResponder()
        return true
    }
    

}
