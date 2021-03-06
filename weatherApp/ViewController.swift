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
    
    var cities: [City] = []
    var searchCities: [City] = []
    let cellReuseIdentifier = "cell"
    var citySearcher: CitySearcher?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        cities = City.cities()
        citySearcher = CitySearcher(cities: cities)

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
        searchCities = citySearcher!.search(city: searchText)
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
        performSegue(withIdentifier: "showDetail", sender: self)
    }
}

class CitySearcher {
    var  cities: [City?]
    init(cities: [City?]) {
        self.cities = cities
    }
    func search(city text: String) -> [City] {
        var searchCities = cities.compactMap{$0}.filter {
            $0.name.lowercased().contains(text.lowercased())
        }.filter{
            $0.name.lowercased().hasPrefix(text.lowercased())
        }
        if text.isEmpty {
            searchCities = cities.compactMap{$0}
        }
        return searchCities
    }
}
