//
//  DetailViewController.swift
//  contact
//
//  Created by Nguyễn Công Thư on 17/08/2022.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    var name: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Detail"
        
        nameLabel.text = name
    }
}
