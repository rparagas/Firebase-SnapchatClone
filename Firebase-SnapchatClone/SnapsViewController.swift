//
//  SnapsViewController.swift
//  Firebase-SnapchatClone
//
//  Created by Ray Paragas on 19/12/16.
//  Copyright © 2016 Ray Paragas. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class SnapsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var snapsTableView: UITableView!
    
    var snaps : [Snap] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        snapsTableView.dataSource = self
        snapsTableView.delegate = self

        FIRDatabase.database().reference().child("users").child(FIRAuth.auth()!.currentUser!.uid).child("snaps").observe(FIRDataEventType.childAdded, with: {(snapshot) in
            print(snapshot)
            
            let snap = Snap()
            snap.caption = (snapshot.value as! NSDictionary)["caption"] as! String
            snap.from = (snapshot.value as! NSDictionary)["from"] as! String
            snap.imageURL = (snapshot.value as! NSDictionary)["imageURL"] as! String
            snap.key = snapshot.key
            snap.uuid = (snapshot.value as! NSDictionary)["uuid"] as! String
            
            self.snaps.append(snap)
            self.snapsTableView.reloadData()
        })
        
        FIRDatabase.database().reference().child("users").child(FIRAuth.auth()!.currentUser!.uid).child("snaps").observe(FIRDataEventType.childRemoved, with: {(snapshot) in
            print(snapshot)
            
            var index = 0
            for snap in self.snaps {
                if snap.key == snapshot.key {
                    self.snaps.remove(at: index)
                }
                index += 1
            }
            self.snapsTableView.reloadData()
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewSnapSegue" {
            let nextVC = segue.destination as! ViewSnapViewController
            nextVC.snap = sender as! Snap
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let snap = snaps[indexPath.row]
        performSegue(withIdentifier: "viewSnapSegue", sender: snap)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return snaps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let snap = snaps[indexPath.row]
        cell.textLabel?.text = snap.from
        return cell
    }
        
    @IBAction func logoutTapped(_ sender: Any) {
        print("Successfully logged out")
        dismiss(animated: true, completion: nil)
    }
}
