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
    
    var names: [NSMutableAttributedString] = []
    var namesDic = [String: [NSMutableAttributedString]]()
    var nameSectionTitles = [String]()
    
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
        
        let boldText = "Filter:"
        let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)]
        let attributedString = NSMutableAttributedString(string:boldText, attributes:attrs)

        let normalText = "Hi am normal"
        let normalString = NSMutableAttributedString(string:normalText)
        attributedString.append(normalString)
        
        
    
        let store = CNContactStore()
        let keys = [CNContactGivenNameKey, CNContactPhoneNumbersKey, CNContactNicknameKey, CNContactFamilyNameKey, CNContactDepartmentNameKey, CNContactMiddleNameKey, CNContactNamePrefixKey, CNContactNameSuffixKey] as [CNKeyDescriptor]
        
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
                
            })
        } catch {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllContacts()
        
        let button = UIBarButtonItem(title: "ss", style: .plain, target: self, action: nil)
    
        let button2 = UIBarButtonItem(title: "Groups", style: .done, target: self, action: nil)

        self.navigationItem.rightBarButtonItem = button
        self.navigationItem.leftBarButtonItem = button2
        
        nameSectionTitles = [String](namesDic.keys)
        nameSectionTitles = nameSectionTitles.sorted(by: {$0 < $1})
        
        title = "Contacts"
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableview.delegate = self
        tableview.dataSource = self
        let nib = UINib(nibName: "HomeCell", bundle: .main)
        tableview.register(nib, forCellReuseIdentifier: "cell")
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nameKey = nameSectionTitles[indexPath.section]
        if let nameValue = namesDic[nameKey] {
            let vc = DetailViewController(  )
            vc.name = nameValue[indexPath.row].string
            self.navigationController?.pushViewController(vc, animated: true)
            print(nameValue[indexPath.row])
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return nameSectionTitles[section]
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
       return nameSectionTitles
   }
    
}
