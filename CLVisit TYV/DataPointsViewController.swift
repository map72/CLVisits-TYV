import Foundation
import UIKit
import CoreData

class DataPointsViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCoordinates()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    var arrayOfLatitudes = [String]()
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfLatitudes.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("clvisit", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel!.text = arrayOfLatitudes[indexPath.row]
        return cell
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        loadCoordinates()
    }
    
    func loadCoordinates(){
        var visits = [NSManagedObject]()
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest: NSFetchRequest = NSFetchRequest(entityName: "Visit")
    
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            visits = results as! [NSManagedObject]
    
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss zzz"
    
            for location: Visit in results as! [Visit] {
                let latitude:String = String(format:"%f", location.latitude!.doubleValue)
                let longitude:String = String(format:"%f", location.longitude!.doubleValue)
                let arrival:NSDate = location.arrival!
                let arrivalDt = dateFormatter.stringFromDate(arrival)
//                if location.departure!.isEqualToDate(NSDate.distantFuture()) {
//                    arrayOfLatitudes.append(latitude + " " + longitude + " " + arrivalDt)
//                } else {
                    let departure:NSDate = location.departure!
                    let departureDt = dateFormatter.stringFromDate(departure)
                    arrayOfLatitudes.append(latitude + " " + longitude + " " + "arr: " + arrivalDt)
                    arrayOfLatitudes.append(latitude + " " + longitude + " " + "dprt: "  + departureDt)
               // }
            }
            tableView.reloadData()
    
        } catch  {
            print("Could not fetch")
        }

    }
    
    
    
}
