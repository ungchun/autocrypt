import UIKit
import RxSwift
import RxCocoa
import SnapKit

class CenterViewController: UIViewController {
    
    // MARK: - Properites
    //
    private let disposeBag = DisposeBag()
    private let viewModel: CenterViewModel
    
    // MARK: Views
    //
    private let centerTableView = UITableView()
    private let refreshControl = UIRefreshControl()
    private let scrollToTopButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "top-alignment.png"), for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 30
        button.clipsToBounds = true
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.masksToBounds = false
        button.layer.shadowOffset = CGSize(width: 10, height: 10)
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 0.3
        return button
    }()
    private let navigationBar : UINavigationBar = {
        let navigationBar = UINavigationBar()
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        return navigationBar
    }()
    
    // MARK: - init
    //
    init() {
        self.viewModel = CenterViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life Cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        makeConstraints()
        setupAttribute()
        setupBindings()
    }
    
    // MARK: functions
    //
    private func addSubviews() {
        view.addSubview(centerTableView)
        view.addSubview(scrollToTopButton)
    }
    private func makeConstraints() {
        centerTableView.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview()
        }
        scrollToTopButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-30)
            make.bottom.equalToSuperview().offset(-60)
            make.width.height.equalTo(60)
        }
    }
    private func setupAttribute() {
        centerTableView.register(CenterListTableViewCell.self, forCellReuseIdentifier: CenterListTableViewCell.reuseIdentifier)
        centerTableView.refreshControl = refreshControl
        centerTableView.rowHeight = 100
        
        setupNavigationBar()
    }
    private func setupNavigationBar() {
        self.title = "예방접종센터 리스트"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = self.navigationController?.navigationBar.standardAppearance
    }
    private func setupBindings() {
        viewModel.centerObservable
            .observe(on: MainScheduler.instance)
            .bind(to: centerTableView.rx.items(cellIdentifier: CenterListTableViewCell.reuseIdentifier, cellType: CenterListTableViewCell.self)) { index, item, cell in
                cell.updateUI(item)
                cell.selectionStyle = .none
            }
            .disposed(by: disposeBag)
        
        refreshControl.rx.controlEvent(.valueChanged)
            .observe(on: MainScheduler.instance)
            .bind(onNext: { [weak self] _ in
                self?.viewModel.refreshData()
                self?.refreshControl.endRefreshing()
            })
            .disposed(by: disposeBag)
        
        centerTableView.rx.modelSelected(Datum.self)
            .subscribe { [weak self] centerData in
                let detailViewController = DetailViewController(detailCenterData: centerData)
                self?.navigationController?.pushViewController(detailViewController, animated: true)
            }
            .disposed(by: disposeBag)
        
        centerTableView.rx.didScroll
            .subscribe { [weak self] _ in
                guard let offSetY = self?.centerTableView.contentOffset.y else { return }
                guard let contentHeight = self?.centerTableView.contentSize.height else { return }
                if offSetY > (contentHeight - ((self?.centerTableView.frame.height)!) - 20) {
                    guard let viewModel = self?.viewModel else { return }
                    if !viewModel.isFetch && viewModel.isNext {
                        viewModel.getCenterData()
                    }
                }
            }
            .disposed(by: disposeBag)
        
        scrollToTopButton.rx.tap
            .bind { [weak self] in
                let indexPath = IndexPath(row: 0, section: 0)
                self?.centerTableView.scrollToRow(at: indexPath, at: .top, animated: true)
            }
            .disposed(by: disposeBag)
    }
}
