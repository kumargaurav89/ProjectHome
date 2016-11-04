//
//  ViewController.swift
//  Home
//
//  Created by Kumar gaurav on 2016-05-10.
//  Copyright © 2016 Kumar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var UserEmailID: UITextField!
    @IBOutlet weak var UserPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func LogIN(_ sender: UIButton) {
        
        if (UserEmailID.text == "")
        {
            let alert = UIAlertController(title: "Warning", message: "Email ID is Required.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else if (UserPassword.text == "")
        {
            let alert = UIAlertController(title: "Warning", message: "Password is Required.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else {
            
            if (validateEmail(UserEmailID.text!))
            {
                
                // let stringPost = "token1=12345"
                let pass = UserPassword.text
                let jsonObject: [String:AnyObject] = [
                    "EmailID": UserEmailID.text! as AnyObject,
                    "Password": pass! as AnyObject,
                    "operation": "SignIN" as AnyObject
                ]
                
                sendRequest(jsonObject)
            }
                
            else {
                let alert = UIAlertController(title: "Warning", message: "Email id is not in correct format.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                OperationQueue.main.addOperation {
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    //function to validate the EMail ID
    func validateEmail(_ enteredEmail:String) -> Bool {
        
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
        
    }
    
    func sendRequest(_ json_obj: [String: AnyObject]) {
        
        let urlString = URL(string: "http://localhost/ProjectHome/InsertScript.php")
        
        let request = NSMutableURLRequest(url: urlString!)
        let session = URLSession.shared
        request.httpMethod = "POST"
        
        let valid = JSONSerialization.isValidJSONObject(json_obj)
        if (valid == true) {
            let jsonData: Data = try! JSONSerialization.data(withJSONObject: json_obj, options: JSONSerialization.WritingOptions())
            request.httpBody = jsonData
        }
        
        request.timeoutInterval = 60
        request.httpShouldHandleCookies = false
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            
            let receivedData = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            
            if(receivedData! == "success") {
                
                let PropertyListViewControllerObj = self.storyboard!.instantiateViewController(withIdentifier: "PropertyListViewController") as? PropertyListViewController
                
                let navigationController = UINavigationController(rootViewController: PropertyListViewControllerObj!)
                
                OperationQueue.main.addOperation {
                    self.present(navigationController, animated: true, completion: nil)
                
                    //self.navigationController?.pushViewController(PropertyListViewControllerObj!, animated: true)
                }
                
                self.dismiss(animated: true, completion: nil)
                
            }
            else if(receivedData! == "Wrong Email ID or Password.") {
                
                let alert = UIAlertController(title: "Warning", message: "Wrong Email ID or Password.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                                
                OperationQueue.main.addOperation {
                    self.present(alert, animated: true, completion: nil)
                }
            }
        })
        
        task.resume()
    }
}
