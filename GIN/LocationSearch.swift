//
//  LocationSearch.swift
//  CISSMUN
//
//  Created by Tanya Lai on 9/3/17.
//  Copyright © 2017 Stanley Liu. All rights reserved.
//

import UIKit

var roomies = [Room]()
var images = [ #imageLiteral(resourceName: "HS 1"),#imageLiteral(resourceName: "HS 2"), #imageLiteral(resourceName: "HS 3"),#imageLiteral(resourceName: "HS 4"),#imageLiteral(resourceName: "HS 5"),#imageLiteral(resourceName: "HS 6"),  #imageLiteral(resourceName: "1st Floor Intermediate"), #imageLiteral(resourceName: "2nd Floor Intermediate"),  #imageLiteral(resourceName: "ES 1st Floor"), #imageLiteral(resourceName: "ES 2nd Floor"), #imageLiteral(resourceName: "ES 3rd Floor"), #imageLiteral(resourceName: "ES 4th Floor"), #imageLiteral(resourceName: "1st Floor Rittmann"), #imageLiteral(resourceName: "2nd Floor Rittmann"), #imageLiteral(resourceName: "3rd Floor Rittmann"), #imageLiteral(resourceName: "4th Floor Rittmann"), #imageLiteral(resourceName: "1st Floor Phoenix"), #imageLiteral(resourceName: "2nd Floor Phoenix"), #imageLiteral(resourceName: "HS B1")]
var text = ["1st Floor of the Upper Building","2nd Floor of the Upper Building","3rd Floor of the Upper Building","4th Floor of the Upper Building","5th Floor of the Upper Building","6th Floor of the Upper Building","1st Floor of the Intermediate Building","2nd Floor of the Intermediate Building","1st Floor of the Lower Building","2nd Floor of the Lower Building","3rd Floor of the Lower Building","4th Floor of the Lower Building","1st Floor of the Rittmann","2nd Floor of the Rittmann","3rd Floor of the Rittmann","4th Floor of the Rittmann","1st Floor of the Phoenix Center","2nd Floor of the Phoenix Center","Basement of the Upper Building"] //HS to MS to ES to RT to Phoenix Center  0-18
var row = ""
var rowNum = 0
var numberone = 0
var justfori = 0

var cells = [UITableViewCell]();

var roro = ["GA4, Wittenberg Hall (H316/H318)", "GA3, PC Lounge",
            "ECOSOC, HS Gym (H115)",
            "P228, Phoenix Café",
            "Approval Panel, HS Library (H227)",
            "H233, HS Conference Room",
            "Environmental, Augsburg Hall (H405/H406)",
            "GA6, MS Gym (M116)",
            "HRC, ES Library (E322)",
            "E122, ES Cafeteria",
            "SC, Orchestra Room (R302)",
            "Cafeteria",
            "ICJ (H216)",
            "CSW, Jade/Pearl (P230/P231)",
            "Secretariat/Hive, Costume Room (P135)",
            "Advisory Panel, Health Room (H127)",
            "R101, Rittmann Theatre",
            "CISSMUN Vigil (H305)",
            "Spec Conf (H404)",
            "UNPFII (H403)",
            "ICC, New Luther (P201)",
            "Printing (H205)",
            "Keynote Speakers",
            "Phoenix Center Gym (P106)",
            "H203",
            "H204",
            "H206",
            "Disarmament, Motor Skills Room",
            "GA1, PE Commons",
            "P232",
            "P233",
            "P234",
            "P202",
            "P203",
            "P204",
            "M101, MS Reception",
            "M104",
            "M105",
            "M106",
            "M107",
            "M108",
            "M109",
            "M110",
            "M201",
            "M204",
            "M205",
            "M206",
            "M207",
            "M208",
            "M209",
            "M210",
            "M211",
            "M223",
            "P133",
            "P134",
    "H118",
    "H216",
    "H306",
    "H304",
    "H303"]

class LocationSearch: UITableViewController, UISearchResultsUpdating{

    var filtered = [Room]()
    var searchController : UISearchController!
    var resultsController = UITableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(UserDefaults.standard.object(forKey: "myConference") as? Bool == true) {
        roomies = [
            //Room for Student Offs.
            //Room for Admin
            //Room for Grown-ups
            Room(roomName:"GA4, Wittenberg Hall (H316/H318)", floorNumber: text[2], floorMap: "HS 3"),
            Room(roomName:"GA3, PC Lounge", floorNumber: text[1], floorMap: "HS 2"),
            Room(roomName:"ECOSOC, HS Gym (H115)", floorNumber: text[0], floorMap: "HS 1"),
            Room(roomName:"Phoenix Café (P228)", floorNumber: text[1], floorMap: "HS 2"),
            Room(roomName:"Approval Panel, HS Library (H227)", floorNumber: text[1], floorMap: "HS 2"),
            Room(roomName:"Environment, Augsburg Hall (H405/H406)", floorNumber: text[3], floorMap: "HS 4"),
            Room(roomName:"GA6, MS Gym (M116)", floorNumber: text[6], floorMap: "MS 1"),
            Room(roomName:"HRC, ES Library (E322)", floorNumber: text[10], floorMap: "ES 3"),
            
           // Room(roomName:"Eleme Cafeteria (E122)", floorNumber: text[8], floorMap: "ES 1"),
            Room(roomName:"SC, Orchestra Room (R302)", floorNumber: text[14], floorMap: "R 3"),
            Room(roomName:"PC Cafeteria", floorNumber: text[16], floorMap: "PC 1"),
            Room(roomName:"ICJ (H216)", floorNumber: text[1], floorMap: "HS 2"),
            Room(roomName:"UNCSW, Jade/Pearl (P230/P231)", floorNumber: text[17], floorMap: "PC 2"),
            Room(roomName:"Secretariat/Hive, SMS Maker Room (H218)", floorNumber: text[1], floorMap: "HS 2"),
            Room(roomName:"Advisory Panel, Health Room (H127)", floorNumber: text[0], floorMap: "HS 1"),
            Room(roomName:"Rittmann Theatre (R101)", floorNumber: text[12], floorMap: "R 1"),
            Room(roomName:"CISSMUN Vigil 1 (H305)", floorNumber: text[2], floorMap: "HS 3"),
            Room(roomName:"CISSMUN Vigil 2 (H306)", floorNumber: text[2], floorMap: "HS 3"),
            Room(roomName:"Spec Conf (H404)", floorNumber: text[3], floorMap: "HS 4"),
            Room(roomName:"UNPFII (H403)", floorNumber: text[3], floorMap: "HS 4"),
            Room(roomName:"Printing (H205)", floorNumber: text[1], floorMap: "HS 2"),
            Room(roomName:"Keynotes, PC Gym (P106)", floorNumber: text[16], floorMap: "PC 1"),
            Room(roomName:"Disarmament, Motor Skills Room (Room)",floorNumber: text[8], floorMap: "ES 1"),
            //we really need to find out this MSR's room number
            Room(roomName:"GA1, PE Commons", floorNumber: text[18], floorMap: "HS B1"),
            Room(roomName:"ICC 1, New Luther (P201)", floorNumber: text[17], floorMap: "PC 2"),
            Room(roomName:"ICC 2, Conference Room (H233)", floorNumber: text[1], floorMap: "HS 2"),
              Room(roomName:"ICC 3, Business Hub Board Room (H329/H330)", floorNumber: text[1], floorMap: "HS 2")
            ]
        }
            
        else if ( UserDefaults.standard.object(forKey: "myConference") as? Bool == false) {
            //selected GIN
            roomies = [
                Room(roomName:"Wittenberg Hall (H316/H318)", floorNumber: text[2], floorMap: "HS 3"),
                Room(roomName:"PC Lounge", floorNumber: text[1], floorMap: "HS 2"),
                Room(roomName:"HS Gym (H115)", floorNumber: text[0], floorMap: "HS 1"),
                Room(roomName:"Phoenix Café (P228)", floorNumber: text[1], floorMap: "HS 2"),
                Room(roomName:"HS Library (H227)", floorNumber: text[1], floorMap: "HS 2"),
                Room(roomName:"HS Conference Room", floorNumber: text[1], floorMap: "HS 2"),
                Room(roomName:"Augsburg Hall (H405/H406)", floorNumber: text[3], floorMap: "HS 4"),
                Room(roomName:"MS Gym (M116)", floorNumber: text[6], floorMap: "MS 1"),
                Room(roomName:"ES Library (E322)", floorNumber: text[10], floorMap: "ES 3"),
                Room(roomName:"ES Cafeteria", floorNumber: text[8], floorMap: "ES 1"),
                Room(roomName:"Orchestra Room (R302)", floorNumber: text[14], floorMap: "R 3"),
                Room(roomName:"PC Cafeteria", floorNumber: text[16], floorMap: "PC 1"),
                Room(roomName:"H116", floorNumber: text[0], floorMap: "HS 1"),
                Room(roomName:"Costume Room (P135)", floorNumber: text[16], floorMap: "PC 1"),
                Room(roomName:"Health Room (H127)", floorNumber: text[0], floorMap: "HS 1"),
                Room(roomName:"Rittmann Theatre (R101)", floorNumber: text[12], floorMap: "R 1"),
                Room(roomName:"H305", floorNumber: text[2], floorMap: "HS 3"),
                Room(roomName:"H404", floorNumber: text[3], floorMap: "HS 4"),
                Room(roomName:"H403", floorNumber: text[3], floorMap: "HS 4"),
                Room(roomName:"New Luther (P201)", floorNumber: text[17], floorMap: "PC 2"),
                Room(roomName:"H205", floorNumber: text[1], floorMap: "HS 2"),
                Room(roomName:"Phoenix Center Gym (P106)", floorNumber: text[16], floorMap: "PC 1"),
                
                //Room(roomName:"MS and HS classrooms Schools???", floorNumber: text[0], floorMap: "HS 1"),
                Room(roomName:"Motor Skills Room",floorNumber: text[8], floorMap: "ES 1"),
                
                Room(roomName:"PE Commons", floorNumber: text[18], floorMap: "HS B1"),
                
                
                Room(roomName:"P232",floorNumber: text[17], floorMap: "PC 2"),
                Room(roomName:"P233",floorNumber: text[17], floorMap: "PC 2"),
                Room(roomName:"P234",floorNumber: text[17], floorMap: "PC 2"),
                Room(roomName:"P202",floorNumber: text[17], floorMap: "PC 2"),
                Room(roomName:"P203",floorNumber: text[17], floorMap: "PC 2"),
                Room(roomName:"P204",floorNumber: text[17], floorMap: "PC 2"),
                Room(roomName:"M101, MS Reception",floorNumber: text[6], floorMap: "MS 1"),
                Room(roomName:"M104",floorNumber: text[6], floorMap: "MS 1"),
                Room(roomName:"M105",floorNumber: text[6], floorMap: "MS 1"),
                Room(roomName:"M106",floorNumber: text[6], floorMap: "MS 1"),
                Room(roomName:"M107",floorNumber: text[6], floorMap: "MS 1"),
                Room(roomName:"M108",floorNumber: text[6], floorMap: "MS 1"),
                Room(roomName:"M109",floorNumber: text[6], floorMap: "MS 1"),
                Room(roomName:"M110",floorNumber: text[6], floorMap: "MS 1"),
                
                Room(roomName:"M201",floorNumber: text[7], floorMap: "MS 2"),
                Room(roomName:"M204",floorNumber: text[7], floorMap: "MS 2"),
                Room(roomName:"M205",floorNumber: text[7], floorMap: "MS 2"),
                Room(roomName:"M206",floorNumber: text[7], floorMap: "MS 2"),
                Room(roomName:"M207",floorNumber: text[7], floorMap: "MS 2"),
                Room(roomName:"M208",floorNumber: text[7], floorMap: "MS 2"),
                Room(roomName:"M209",floorNumber: text[7], floorMap: "MS 2"),
                Room(roomName:"M210",floorNumber: text[7], floorMap: "MS 2"),
                Room(roomName:"M211",floorNumber: text[7], floorMap: "MS 2"),
                Room(roomName:"M216",floorNumber: text[7], floorMap: "MS 2"),
                Room(roomName:"M223",floorNumber: text[7], floorMap: "MS 2"),
                Room(roomName:"P133",floorNumber: text[16], floorMap: "PC 1"),
                Room(roomName:"P134",floorNumber: text[16], floorMap: "PC 1"),
                Room(roomName:"M224",floorNumber: text[7], floorMap: "MS 2"),
                Room(roomName:"H118",floorNumber: text[0], floorMap: "HS 1"),
                Room(roomName:"H216", floorNumber: text[1], floorMap: "HS 2"),
                Room(roomName:"H306", floorNumber: text[2], floorMap: "HS 3"),
                Room(roomName:"H304", floorNumber: text[2], floorMap: "HS 3"),
                Room(roomName:"H303", floorNumber: text[2], floorMap: "HS 3"),
                Room(roomName:"H203", floorNumber: text[1], floorMap: "HS 2"),
                Room(roomName:"H204", floorNumber: text[1], floorMap: "HS 2"),
                Room(roomName:"H206", floorNumber: text[1], floorMap: "HS 2"),
                Room(roomName:"H429", floorNumber: text[3], floorMap: "HS 4"),
            ]
            
        }

        
        searchController = UISearchController(searchResultsController: resultsController)
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchResultsUpdater = self
        resultsController.tableView.backgroundView?.backgroundColor = UIColor(red: 248, green: 245, blue: 241, alpha: 1.0)
        resultsController.tableView.dataSource = self
        resultsController.tableView.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        searchController.hidesNavigationBarDuringPresentation = false
        //searchController.navigationBar.translucent = NO;
        //self.navigationController.navigationBar.translucent = NO;
        //searchController.searchBar.barTintColor = UIColor.black 248 245 241
        
    }

        
    
    func updateSearchResults(for searchController: UISearchController) {
        filtered = roomies.filter({(room:Room) -> Bool in
             return room.roomName.lowercased().contains(self.searchController.searchBar.text!.lowercased())
            
        })
        resultsController.tableView.reloadData()
    }
    
    
    
    // MARK: - Table view data source
        override  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if tableView == resultsController.tableView{
            return filtered.count
        }
        else {
            return roomies.count
        }
 
    }
    
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        if tableView == resultsController.tableView{
            //cells.removeAll()
            let cell = UITableViewCell()
            cell.textLabel?.text = filtered[indexPath.row].roomName
            cell.textLabel?.font = UIFont(name: "Avenir", size: 15)
            //cells.append(cell)
            return cell
        }
        else {
            //cells.removeAll()
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
            cell.textLabel?.text = roomies[indexPath.row].roomName
            cell.textLabel?.font = UIFont(name: "Avenir", size: 15)
            //cells.append(cell)
            return cell
        }
        
            
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        justfori = 0
        
        let indexPath = tableView.indexPathForSelectedRow //optional, to get from any UIButton for example
        
        //let currentCell = tableView.cellForRow(at: indexPath!) as! UITableViewCell
        let currentCell = tableView.cellForRow(at: indexPath!) as! UITableViewCell
        //row = currentCell.textLabel!.text!
        
        
        while justfori < roomies.count {
            if( currentCell.textLabel!.text! == roomies[justfori].roomName ) { //Title of room == title of room
                numberone = justfori                           //rowInt =
            }
            justfori += 1
        }
        
       // rowNum = cells.index
        //rowNum = cells.index(of: currentCell)!
            
            //roro.index(of: row)!
    
        if tableView == resultsController.tableView{
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "segueone", sender: nil)
            }
        }
            /*
        else {
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "segueone", sender: nil)
            }
        }
        */
        
    }
    /*
    func tableView(_ tableView: UITableView, didSelectRow indexPath: IndexPath) {
        
    }
    */
}
