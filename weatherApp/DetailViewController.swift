import UIKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var detailTitle: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    var city: City?
    var weatherResult: Result?
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
        weatherLabel.text = weatherResult.current.weather[0].description.capitalized
    }
}
