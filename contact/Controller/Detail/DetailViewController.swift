import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var imageV: UIImageView!
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var editButton: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var callView: UIView!
    @IBOutlet weak var mailView: UIView!
    @IBOutlet weak var tableview: UITableView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailTitle: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var addEmerView: UIView!
    @IBOutlet weak var shareLoView: UIView!
    @IBOutlet weak var noteView: UIView!
    @IBOutlet weak var birthdayTitle: UIView!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var birthdayView: UIView!
    @IBOutlet weak var aView: UIView!
    var phoneDict = [String: String]()
    
    var person = Person(id: "", name: "", contact: nil, tel:[], number: [], emailAddress: (nil, nil), birthday: "" )
        
    var name: String = ""
    func imageWith(name: String?) -> UIImage? {
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
        UIGraphicsBeginImageContext(imageV.frame.size)
        if let currentContext = UIGraphicsGetCurrentContext() {
            nameLabel.layer.render(in: currentContext)
            let nameImage = UIGraphicsGetImageFromCurrentImageContext()
            return nameImage
        }
        return nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @objc func tappedEditButton (sender: UIButton!) {
        print("tapped button")
        let vc = EditViewController()
        vc.person = person
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        let action = #selector(DetailViewController.tappedEditButton)
        let editButton = UIBarButtonItem(title: "Edit", style: .done, target: self, action: action)
        self.navigationItem.rightBarButtonItem = editButton
        
        
        let trimmed = self.name.trimmingCharacters(in: .whitespacesAndNewlines)
        let nib = UINib(nibName: "DetailCell", bundle: .main)
        tableview.register(nib, forCellReuseIdentifier: "cell")
        tableview.delegate = self
        tableview.dataSource = self
        nameLabel.text = trimmed
        imageV.image = imageWith(name: trimmed)
        imageV.setRounded()
        self.navigationItem.hidesSearchBarWhenScrolling = true
        tableview.layer.cornerRadius = 8
        messageView.layer.cornerRadius = 8
        callView.layer.cornerRadius = 8
        mailView.layer.cornerRadius = 8
        tableview.heightAnchor.constraint(equalToConstant: CGFloat(65 * person.tel.count)).isActive = true
        tableview.layer.cornerRadius = 8
        emailView.layer.cornerRadius = 8
        birthdayView.layer.cornerRadius = 8
        noteView.layer.cornerRadius = 8
        aView.layer.cornerRadius = 8
        addEmerView.layer.cornerRadius = 8
        shareLoView.layer.cornerRadius = 8
//        tableview.tableHeaderView = imageV
        if person.emailAddress.value != "" || person.emailAddress.label != "" {
            emailTitle.text = "home"
            emailLabel.text = person.emailAddress.value
        } else {
            emailView.isHidden = true
        }
        
        messageView.layer.shadowOffset = CGSize(width: 3,
                                          height: 3)
        messageView.layer.shadowRadius = 3
        messageView.layer.shadowOpacity = 0.05
        
        
        callView.layer.shadowOffset = CGSize(width: 3,
                                          height: 3)
        callView.layer.shadowRadius = 3
        callView.layer.shadowOpacity = 0.05
        
        
        mailView.layer.shadowOffset = CGSize(width: 3,
                                          height: 3)
        mailView.layer.shadowRadius = 3
        mailView.layer.shadowOpacity = 0.05
        
        
        phoneView.layer.shadowOffset = CGSize(width: 3,
                                          height: 3)
        phoneView.layer.shadowRadius = 3
        phoneView.layer.shadowOpacity = 0.05
        
        
        emailView.layer.shadowOffset = CGSize(width: 3,
                                          height: 3)
        emailView.layer.shadowRadius = 3
        emailView.layer.shadowOpacity = 0.05
        
        birthdayView.layer.shadowOffset = CGSize(width: 3,
                                          height: 3)
        birthdayView.layer.shadowRadius = 3
        birthdayView.layer.shadowOpacity = 0.05
        
        noteView.layer.shadowOffset = CGSize(width: 3,
                                          height: 3)
        noteView.layer.shadowRadius = 3
        noteView.layer.shadowOpacity = 0.05
        
        aView.layer.shadowOffset = CGSize(width: 3,
                                          height: 3)
        aView.layer.shadowRadius = 3
        aView.layer.shadowOpacity = 0.05
        
        shareLoView.layer.shadowOffset = CGSize(width: 3,
                                          height: 3)
        shareLoView.layer.shadowRadius = 3
        shareLoView.layer.shadowOpacity = 0.05
        
        addEmerView.layer.shadowOffset = CGSize(width: 3,
                                          height: 3)
        addEmerView.layer.shadowRadius = 3
        addEmerView.layer.shadowOpacity = 0.05
        if person.birthday != "" {
            birthdayLabel.text = person.birthday
        } else {
            birthdayView.isHidden = true
        }
    }
    
    @IBAction func onTapBackButton () {
        self.navigationController?.popViewController(animated: true)
    }
}
extension UIImageView {
    func setRounded() {
        self.layer.cornerRadius = (self.frame.width / 2)
    }
}


extension DetailViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return person.tel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DetailCell
        cell.titleLabel?.text = person.tel[indexPath.row]
        cell.subtitleLabel?.text = person.number[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected cell: \(person.tel[indexPath.row])")
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let y = 200 - (scrollView.contentOffset.y + 200)
//        let h = max(60, y)
//        print(y)
//        let rect = CGRect(x: 0, y: 0, width: view.bounds.width, height: h)
//        editButton.frame = rect
//    }
}

extension DetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = 200 - (scrollView.contentOffset.y + 200)
        let h = max(60, y)
//        print(y)
        let rect = CGRect(x: 5, y: 5, width: view.bounds.width, height: h)
        imageV.frame = rect
        print(imageV.frame)
    }
}
