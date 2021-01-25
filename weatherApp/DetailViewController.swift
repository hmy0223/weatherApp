import UIKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var detailTitle: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    var city: City?
    var weatherResult: Current?
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        getWeather()
    }
    
    func configureView() {
        detailTitle.text = city?.name
    }
    func getWeather() {
        NetworkService.shared.getWeather(onSuccess: { (result) in
            print(result)
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
    }
}
