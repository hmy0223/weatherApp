import UIKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var detailTitle: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    var city: City?
    var selectedCity: String = ""
    var weatherResult: Current?
    override func viewDidLoad() {
      guard let selectedCity = city else {
            return
        }
        super.viewDidLoad()
        configureView()
        getWeather(selectedCity: selectedCity.name)
    }
    
    func configureView() {
        detailTitle.text = city?.name
    }
    func getWeather(selectedCity: String) {
        NetworkService.shared.getWeather(parsedCity: selectedCity, onSuccess: { (result) in
            self.weatherResult = result
            self.updateView()

        }) { (errorMessage) in
            debugPrint(errorMessage)
        }
    }
    func updateView() {
        guard let weatherResult = weatherResult else {
            return
        }
        weatherLabel.text = weatherResult.weather[0].weatherDescription.capitalized
        let tempCelsius = weatherResult.main.temp - 273.15
        tempLabel.text = String(round(tempCelsius)) + "°C"
    }
}
