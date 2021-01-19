//
//  ComposeViewController.swift
//  YangMemo
//
//  Created by 양원석 on 2021/01/18.
//

import UIKit

class ComposeViewController: UIViewController {
    
    // 보기화면에서 편집버튼을 클릭하면 editTarget으로 전달
    var editTarget: Memo?
    
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
        
//        let newMemo = Memo(content: memo)
//        Memo.dummyMemoList.append(newMemo)
        
        // 편집 모드라면.
        if let target = editTarget {
            target.content = memo
            DataManager.shared.saveContext()
            NotificationCenter.default.post(name: ComposeViewController.memoDidChange, object: nil)
        } else {
            // 새로운 메모 저장
            DataManager.shared.addNewMemo(memo)
            
            NotificationCenter.default.post(name: ComposeViewController.newMemoDidInsert, object: nil)
        }
        
        // 라디오 방송 브로드캐스팅과 같음
       
        
        dismiss(animated: true, completion: nil)
    }
    
    // viewController가 시작된 후 호출됨
    override func viewDidLoad() {
        super.viewDidLoad()

        if let memo = editTarget {
            navigationItem.title = "메모 편집"
            memoTextView.text = memo.content
        } else {
            navigationItem.title = "새 메모"
            memoTextView.text = " "
        }
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

extension ComposeViewController {
    static let newMemoDidInsert = Notification.Name(rawValue: "newMemoDidInsert")
    static let memoDidChange = Notification.Name(rawValue: "memoDidChange")
}
