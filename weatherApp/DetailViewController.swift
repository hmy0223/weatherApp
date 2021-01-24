import UIKit

class DetailViewController: UIViewController {
  @IBOutlet weak var detailDescriptionLabel: UILabel!
  @IBOutlet weak var candyImageView: UIImageView!
  
  var city: City? {
    didSet {
      configureView()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureView()
  }
  
  func configureView() {
//    if let city = city,
//      let detailDescriptionLabel = detailDescriptionLabel,
//      let candyImageView = candyImageView {
//      detailDescriptionLabel.text = city.name
//      candyImageView.image = UIImage(named: city.name)
//      title = city.name
//    }
  }
}
