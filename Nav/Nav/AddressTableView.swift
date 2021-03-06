

import UIKit
import MapKit

class AddressTableView: UITableView {
  
  var mainViewController: ViewController!
  var addresses: [String]!
  var placemarkArray: [CLPlacemark]!
  var currentTextField: UITextField!
  var sender: UIButton!
  
  override init(frame: CGRect, style: UITableViewStyle) {
    super.init(frame: frame, style: style)
    self.register(UITableViewCell.self, forCellReuseIdentifier: "AddressCell")
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}

extension AddressTableView: UITableViewDelegate {

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 50
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 80
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let label = UILabel()
    label.font = UIFont(name: "HoeflerText-Black", size: 18)
    label.textAlignment = .center
    label.text = "Вы имели ввиду ..."
    label.backgroundColor = UIColor(red: 240.0/255.0, green: 229.0/255.0, blue: 141.0/225.0, alpha: 1)
    
    return label
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if addresses.count > indexPath.row {
      currentTextField.text = addresses[indexPath.row]
      
      let mapItem = MKMapItem(placemark:
        MKPlacemark(coordinate: placemarkArray[indexPath.row].location!.coordinate,
                    addressDictionary: placemarkArray[indexPath.row].addressDictionary
                      as! [String:AnyObject]?))
      mainViewController.locationTuples[currentTextField.tag-1].mapItem = mapItem
      
      sender.isSelected = true
    }
    
    removeFromSuperview()
  }
}

extension AddressTableView: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return addresses.count + 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "AddressCell") as UITableViewCell!
    cell?.textLabel?.numberOfLines = 3
    cell?.textLabel?.font = UIFont(name: "HoeflerText-Regular", size: 11)
    
    if addresses.count > indexPath.row {
      cell?.textLabel?.text = addresses[indexPath.row]
    } else {
      cell?.textLabel?.text = "Ни один не подходит"
      cell?.textLabel?.textColor = UIColor.red
    }
    return cell!
  }
}
