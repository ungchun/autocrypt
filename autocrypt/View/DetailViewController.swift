import UIKit

class DetailViewController: UIViewController {
    
    var detailCenterData: Datum?
    
    let centerNameBackView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    let centerNameIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "hospital.png")
        return imageView
    }()
    let centerNameTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "센터명"
        return label
    }()
    var centerNameContent: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    lazy var centerNameStackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [centerNameIcon, centerNameTitle, centerNameContent])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.backgroundColor = .green
        stackView.spacing = 10
        stackView.alignment = .center
        return stackView
    }()
    
    let facilityNameBackView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    let facilityNameIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "building.png")
        return imageView
    }()
    let facilityNameTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "건물명"
        return label
    }()
    var facilityNameContent: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var facilityNameStackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [facilityNameIcon, facilityNameTitle, facilityNameContent])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.backgroundColor = .green
        stackView.spacing = 10
        stackView.alignment = .center
        return stackView
    }()
    
    let phoneNumberBackView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    let phoneNumberIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "telephone.png")
        return imageView
    }()
    let phoneNumberTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "전화번호"
        return label
    }()
    var phoneNumberContent: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    lazy var phoneNumberStackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [phoneNumberIcon, phoneNumberTitle, phoneNumberContent])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.backgroundColor = .green
        stackView.spacing = 10
        stackView.alignment = .center
        return stackView
    }()

    let updateAtBackView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    let updateAtIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "chat.png")
        return imageView
    }()
    let updateAtTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "업데이트 시간"
        return label
    }()
    var updateAtContent: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    lazy var updateAtStackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [updateAtIcon, updateAtTitle, updateAtContent])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.backgroundColor = .green
        stackView.spacing = 10
        stackView.alignment = .center
        return stackView
    }()
    
    let addressBackView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    let addressIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "placeholder.png")
        return imageView
    }()
    let addressTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "주소"
        return label
    }()
    var addressContent: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var addressStackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [addressIcon, addressTitle, addressContent])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.backgroundColor = .green
        stackView.spacing = 10
        stackView.alignment = .center
        return stackView
    }()
    
    
    init(detailCenterData: Datum) {
        super.init(nibName: nil, bundle: nil)
        self.detailCenterData = detailCenterData
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .gray
        
        centerNameContent.text = "centerNameContent"
        view.addSubview(centerNameBackView)
        centerNameBackView.addSubview(centerNameStackView)
        centerNameIcon.snp.makeConstraints { make in
            make.width.height.equalTo(30)
        }
        centerNameStackView.snp.makeConstraints { make in
            make.width.height.equalTo(150)
            make.center.equalToSuperview()
        }
        centerNameBackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.left.equalToSuperview().offset(10)
            make.width.height.equalTo(180)
        }
        
        facilityNameContent.text = "facilityNameContent"
        view.addSubview(facilityNameBackView)
        facilityNameBackView.addSubview(facilityNameStackView)
        facilityNameIcon.snp.makeConstraints { make in
            make.width.height.equalTo(30)
        }
        facilityNameStackView.snp.makeConstraints { make in
            make.width.height.equalTo(150)
            make.center.equalToSuperview()
        }
        facilityNameBackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.right.equalToSuperview().offset(-10)
            make.width.height.equalTo(180)
        }
        
        phoneNumberContent.text = "phoneNumberContent"
        view.addSubview(phoneNumberBackView)
        phoneNumberBackView.addSubview(phoneNumberStackView)
        phoneNumberIcon.snp.makeConstraints { make in
            make.width.height.equalTo(30)
        }
        phoneNumberStackView.snp.makeConstraints { make in
            make.width.height.equalTo(150)
            make.center.equalToSuperview()
        }
        phoneNumberBackView.snp.makeConstraints { make in
            make.top.equalTo(centerNameBackView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(10)
            make.width.height.equalTo(180)
        }
        
        updateAtContent.text = "updateAtContent"
        view.addSubview(updateAtBackView)
        updateAtBackView.addSubview(updateAtStackView)
        updateAtIcon.snp.makeConstraints { make in
            make.width.height.equalTo(30)
        }
        updateAtStackView.snp.makeConstraints { make in
            make.width.height.equalTo(150)
            make.center.equalToSuperview()
        }
        updateAtBackView.snp.makeConstraints { make in
            make.top.equalTo(facilityNameBackView.snp.bottom).offset(20)
            make.right.equalToSuperview().offset(-10)
            make.width.height.equalTo(180)
        }
        
        addressContent.text = "addressContent"
        view.addSubview(addressBackView)
        addressBackView.addSubview(addressStackView)
        addressIcon.snp.makeConstraints { make in
            make.width.height.equalTo(30)
        }
        addressStackView.snp.makeConstraints { make in
            make.width.height.equalTo(150)
            make.center.equalToSuperview()
        }
        addressBackView.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberBackView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(180)
        }
        guard let detailCenterData else { return }
        centerNameContent.text = detailCenterData.centerName
        facilityNameContent.text = detailCenterData.facilityName
        phoneNumberContent.text = detailCenterData.phoneNumber
        updateAtContent.text = detailCenterData.updatedAt
        addressContent.text = detailCenterData.address
        
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
