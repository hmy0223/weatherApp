//
//  ViewController.swift
//  weatherApp
//
//  Created by Ho Man Yee on 19/1/2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var searchByCity: UISearchBar!
    @IBOutlet weak var GPSButton: UIButton!
    @IBOutlet weak var cityList: UITableView!
    
    var cities: [City] = []
    let cellReuseIdentifier = "cell"
    var filteredCandies: [City] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        cities = City.cities()

        self.cityList.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        cityList.delegate = self
        cityList.dataSource = self

    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchByCity: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ cityList: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cities.count
    }
    
    func tableView(_ cityList: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cityList.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let city: City
        city = cities[indexPath.row]
        cell.textLabel?.text = city.name
        return cell
    }
    func tableView(_ cityList: UITableView, didSelectRowAt indexPath: IndexPath) {
            print("You tapped cell number \(indexPath.row).")
        }
    
}
