import UIKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var detailTitle: UILabel!
    var city: City?
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func configureView() {
        detailTitle.text = city?.name
    }
}
