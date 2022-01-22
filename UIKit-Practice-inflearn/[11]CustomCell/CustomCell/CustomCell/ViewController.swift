//
//  ViewController.swift
//  CustomCell
//
//  Created by 임영선 on 2021/08/18.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var itemlist = [[String:String]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        let item1 = ["name":"사과","image":"apple.jpeg","amount":"3","value":"1000원"]
        let item2 = ["name":"블루베리","image":"blueberry.jpg","amount":"4","value":"2000원"]
        let item3 = ["name":"당근","image":"carrot.jpg","amount":"5","value":"500원"]
        let item4 = ["name":"체리","image":"cherry.png","amount":"7","value":"5000원"]
        let item5 = ["name":"포도","image":"grape.jpg","amount":"2","value":"3000원"]
        let item6 = ["name":"키위","image":"kiwi.png","amount":"3","value":"3500원"]
        let item7 = ["name":"레몬","image":"lemon.png","amount":"1","value":"4000원"]
        let item8 = ["name":"라임","image":"lime.jpg","amount":"9","value":"4500원"]
        
        itemlist = [item1,item2,item3,item4,item5,item6,item7,item8]
        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
        let dicTemp = itemlist[indexPath.row]
        cell.backgroundColor = UIColor.clear
        cell.nameLabel.text = dicTemp["name"]
        cell.amountLabel.text = dicTemp["amount"]
        cell.valueLabel.text = dicTemp["value"]
        cell.imgView.image = UIImage(named: dicTemp["image"]!)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail"{
            (segue.destination as! DetailViewController).detaildata = itemlist[tableView.indexPathForSelectedRow!.row]
        }
    }

}

