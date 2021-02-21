//
//  Todo.swift
//  Todo
//
//  Created by 八幡尚希 on 2021/02/21.
//

import UIKit

class Todo {
    
    var memo: String!
    var date: String!
    var check: Bool!
    
    init(memo: String, date: String, check: Bool) {
        self.memo = memo
        self.date = date
        self.check = check
    }
}
