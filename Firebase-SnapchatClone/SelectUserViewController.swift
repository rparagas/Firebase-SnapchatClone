//
//  SelectUserViewController.swift
//  
//
//  Created by Ray Paragas on 19/12/16.
//
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class SelectUserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var usersTableView: UITableView!
    var users : [User] = [] //change array to whatever
    var imageURL : String = ""
    var caption : String = ""
    var uuid : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usersTableView.delegate = self
        usersTableView.dataSource = self
        FIRDatabase.database().reference().child("users").observe(FIRDataEventType.childAdded, with: {(snapshot) in
            print(snapshot)
            
            let user = User()
            user.email = (snapshot.value as! NSDictionary)["email"] as! String
            user.uid = snapshot.key
            self.users.append(user)
            self.usersTableView.reloadData()
        })
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        let snap = ["from": FIRAuth.auth()?.currentUser?.email, "caption": caption, "imageURL": imageURL, "uuid": uuid]
        
        FIRDatabase.database().reference().child("users").child(user.uid).child("snaps").childByAutoId().setValue(snap)
        navigationController!.popToRootViewController(animated: true)
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let user = users[indexPath.row]
        
        cell.textLabel?.text = user.email
        return cell
    }

}
