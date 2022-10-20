import UIKit

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .gray
        
        self.title = "센터명"
        self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
        let button1 = UIBarButtonItem(title: "지도", style: .plain, target: self, action: #selector(mapTap))
        self.navigationItem.rightBarButtonItem  = button1

    }
    @objc private func mapTap() {
        print("mapTap")
        let mapVC = MapViewController()
        navigationController?.pushViewController(mapVC, animated: true)
    }
}
