//
//  PropertyListViewController.swift
//  Home
//
//  Created by Iqbal Singh on 2016-05-16.
//  Copyright © 2016 Kumar. All rights reserved.
//

import UIKit

class PropertyListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var descriptionArray = ["3 BHK Homes"]
    var imageArray = ["pic1.jpg"]
    var locationArray = ["Toronto"]
    var dateArray = ["05/12/2016"]
    var priceArray = ["1000"]
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return descriptionArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! PropertyListTableViewCell
        
        cell.picImageView.image = UIImage(named: imageArray[(indexPath as NSIndexPath).row])
        cell.descriptionLabel.text = descriptionArray[(indexPath as NSIndexPath).row]
        cell.locationLabel.text = locationArray[(indexPath as NSIndexPath).row]
        cell.dateLabel.text = dateArray[(indexPath as NSIndexPath).row]
        cell.priceLabel.text = "$" + priceArray[(indexPath as NSIndexPath).row]
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            imageArray.remove(at: (indexPath as NSIndexPath).row)
            descriptionArray.remove(at: (indexPath as NSIndexPath).row)
            locationArray.remove(at: (indexPath as NSIndexPath).row)
            dateArray.remove(at: (indexPath as NSIndexPath).row)
            priceArray.remove(at: (indexPath as NSIndexPath).row)
        }
        
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    
    @IBAction func newPost(_ sender: AnyObject) {
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
