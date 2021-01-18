//
//  Model.swift
//  YangMemo
//
//  Created by 양원석 on 2021/01/16.
//

import Foundation

class Memo {
    var content: String
    var insertDate: Date
    
    init(content: String) {
        self.content = content
        insertDate = Date()
    }
    
    static var dummyMemoList = [
        Memo(content: "Lorem Ipsum"),
        Memo(content: "Dolar Amet")
    ]
}
