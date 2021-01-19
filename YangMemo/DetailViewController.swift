//
//  DetailViewController.swift
//  YangMemo
//
//  Created by 양원석 on 2021/01/18.
//

import UIKit

// 보기 화면
class DetailViewController: UIViewController {
    
    @IBOutlet weak var memoTableView: UITableView!
    
    // 값이 없기 때문에 옵셔널로 선언
    // 이전화면에서 저장한 메모가 저장됨
    var memo: Memo?
    
    let formatter: DateFormatter = {
        let f = DateFormatter()
        f.dateStyle = .long
        f.timeStyle = .none
        f.locale = Locale(identifier: "Ko_kr")
        return f
    }()
    
    // 공유하기 (Apple에서 기본으로 제공해주는 기능을 사용)
    @IBAction func share(_ sender: UIBarButtonItem) {
        
        guard let memo = memo?.content else { return }
        
        let vc = UIActivityViewController(activityItems: [memo], applicationActivities: nil)
        
        if let pc = vc.popoverPresentationController {
            pc.barButtonItem = sender
        }
        present(vc, animated: true, completion: nil)
    }
    
    // 편집상태에서 삭제 버튼 구현
    @IBAction func deleteMemo(_ sender: Any) {
        // 삭제 확인 alert 띄우기
        let alert = UIAlertController(title: "삭제 확인", message: "메모를 삭제할까요?", preferredStyle: .alert)
        // 삭제 확인 alert에서 삭제버튼을 구현하고, .destructive로 빨갛게 만들기
        let okAction = UIAlertAction(title: "삭제", style: .destructive) { [weak self] (action) in
            DataManager.shared.deleteMemo(self?.memo)
            // navigation에 접근하여 popView
            self?.navigationController?.popViewController(animated: true)
        }
        // 삭제확인 alert에 okAction버튼 추가
        alert.addAction(okAction)
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    // 첫번째 뷰 컨트롤러로 메모를 전달
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination.children.first as?
            ComposeViewController {
            vc.editTarget = memo
        }
    }
    
    // Notification Token 추가
    var token: NSObjectProtocol?
    
    deinit {
        if let token = token {
            NotificationCenter.default.removeObserver(token)
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        token = NotificationCenter.default.addObserver(forName: ComposeViewController.memoDidChange, object: nil, queue: OperationQueue.main, using: { [weak self] (noti) in self?.memoTableView.reloadData()
            
        })
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

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            // 첫번째 셀을 생성해 cell에 저장해줌
            let cell = tableView.dequeueReusableCell(withIdentifier: "memoCell", for: indexPath)
            
            cell.textLabel?.text = memo?.content
            
            return cell
        case 1:
            // 첫번째 셀을 생성해 cell에 저장해줌
            let cell = tableView.dequeueReusableCell(withIdentifier: "dateCell", for: indexPath)
            
            cell.textLabel?.text = formatter.string(for: memo?.insertDate)
            
            return cell
        default:
            fatalError()
        }
    }
    
    
}
