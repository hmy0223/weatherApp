//
//  ViewController.swift
//  weatherApp
//
//  Created by Ho Man Yee on 19/1/2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchByCity: UISearchBar!
    @IBOutlet weak var GPSButton: UIButton!
    @IBOutlet weak var cityList: UITableView!
    @IBOutlet weak var tableView: UITableView!
    
    var cities: [City?] = []
    var searchCities: [City?] = []
    let cellReuseIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        cities = City.cities()

        self.cityList.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        cityList.delegate = self
        cityList.dataSource = self
        
        if searchCities.isEmpty {
            searchCities = cities
        }

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      guard
        segue.identifier == "showDetail",
        let indexPath = cityList.indexPathForSelectedRow,
        let detailViewController = segue.destination as? DetailViewController
        else {
          return
      }
        detailViewController.city = searchCities[indexPath.row]
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchByCity: UISearchBar, textDidChange searchText: String) {
        searchCities = cities.compactMap{$0}.filter {
            $0.name.contains(searchText)
        }
        if searchText.isEmpty {
            searchCities = cities
        }
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ cityList: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchCities.count
    }
    
    func tableView(_ cityList: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cityList.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let city: City?
        city = searchCities[indexPath.row]
        cell.textLabel?.text = city?.name
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ cityList: UITableView, didSelectRowAt indexPath: IndexPath) {
            print("You tapped cell number \(indexPath.row).")
        performSegue(withIdentifier: "showDetail", sender: self)
    }
}
