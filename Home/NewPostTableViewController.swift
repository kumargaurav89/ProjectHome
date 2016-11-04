//
//  NewPostTableViewController.swift
//  Home
//
//  Created by Iqbal Singh on 2016-05-19.
//  Copyright © 2016 Kumar. All rights reserved.
//

import UIKit
import MobileCoreServices

class NewPostTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var dataDict = [String: String]()
    
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var locationTextField: UITextField!
    @IBOutlet var priceTextField: UITextField!
    @IBOutlet var contactEmailField: UITextField!
    @IBOutlet var bedroomsField: UITextField!
    @IBOutlet var kitchenField: UITextField!
    @IBOutlet var washroomsField: UITextField!
    @IBOutlet var additionalInfoTextView: UITextView!
    

    @IBOutlet weak var imageView: UIImageView!
    var newMedia: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelClicked(_ sender: AnyObject) {
        
        print("In")
        
        self.navigationController?.popViewController(animated: true)
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    
        
    }
    
    
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let mediaType = info[UIImagePickerControllerMediaType] as! String
        
        self.dismiss(animated: true, completion: nil)
        
        if mediaType == kUTTypeImage as String {
            let image = info[UIImagePickerControllerOriginalImage]
                as! UIImage
            
            imageView.image = image
            
            if (newMedia == true) {
                UIImageWriteToSavedPhotosAlbum(image, self,
                                               Selector("image:didFinishSavingWithError:contextInfo:"), nil)
            } else if mediaType == kUTTypeImage as String {
                // Code to support video here
            }
            
        }
    }

    
    
    
    func image(_ image: UIImage, didFinishSavingWithError error: NSErrorPointer?, contextInfo:UnsafeRawPointer) {
        
        if error != nil {
            let alert = UIAlertController(title: "Save Failed",
                                          message: "Failed to save image",
                                          preferredStyle: UIAlertControllerStyle.alert)
            
            let cancelAction = UIAlertAction(title: "OK",
                                             style: .cancel, handler: nil)
            
            alert.addAction(cancelAction)
            self.present(alert, animated: true,
                                       completion: nil)
        }
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        dataDict["title"] = titleTextField.text
        dataDict["location"] = locationTextField.text
        dataDict["price"] = priceTextField.text
        dataDict["contact_email"] = contactEmailField.text
        dataDict["bedrooms"] = bedroomsField.text
        dataDict["kitchen"] = kitchenField.text
        dataDict["washrooms"] = washroomsField.text
        dataDict["additional_info"] = additionalInfoTextView.text
        
        if(segue.identifier == "newPostSegue") {
            print("IN PHOTO CONTROLLER...")
            
        }
    }
    
    
    
}
