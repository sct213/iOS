//
//  UIViewController+Alert.swift
//  YangMemo
//
//  Created by 양원석 on 2021/01/18.
//

import UIKit

// 경고창 만들기
extension UIViewController {
    func alert(title: String = "알림", message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        
        alert.addAction(okAction)
        
        present(alert, animated: true,  completion: nil)
    }
}
