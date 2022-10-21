import UIKit
import SnapKit
import RxSwift
import RxCocoa

class CenterViewController: UIViewController {
    
    private let tableView = UITableView()
    let navigationBar : UINavigationBar = {
        let navigationBar = UINavigationBar()
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        return navigationBar
    }()
    
    private let disposeBag = DisposeBag()
    private let viewModel: CenterViewModel
    
    init(viewModel: CenterViewModel = CenterViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        viewModel = CenterViewModel()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        
        
        tableView.register(CenterListTableViewCell.self, forCellReuseIdentifier: CenterListTableViewCell.reuseIdentifier)
        tableView.rowHeight = 100
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview()
        }
        
        // binding
        viewModel.centerObservable
            .observe(on: MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier: CenterListTableViewCell.reuseIdentifier, cellType: CenterListTableViewCell.self)) { index, item, cell in
                cell.centerNameContent.text = item.centerName
                cell.facilityNameContent.text = item.facilityName
                cell.addressContent.text = item.address
                cell.updateAtContent.text = item.updatedAt
                cell.selectionStyle = .none
            }.disposed(by: disposeBag)
        
        // tableView cell 클릭
        tableView
            .rx
            .modelSelected(Datum.self)
            .subscribe { [weak self] dummyCenterData in
                let detailViewController = DetailViewController(detailCenterData: dummyCenterData)
                self?.navigationController?.pushViewController(detailViewController, animated: true)
            }.disposed(by: disposeBag)
        
        self.title = "예방접종센터 리스트"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        self.navigationController!.navigationBar.standardAppearance = appearance;
        self.navigationController!.navigationBar.scrollEdgeAppearance = self.navigationController!.navigationBar.standardAppearance
    }
}