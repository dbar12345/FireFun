//
//  ViewController.swift
//  firefun
//
//  Created by Dmitriy Barash on 2/19/17.
//  Copyright © 2017 Dmitriy Barash. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var myList: [String] = []
    
    var handle: FIRDatabaseHandle?
    
    var ref:FIRDatabaseReference?
    
    //Saving to Firebase
    @IBAction func saveName(_ sender: Any)
    {
        
        
        if textField.text != ""
        {
            ref?.child("list").childByAutoId().setValue(textField.text)
            textField.text = ""
        }
    
    
        
    }
    
    //Setting TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = myList[indexPath.row]
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        ref = FIRDatabase.database().reference()
        handle = ref?.child("list").observe(.childAdded, with: { (snapshot) in
            if let item = snapshot.value as? String
            {
                self.myList.append(item)
                self.tableView.reloadData()
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

