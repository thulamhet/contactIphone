import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var imageV: UIImageView!
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var editButton: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var callView: UIView!
    @IBOutlet weak var mailView: UIView!
    @IBOutlet weak var tableview: UITableView!
    
    var phoneDict = [String: String]()
    
    var person = Person(id: "", name: "", contact: nil, tel:nil, number: nil, emailAddress: nil )
    
    var names: [String] = ["Tí",
                           "Tèo",
                           "Hùng",
                           "Lam",
                           "Thuỷ",
                           "Tuấn",
                           "Trung",
                           "Lam",
                           "Thuỷ",
                           "Tuấn",
                           "Trung",
                           "Hạnh"]
    
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
    
//    for phoneNumber in contact.phoneNumbers {
//        if let number = phoneNumber.value as? CNPhoneNumber, let label = phoneNumber.label {
//            let localizedLabel = CNLabeledValue<CNPhoneNumber>.localizedString(forLabel: label)
//            print("\(contact.givenName) \(contact.familyName) tel:\(localizedLabel) -- \(number.stringValue), email: \(contact.emailAddresses)")
//        }
//    }
//    func getPhone () {
//        let phoneNumber = person.contact?.ph
//            if let number = phoneNumber.value as? CNPhoneNumber, let label = phoneNumber.label {
//                let localizedLabel = CNLabeledValue<CNPhoneNumber>.localizedString(forLabel: label)
//                print("\(contact.givenName) \(contact.familyName) tel:\(localizedLabel) -- \(number.stringValue), email: \(contact.emailAddresses)")
//            }
//
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("personeeenene, \(String(describing: person.emailAddress))")
        let trimmed = self.name.trimmingCharacters(in: .whitespacesAndNewlines)
        let nib = UINib(nibName: "DetailCell", bundle: .main)
        tableview.register(nib, forCellReuseIdentifier: "cell")
        tableview.delegate = self
        tableview.dataSource = self
        nameLabel.text = trimmed
        imageV.image = imageWith(name: trimmed)
        imageV.setRounded()
        self.navigationItem.hidesSearchBarWhenScrolling = true
        //        self.navigationController?.isNavigationBarHidden = true
        backButton.addTarget(self, action: #selector(onTapBackButton), for: .touchUpInside)
        tableview.layer.cornerRadius = 8
        messageView.layer.cornerRadius = 8
        callView.layer.cornerRadius = 8
        mailView.layer.cornerRadius = 8
        tableview.heightAnchor.constraint(equalToConstant: CGFloat(50 * names.count)).isActive = true
        tableview.layer.cornerRadius = 8
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
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DetailCell
        cell.titleLabel?.text = names[indexPath.row]
        cell.subtitleLabel?.text = names[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected cell: \(names[indexPath.row])")
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
