//
//  EditViewController.swift
//  contact
//
//  Created by Nguyễn Công Thư on 26/08/2022.
//

import UIKit

class EditViewController: UIViewController {
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var headerView: UIView!
//    let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 50, height: 50))
    
    let label = UILabel()
    var person = Person(id: "", name: "", contact: nil, tel:[], number: [], emailAddress: (nil, nil), birthday: "" )
    
    var names: [String] = ["Tí",
                             "Tèo",
                             "Hùng",
                             "Lam",
                             "Thuỷ",
                             "Tuấn",
                             "Trung",
                             "Hạnh"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("person: \(person)")
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableview.delegate = self
        tableview.dataSource = self
        tableview.tableHeaderView = headerView
        self.navigationController?.isNavigationBarHidden = true
    }
}

extension EditViewController : UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = names[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected cell: \(names[indexPath.row])")
    }
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//            label.frame = CGRect.init(x: 5, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
//            label.text = "Notification Times"
//            label.font = .systemFont(ofSize: 16)
//            label.textColor = .yellow
//            label.backgroundColor = .red
//            headerView.addSubview(label)
//
//            return headerView
//        }
    
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let y = 200 - (scrollView.contentOffset.y + 200)
            let h = max(60, y)
            let rect = CGRect(x: 5, y: 5, width: view.bounds.width, height: h)
            imageview.frame = rect
            print(label.frame)
        }

}
