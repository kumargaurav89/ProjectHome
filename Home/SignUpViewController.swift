//
//  SignUpViewController.swift
//  Home
//
//  Created by Kumar gaurav on 2016-05-10.
//  Copyright © 2016 Kumar. All rights reserved.
//

import Foundation

import UIKit

class SignUpViewController: UIViewController {
    
    
    @IBOutlet weak var firstname: UITextField!
    @IBOutlet weak var lastname: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var emailid: UITextField!
    @IBOutlet weak var phoneno: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var cpassword: UITextField!


    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func cancel_clicked(_ sender: AnyObject) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func Create_User(_ sender: AnyObject) {
        
        if (firstname.text == "")
        {
            let alert = UIAlertController(title: "Warning", message: "First Name is Required.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else if (lastname.text == "")
        {
            let alert = UIAlertController(title: "Warning", message: "Last Name is Required.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else if (username.text == "")
        {
            let alert = UIAlertController(title: "Warning", message: "User Name is Required.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else if (emailid.text == "")
        {
            let alert = UIAlertController(title: "Warning", message: "Email ID is Required.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else if (phoneno.text != "" && phoneno.text!.characters.count < 9 &&  phoneno.text!.characters.count > 12)
        {
            print(phoneno.text!.characters.count)
            let alert = UIAlertController(title: "Warning", message: "Phone Number is not correct.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else if (password.text == "" || cpassword.text == "")
        {
            let alert = UIAlertController(title: "Warning", message: "Password is Required.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else if (password.text != cpassword.text)
        {
            let alert = UIAlertController(title: "Warning", message: "Password does not match.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else {
            
            if (validateEmail(emailid.text!))
            {
                let pass = password.text
                let jsonObject: [String:AnyObject] = [
                    "FirstName": firstname.text! as AnyObject,
                    "LastName": lastname.text! as AnyObject,
                    "UserName": username.text! as AnyObject,
                    "EmailID": emailid.text! as AnyObject,
                    "PhoneNO": phoneno.text! as AnyObject,
                    "Password": pass! as AnyObject,
                    "operation": "Insert" as AnyObject
                ]
                
                sendRequest(jsonObject)
            }
                
            else {
                let alert = UIAlertController(title: "Warning", message: "Email id is not in correct format.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
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
                
                let alert = UIAlertController(title: "Warning", message: "Welcome " + self.firstname.text! + " " + self.lastname.text! , preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {
                    
                    Void in
                    
                    let PropertyListViewControllerObj = self.storyboard!.instantiateViewController(withIdentifier: "PropertyListViewController") as? PropertyListViewController
                    
                    let navigationController = UINavigationController(rootViewController: PropertyListViewControllerObj!)
                    
                    OperationQueue.main.addOperation {
                        self.present(navigationController, animated: true, completion: nil)
                        
                        //self.navigationController?.pushViewController(PropertyListViewControllerObj!, animated: true)
                    }
                    
                }))
                
                OperationQueue.main.addOperation {
                    self.present(alert, animated: true, completion: nil)
                }
            }
            else if(receivedData == "User Name already in use.") {
                let alert = UIAlertController(title: "Warning", message: "User Name already in use.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                OperationQueue.main.addOperation {
                    self.present(alert, animated: true, completion: nil)
                }
            }
            else if(receivedData == "Email ID already in use.") {
                let alert = UIAlertController(title: "Warning", message: "Email ID already in use.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                OperationQueue.main.addOperation {
                    self.present(alert, animated: true, completion: nil)
                }
            }
            else if(receivedData == "Phone NO already in use.") {
                let alert = UIAlertController(title: "Warning", message: "Phone Number already in use.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                OperationQueue.main.addOperation {
                    self.present(alert, animated: true, completion: nil)
                }
            }
            else {
                print(receivedData)
            
            }
        })
        
        task.resume()
        
        
//        NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: queue, completionHandler: {
//            (response: URLResponse?, data: Data?, error: NSError?) -> Void in
//            //   let obj = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()) as! [String: AnyObject]
//            //let str: String = obj["result"] as! String
//            
//            let str = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
//            
//            if(str == "success") {
//                
//                let alert = UIAlertController(title: "Warning", message: "Welcome " + self.firstname.text! + " " + self.lastname.text! , preferredStyle: UIAlertControllerStyle.alert)
//                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {
//                    
//                    Void in
//                    
//                    let PropertyListViewControllerObj = self.storyboard!.instantiateViewController(withIdentifier: "PropertyListViewController") as? PropertyListViewController
//                    
//                    self.present(PropertyListViewControllerObj!, animated: true, completion: nil)
//                    
//                }))
//                
//                OperationQueue.main.addOperation {
//                    self.present(alert, animated: true, completion: nil)
//                }
//            }
//            else if(str == "User Name already in use.") {
//                let alert = UIAlertController(title: "Warning", message: "User Name already in use.", preferredStyle: UIAlertControllerStyle.alert)
//                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
//                OperationQueue.main.addOperation {
//                    self.present(alert, animated: true, completion: nil)
//                }
//            }
//            else if(str == "Email ID already in use.") {
//                let alert = UIAlertController(title: "Warning", message: "Email ID already in use.", preferredStyle: UIAlertControllerStyle.alert)
//                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
//                OperationQueue.main.addOperation {
//                    self.present(alert, animated: true, completion: nil)
//                }
//            }
//            else if(str == "Phone NO already in use.") {
//                let alert = UIAlertController(title: "Warning", message: "Phone Number already in use.", preferredStyle: UIAlertControllerStyle.alert)
//                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
//                OperationQueue.main.addOperation {
//                    self.present(alert, animated: true, completion: nil)
//                }
//            }
//            else {
//                print(str)
//            }
//        } as! (URLResponse?, Data?, Error?) -> Void)
    }
    
}
