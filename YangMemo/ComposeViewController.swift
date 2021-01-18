//
//  ComposeViewController.swift
//  YangMemo
//
//  Created by 양원석 on 2021/01/18.
//

import UIKit

class ComposeViewController: UIViewController {
    
    // 새 메모의 Cancel버튼 기능 활성
    // modal형식을 닫을 때는 dismiss메서드 사용.
    // animated: 애니메이션을 보여줄거면 true 아니면 false
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var memoTextView: UITextView!
    
    @IBAction func save(_ sender: Any) {
        
        guard let memo = memoTextView.text,
            memo.count > 0 else {
            alert(message: "메모를 입력하세요.")
            return
        }
        
        let newMemo = Memo(content: memo)
        Memo.dummyMemoList.append(newMemo)
        
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
