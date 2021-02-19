//
//  EditViewController.swift
//  Todo
//
//  Created by 八幡尚希 on 2021/02/19.
//

import UIKit

class EditViewController: UIViewController {
    
    @IBOutlet var textView: UITextView!
    
    var editMemo: String!
    
    var editDate: String!
    
    var editArrayNumber: Int!

    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.text = editMemo
        print(editMemo!)
        
        //もし時間が設定されていたら時刻を表示する
        if editDate != ""{
        let date = DateUtils.dateFromString(string: editDate, format: "yyyy/MM/dd HH:mm:ss")
        print(date)
        datePicker.date = date
        }
        
    }
    

    @IBAction func save(_ sender: Any) {
        toMain()
    }
    
    @IBAction func changeDate(_ sender: UIDatePicker) {
        editDate = DateUtils.stringFromDate(date: sender.date, format: "yyyy/MM/dd HH:mm:ss")
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
    
    class DateUtils {
        class func dateFromString(string: String, format: String) -> Date {
            let formatter: DateFormatter = DateFormatter()
            formatter.calendar = Calendar(identifier: .gregorian)
            formatter.dateFormat = format
            return formatter.date(from: string)!
        }
        
        class func stringFromDate(date: Date, format: String) -> String {
            let formatter: DateFormatter = DateFormatter()
            formatter.calendar = Calendar(identifier: .gregorian)
            formatter.dateFormat = format
            return formatter.string(from: date)
        }

    }
    

}
