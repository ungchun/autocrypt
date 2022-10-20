import UIKit
import SnapKit

class CenterViewController: UIViewController {
    
    private let tableView = UITableView()
    let navigationBar : UINavigationBar = {
        let navigationBar = UINavigationBar()
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        return navigationBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CenterListTableViewCell.self, forCellReuseIdentifier: CenterListTableViewCell.reuseIdentifier)
        tableView.rowHeight = 100
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview()
        }
        
        self.title = "예방접종센터 리스트"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        self.navigationController!.navigationBar.standardAppearance = appearance;
        self.navigationController!.navigationBar.scrollEdgeAppearance = self.navigationController!.navigationBar.standardAppearance
    }
}

extension CenterViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CenterListTableViewCell.reuseIdentifier, for: indexPath)
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        navigationController?.pushViewController(detailViewController, animated: true)
        print("click \(indexPath)")
    }
}
