import UIKit

class MapViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        
        self.title = "지도"
        self.navigationController?.navigationBar.topItem?.backButtonTitle = "Back"
    }
}
