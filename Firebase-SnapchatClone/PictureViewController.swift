//
//  PictureViewController.swift
//  
//
//  Created by Ray Paragas on 19/12/16.
//
//

import UIKit
import Firebase
import FirebaseStorage

class PictureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var snapImageView: UIImageView!
    @IBOutlet weak var captionTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    var imagePicker = UIImagePickerController()
    var uuid = NSUUID().uuidString
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        nextButton.isEnabled = false
        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! SelectUserViewController
        nextVC.imageURL = sender as! String
        nextVC.caption = captionTextField.text!
        nextVC.uuid = uuid
    }
    
    @IBAction func nextTapped(_ sender: Any) {
        nextButton.isEnabled = false
        let imagesFolder = FIRStorage.storage().reference().child("images")
        let imageData = UIImageJPEGRepresentation(snapImageView.image!, 0.1)!
        imagesFolder.child("\(uuid).jpg").put(imageData, metadata: nil, completion: {(metadata, error) in
            print("We tried to upload")
            if error != nil {
                print("We has an error: \(error)")
            } else {
                self.performSegue(withIdentifier: "selectUserSegue", sender: metadata?.downloadURL()!.absoluteString)
            }
        })
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        snapImageView.image = image
        snapImageView.backgroundColor = UIColor.clear
        imagePicker.dismiss(animated: true, completion: nil)
        nextButton.isEnabled = true
    }
}
