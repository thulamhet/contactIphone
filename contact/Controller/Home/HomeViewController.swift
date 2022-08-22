//
//  HomeViewController.swift
//  contact
//
//  Created by Nguyễn Công Thư on 17/08/2022.
//

import UIKit
import Contacts

class HomeViewController: UIViewController {

    
    @IBOutlet weak var tableview: UITableView!
    var titles: [String] = ["iOS", "Android"]
    
    var names: [String] =
        [
            "Bình", "Khánh", "Toàn", "Tâm", "An", "Hương", "Huy", "Quang", "Vân", "Đài", "Tiến"
        ]
    var namesDic = [String: [String]]()
    var nameSectionTitles = [String]()
    
    func fetchSpecificContact () async {
        let store = CNContactStore()
        
        let keys = [CNContactGivenNameKey, CNContactPhoneNumbersKey] as [CNKeyDescriptor]
        
        let predicate = CNContact.predicateForContacts(matchingName: "Kate")
        do {
            let contacts = try store.unifiedContacts(matching: predicate, keysToFetch: keys)
            print(contacts)
        } catch {
            print("Error: \(error)")
        }
    }
 
    
    func fetchAllContacts() async {
        // Get access to the contacts store
        let store = CNContactStore()
        //Specify which data keys want to fetch
        let keys = [CNContactGivenNameKey, CNContactPhoneNumbersKey] as [CNKeyDescriptor]
        
        //Create fetch request
        let fetchRequest = CNContactFetchRequest(keysToFetch: keys)
        
        //Call the method to fetch all contacts
        do {
            try store.enumerateContacts(with: fetchRequest, usingBlock: {contact,
                result in
                print(contact.givenName)
                
                for number in contact.phoneNumbers {
                    switch number.label {
                    case CNLabelPhoneNumberMobile:
                        print("- Mobile: \(number.value.stringValue)")
                    case CNLabelPhoneNumberMain:
                        print("- Main: \(number.value.stringValue)")
                    default:
                        print("- Other: \(number.value.stringValue)")
                    }
                }
            })
        } catch {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Task.init {
            await fetchSpecificContact()
        }
        for name in names {
            let nameKey = String(name.prefix(1))
            if var nameValue = namesDic[nameKey] {
                nameValue.append(name)
                namesDic[nameKey] = nameValue
            } else {
                namesDic[nameKey] = [name]
            }
        }
        
        let button = UIBarButtonItem(title: "Sua", style: .plain, target: self, action: nil)
//        let button2 = UIBarButtonItem(title: "hehe", style: .done, target: self, action: nil)
        let button2 = UIBarButtonItem(image: UIImage(named: "rectangle.stack.fill.badge.plus") ,style: .done, target: self, action: nil)

        self.navigationItem.rightBarButtonItem = button
        self.navigationItem.leftBarButtonItem = button2
        
        
        nameSectionTitles = [String](namesDic.keys)
        nameSectionTitles = nameSectionTitles.sorted(by: {$0 < $1})
        
        title = "Contacts"
        // Do any additional setup after loading the view.
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableview.delegate = self
        tableview.dataSource = self
    }
}



extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let nameKey = nameSectionTitles[indexPath.section]
            if let nameValue = namesDic[nameKey] {
                cell.textLabel?.text = nameValue[indexPath.row]
            }

//        let label = UILabel(frame: CGRect(x: 20, y: 30, width: 100, height: 20))
//        label.text = "sub title"
//        label.textColor = .red
//        cell.addSubview(label)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected cell: \( names[indexPath.row])")
        let vc = DetailViewController()
        vc.name = names[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return nameSectionTitles[section]
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
       return nameSectionTitles
   }
    
}
