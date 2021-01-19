//
//  MemoListTableViewController.swift
//  YangMemo
//
//  Created by 양원석 on 2021/01/16.
//

/*MARK: - 테이블 뷰 만드는 순서
    1. 테이블 뷰 배치
    2. 프로토타입 셀 디자인
    3. 셀 아이덴티파이어 지정
    4. 데이터 소스, 델리게이트 연결
    5. 데이터 소스, 델리게이트 구현
 
 */
import UIKit

class MemoListTableViewController: UITableViewController {

    let formatter: DateFormatter = {
        let f = DateFormatter()
        f.dateStyle = .long
        f.timeStyle = .none
        f.locale = Locale(identifier: "Ko_kr")
        return f
    }()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // indexPath를 통해 몇번째 cell인지 확인 가능
        if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell){
            // 세그웨이로 연결된 화면에 데이터를 전달할때 구현하는 기본적인 기능
            if let vc = segue.destination as? DetailViewController {
                vc.memo = DataManager.shared.memoList[indexPath.row]
            }
            
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 데이터가 채워짐
        DataManager.shared.fetchMemo()
        // 앞을 기반으로 테이블에 업데이트됨
        tableView.reloadData()
        
//        // 최신 데이터로 업데이트함
//        tableView.reloadData()
//        // 로그 출력
//        print(#function)
    }
    
    var token: NSObjectProtocol?
    
    deinit {
        if let token = token {
            NotificationCenter.default.removeObserver(token)
        }
    }
    
    // view가 호출된 후 자동으로 실행하는 func
    override func viewDidLoad() {
        super.viewDidLoad()
        
        token = NotificationCenter.default.addObserver(forName: ComposeViewController.newMemoDidInsert, object: nil, queue: OperationQueue.main) { [weak self] (noti) in
            
            self?.tableView.reloadData()
     }
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return DataManager.shared.memoList.count
        
    }
    
    // 제일 중요한 메서드
    // indexPath: 특정위치를 표현할 때 사용
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // 테이블 뷰에서 몇번째 값인지 확인 가능
        let target = DataManager.shared.memoList[indexPath.row]
        // 원하는 문자열 저장
        cell.textLabel?.text = target.content
        //
        cell.detailTextLabel?.text = formatter.string(for: target.insertDate)

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
