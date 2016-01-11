import UIKit
import CoreData
import MapKit

class MapViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPins()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBOutlet weak var mapView: MKMapView!
    
//    @IBAction func loadMapView(sender: AnyObject) {
//        loadPins()
//    }
    
    @IBAction func clearVisits(sender: AnyObject) {
        deleteVisits()
        loadPins()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        loadPins()
    }
    
    func deleteVisits() {
        let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDel.managedObjectContext
        let coord = appDel.persistentStoreCoordinator
        
        let fetchRequest = NSFetchRequest(entityName: "Visit")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try coord.executeRequest(deleteRequest, withContext: context)
        } catch let error as NSError {
            debugPrint(error)
        }
        
        do {
            try context.save()
        } catch let error {
            print("Could not cache the response \(error)")
        }
    }
    
    
    func loadPins(){
        var visits = [NSManagedObject]()
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest: NSFetchRequest = NSFetchRequest(entityName: "Visit")
        
        do {
            let results =
            try managedContext.executeFetchRequest(fetchRequest)
            visits = results as! [NSManagedObject]
            
            for location: Visit in results as! [Visit] {
                let annotation: MKPointAnnotation = MKPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2DMake(location.latitude!.doubleValue, location.longitude!.doubleValue)
                annotation.title = location.description
                self.mapView.addAnnotation(annotation)
            }
            
        } catch  {
            print("Could not fetch")
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

