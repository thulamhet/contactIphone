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
    @IBOutlet weak var imageWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    //    let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 50, height: 50))
    func imageWith (name: String?) -> UIImage? {
        let frame = CGRect(x: 173, y: 70, width: 100, height: 100)
        let nameLabel = UILabel(frame: frame)
        nameLabel.textAlignment = .center
        nameLabel.backgroundColor = .systemGray
        nameLabel.textColor = .white
        nameLabel.font = UIFont.boldSystemFont(ofSize: 36)
        var initials = ""
        if let initialsArray = name?.components(separatedBy: " ") {
            if let firstWord = initialsArray.first {
                if let firstLetter = firstWord.first {
                    initials += String(firstLetter).capitalized }
            }
            if initialsArray.count > 1, let lastWord = initialsArray.last {
                if let lastLetter = lastWord.first { initials += String(lastLetter).capitalized
                }
            }
        } else {
            return nil
        }
        nameLabel.text = initials
        UIGraphicsBeginImageContext(imageview.frame.size)
        if let currentContext = UIGraphicsGetCurrentContext() {
            nameLabel.layer.render(in: currentContext)
            let nameImage = UIGraphicsGetImageFromCurrentImageContext()
            return nameImage
        }
        return nil
    }
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
        print("person: \(person.name)")
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableview.delegate = self
        tableview.dataSource = self
        tableview.tableHeaderView = headerView
        print(imageview.frame.width)
        let trimmed = person.name.trimmingCharacters(in: .whitespacesAndNewlines)
        imageview.image = imageWith(name: trimmed)
        //no ko tron vi chua set width height co dinh cho no
        imageview.layer.cornerRadius = (imageview.frame.width / 2)
        imageview.clipsToBounds = true
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        imageWidthConstraint.constant = imageWidthConstraint.constant + scrollView.contentOffset.x
        imageHeightConstraint.constant = 1 - scrollView.contentOffset.y > 48 ? 1 - scrollView.contentOffset.y : 48
        imageWidthConstraint.constant = imageHeightConstraint.constant
        imageview.layer.cornerRadius = imageHeightConstraint.constant / 2
        imageview.layoutIfNeeded()
    }

}


