import UIKit
import SnapKit
import RxCocoa

class DetailViewController: UIViewController {
    
    // MARK: Properties
    //
    var detailCenterData: Datum?
    
    // MARK: Views
    //
    private let centerNameBackView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.layer.shadowColor = UIColor.black.cgColor // 색깔
        view.layer.masksToBounds = false  // 내부에 속한 요소들이 UIView 밖을 벗어날 때, 잘라낼 것인지. 그림자는 밖에 그려지는 것이므로 false 로 설정
        view.layer.shadowOffset = CGSize(width: 10, height: 10) // 위치조정
        view.layer.shadowRadius = 5 // 반경
        view.layer.shadowOpacity = 0.3 // alpha값
        return view
    }()
    private let centerNameIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "hospital.png")
        return imageView
    }()
    private let centerNameTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "센터명"
        label.font = UIFont.systemFont(ofSize: CommonSize.LabelFontSize)
        return label
    }()
    private var centerNameContent: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = CommonSize.LabelNumberOfLinesValue
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: CommonSize.LabelFontSize)
        return label
    }()
    private lazy var centerNameStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [centerNameIcon, centerNameTitle, centerNameContent])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = CommonSize.StackViewSpacingValue
        stackView.alignment = .center
        return stackView
    }()
    
    private let facilityNameBackView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.masksToBounds = false
        view.layer.shadowOffset = CGSize(width: 10, height: 10)
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.3
        return view
    }()
    private let facilityNameIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "building.png")
        return imageView
    }()
    private let facilityNameTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "건물명"
        label.font = UIFont.systemFont(ofSize: CommonSize.LabelFontSize)
        return label
    }()
    private var facilityNameContent: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = CommonSize.LabelNumberOfLinesValue
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: CommonSize.LabelFontSize)
        return label
    }()
    private lazy var facilityNameStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [facilityNameIcon, facilityNameTitle, facilityNameContent])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = CommonSize.StackViewSpacingValue
        stackView.alignment = .center
        return stackView
    }()
    
    private let phoneNumberBackView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.masksToBounds = false
        view.layer.shadowOffset = CGSize(width: 10, height: 10)
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.3
        return view
    }()
    private let phoneNumberIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "telephone.png")
        return imageView
    }()
    private let phoneNumberTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "전화번호"
        label.font = UIFont.systemFont(ofSize: CommonSize.LabelFontSize)
        return label
    }()
    private var phoneNumberContent: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = CommonSize.LabelNumberOfLinesValue
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: CommonSize.LabelFontSize)
        return label
    }()
    private lazy var phoneNumberStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [phoneNumberIcon, phoneNumberTitle, phoneNumberContent])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = CommonSize.StackViewSpacingValue
        stackView.alignment = .center
        return stackView
    }()
    
    private let updateAtBackView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.masksToBounds = false
        view.layer.shadowOffset = CGSize(width: 10, height: 10)
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.3
        return view
    }()
    private let updateAtIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "chat.png")
        return imageView
    }()
    private let updateAtTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "업데이트 시간"
        label.font = UIFont.systemFont(ofSize: CommonSize.LabelFontSize)
        return label
    }()
    private var updateAtContent: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = CommonSize.LabelNumberOfLinesValue
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: CommonSize.LabelFontSize)
        return label
    }()
    private lazy var updateAtStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [updateAtIcon, updateAtTitle, updateAtContent])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = CommonSize.StackViewSpacingValue
        stackView.alignment = .center
        return stackView
    }()
    
    private let addressBackView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.masksToBounds = false
        view.layer.shadowOffset = CGSize(width: 10, height: 10)
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.3
        return view
    }()
    private let addressIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "placeholder.png")
        return imageView
    }()
    private let addressTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "주소"
        label.font = UIFont.systemFont(ofSize: CommonSize.LabelFontSize)
        return label
    }()
    private var addressContent: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: CommonSize.LabelFontSize)
        return label
    }()
    private lazy var addressStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [addressIcon, addressTitle, addressContent])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = CommonSize.StackViewSpacingValue
        stackView.alignment = .center
        return stackView
    }()
    
    // MARK: init
    //
    init(detailCenterData: Datum) {
        self.detailCenterData = detailCenterData
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life Cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        
        addSubviews()
        makeConstraints()
        setupAttribute()
    }
    
    // MARK: functions
    //
    private func addSubviews() {
        view.addSubview(centerNameBackView)
        view.addSubview(facilityNameBackView)
        view.addSubview(phoneNumberBackView)
        view.addSubview(updateAtBackView)
        view.addSubview(addressBackView)
        
        centerNameBackView.addSubview(centerNameStackView)
        facilityNameBackView.addSubview(facilityNameStackView)
        phoneNumberBackView.addSubview(phoneNumberStackView)
        updateAtBackView.addSubview(updateAtStackView)
        addressBackView.addSubview(addressStackView)
    }
    private func makeConstraints() {
        centerNameIcon.snp.makeConstraints { make in
            make.width.height.equalTo(CommonSize.IconSize)
        }
        centerNameStackView.snp.makeConstraints { make in
            make.width.equalTo(CommonSize.CardSectionStackViewSize)
            make.center.equalToSuperview()
        }
        centerNameBackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.left.equalToSuperview().offset(CommonSize.PaddingValue)
            make.width.equalTo(CommonSize.CardSectionBackFrameWidthSize)
            make.height.equalTo(CommonSize.CardSectionBackFrameHeightSize)
        }
        
        facilityNameIcon.snp.makeConstraints { make in
            make.width.height.equalTo(CommonSize.IconSize)
        }
        facilityNameStackView.snp.makeConstraints { make in
            make.width.equalTo(CommonSize.CardSectionStackViewSize)
            make.center.equalToSuperview()
        }
        facilityNameBackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.right.equalToSuperview().offset(-CommonSize.PaddingValue)
            make.width.equalTo(CommonSize.CardSectionBackFrameWidthSize)
            make.height.equalTo(CommonSize.CardSectionBackFrameHeightSize)
            
        }
        
        phoneNumberIcon.snp.makeConstraints { make in
            make.width.height.equalTo(CommonSize.IconSize)
        }
        phoneNumberStackView.snp.makeConstraints { make in
            make.width.equalTo(CommonSize.CardSectionStackViewSize)
            make.center.equalToSuperview()
        }
        phoneNumberBackView.snp.makeConstraints { make in
            make.top.equalTo(centerNameBackView.snp.bottom).offset(CommonSize.PaddingValue)
            make.left.equalToSuperview().offset(CommonSize.PaddingValue)
            make.width.equalTo(CommonSize.CardSectionBackFrameWidthSize)
            make.height.equalTo(CommonSize.CardSectionBackFrameHeightSize)
        }
        
        updateAtIcon.snp.makeConstraints { make in
            make.width.height.equalTo(CommonSize.IconSize)
        }
        updateAtStackView.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.center.equalToSuperview()
        }
        updateAtBackView.snp.makeConstraints { make in
            make.top.equalTo(facilityNameBackView.snp.bottom).offset(CommonSize.PaddingValue)
            make.right.equalToSuperview().offset(-CommonSize.PaddingValue)
            make.width.equalTo(CommonSize.CardSectionBackFrameWidthSize)
            make.height.equalTo(CommonSize.CardSectionBackFrameHeightSize)
        }
        
        addressIcon.snp.makeConstraints { make in
            make.width.height.equalTo(CommonSize.IconSize)
        }
        addressStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        addressBackView.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberBackView.snp.bottom).offset(CommonSize.PaddingValue)
            make.left.equalToSuperview().offset(CommonSize.PaddingValue)
            make.right.equalToSuperview().offset(-CommonSize.PaddingValue)
            make.height.equalTo(CommonSize.CardSectionBackFrameHeightSize)
        }
    }
    private func setupAttribute() {
        guard let detailCenterData else { return }
        centerNameContent.text = detailCenterData.centerName
        facilityNameContent.text = detailCenterData.facilityName
        phoneNumberContent.text = detailCenterData.phoneNumber
        updateAtContent.text = detailCenterData.updatedAt
        addressContent.text = detailCenterData.address
        
        setupNavigationBar()
    }
    private func setupNavigationBar() {
        guard let detailCenterData else { return }
        self.title = detailCenterData.centerName
        self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
        let mapBtn = UIBarButtonItem(title: "지도", style: .plain, target: self, action: #selector(mapBtnTap))
        self.navigationItem.rightBarButtonItem = mapBtn
    }
    @objc private func mapBtnTap() {
        guard let detailCenterData else { return }
        let mapVC = MapViewController()
        mapVC.longitude = Double(detailCenterData.lng)
        mapVC.latitude = Double(detailCenterData.lat)
        navigationController?.pushViewController(mapVC, animated: true)
    }
}
