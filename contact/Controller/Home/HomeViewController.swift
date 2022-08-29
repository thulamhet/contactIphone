import UIKit
import Contacts

struct Person {
    var id: String
    var name: String
    var contact: CNContact?
    var tel: [String]
    var number: [String]
    var emailAddress: (value: String?, label: String?)
    var birthday: String
}

class HomeViewController: UIViewController {
    @IBOutlet weak var tableview: UITableView!
    var selectedIndex = IndexPath(row: -1, section: 0)
    var names: [NSMutableAttributedString] = []
    var namesDic = [String: [NSMutableAttributedString]]()
    var nameSectionTitles = [String]()
    var phoneDict = [String: String]()
    var models = [Person]()
    
    func fetchSpecificContact () {
        let store = CNContactStore()
        let keys = [CNContactGivenNameKey, CNContactPhoneNumbersKey] as [CNKeyDescriptor]
        let predicate = CNContact.predicateForContacts(matchingName: "Haro")
        do {
            let contacts = try store.unifiedContacts(matching: predicate, keysToFetch: keys)
            print(contacts)
        } catch {
            print("Error: \(error)")
        }
    }
    
    func fetchAllContacts() {
        let store = CNContactStore()
        let keys = [CNContactGivenNameKey, CNContactPhoneNumbersKey, CNContactNicknameKey, CNContactFamilyNameKey, CNContactMiddleNameKey, CNContactNamePrefixKey, CNContactNameSuffixKey, CNContactEmailAddressesKey, CNContactJobTitleKey, CNContactBirthdayKey, CNContactUrlAddressesKey, CNContactBirthdayKey] as [CNKeyDescriptor]
        
        let fetchRequest = CNContactFetchRequest(keysToFetch: keys)
        
        do {
            try store.enumerateContacts(with: fetchRequest, usingBlock: {contact,
                result in
                let boldText1 = contact.familyName
                let attrs1 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)]
                let attributedString = NSMutableAttributedString(string:boldText1, attributes:attrs1)
                let normalText1 = contact.namePrefix + " " + contact.givenName + " " + contact.middleName + " "
                let normalText2 = " " + contact.nameSuffix
                let normalString1 = NSMutableAttributedString(string:normalText1)
                let normalString2 = NSMutableAttributedString(string:normalText2)
                normalString1.append(attributedString)
                normalString1.append(normalString2)
                self.names.append(normalString1)
                let nameKey = String(contact.familyName.prefix(1))
                if var nameValue = self.namesDic[nameKey] {
                    nameValue.append(normalString1)
                    self.namesDic[nameKey] = nameValue
                } else {
                    self.namesDic[nameKey] = [normalString1]
                }
                var model = Person(id: contact.identifier, name: normalString1.string, contact: contact, tel: [], number: [], emailAddress: ("", ""), birthday: "")
                for phoneNumber in contact.phoneNumbers {
                    if let number = phoneNumber.value as? CNPhoneNumber, let label = phoneNumber.label {
                        let localizedLabel = CNLabeledValue<CNPhoneNumber>.localizedString(forLabel: label)

                        for mail in contact.emailAddresses {
                            model.emailAddress.value = mail.value as String
                            model.emailAddress.label = (mail.label)! as String 
                        }
                        model.tel.append(localizedLabel)
                        model.number.append(number.stringValue)
                    }
                }

                if let month = contact.birthday?.month, let date = contact.birthday?.day, let year = contact.birthday?.year {
                    var _month = ""
                    switch month {
                    case 1:
                        _month = "January"
                    case 2:
                        _month = "February"
                    case 3:
                        _month = "March"
                    case 4:
                        _month = "April"
                    case 5:
                        _month = "May"
                    case 6:
                        _month = "June"
                    case 7:
                        _month = "July"
                    case 8:
                        _month = "August"
                    case 9:
                        _month = "September"
                    case 10:
                        _month = "October"
                    case 11:
                        _month = "November"
                    default:
                        _month = "December"

                    }
                    model.birthday += (_month + " " + String(date) + "," +  String(year))
                }
                print(type(of: contact.birthday?.month))
                print(model.birthday)
                self.models.append(model)
            })
        } catch  {
            print("Error!! : \(error)")
        }
    }
    @IBAction func longPressCell () {
        print("ekekekekeke")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllContacts()
        let grButton = UIBarButtonItem(title: "Groups", style: .done, target: self, action: nil)
        self.navigationItem.leftBarButtonItem = grButton
        nameSectionTitles = [String](namesDic.keys)
        nameSectionTitles = nameSectionTitles.sorted(by: {$0 < $1})
        title = "Contacts"
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableview.delegate = self
        tableview.dataSource = self
        let nib = UINib(nibName: "HomeCell", bundle: .main)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        tableview.register(nib, forCellReuseIdentifier: "cell")
        
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(HomeViewController.longPressCell))
        tableview.addGestureRecognizer(longPress)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(translationX: 0, y: 60)
        UIView.animate(
                    withDuration: 1,
                    delay: 0.2 * Double(indexPath.row),
                    usingSpringWithDamping: 0.4,
                    initialSpringVelocity: 0.1,
                    options: [.curveEaseInOut],
                    animations: {
                        cell.transform = CGAffineTransform(translationX: 0, y: 0)
                })
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nameKey = nameSectionTitles[indexPath.section]
        let indexesToRedraw = [indexPath]
        selectedIndex = indexPath
        tableView.reloadRows(at: indexesToRedraw, with: .fade)
        if let nameValue = namesDic[nameKey] {
            let vc = DetailViewController()
            vc.name = nameValue[indexPath.row].string
            
            for model in models {
                if vc.name == model.name  {
                    vc.person = model
                }
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return nameSectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let nameKey = nameSectionTitles[section]
        if let nameValue = namesDic[nameKey] {
            return nameValue.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeCell
        let nameKey = nameSectionTitles[indexPath.section]
        if let nameValue = namesDic[nameKey] {
            cell.nameLabel?.attributedText = nameValue[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return nameSectionTitles[section]
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return nameSectionTitles
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let nameKey = nameSectionTitles[indexPath.section]
     
        if editingStyle == .delete {
            tableview.beginUpdates()
            if var nameValue = namesDic[nameKey] {
                nameValue.remove(at: indexPath.row)
                namesDic[nameKey] = nameValue
            }
            tableview.deleteRows(at: [indexPath], with: .fade)
            tableview.endUpdates()
//            tableview.reloadData()
        }
    }
    
}

