//
//  DetailViewController.swift
//  YangMemo
//
//  Created by 양원석 on 2021/01/18.
//

import UIKit

class DetailViewController: UIViewController {
    
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
