import UIKit

class CenterListTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "CenterListTableViewCell"
    
    private let centerNameTitle: UILabel = {
        let label = UILabel()
        label.text = "센터명"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14.0)
        return label
    }()
    private let facilityNameTitle: UILabel = {
        let label = UILabel()
        label.text = "건물명"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14.0)
        return label
    }()
    private let addressTitle: UILabel = {
        let label = UILabel()
        label.text = "주소"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14.0)
        return label
    }()
    private let updateAtTitle: UILabel = {
        let label = UILabel()
        label.text = "업데이트 시간"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14.0)
        return label
    }()
    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [centerNameTitle, facilityNameTitle, addressTitle, updateAtTitle])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var centerNameContent: UILabel = {
        let label = UILabel()
        label.text = "centerNameContent"
        label.font = UIFont.systemFont(ofSize: 14.0)
        return label
    }()
    var facilityNameContent: UILabel = {
        let label = UILabel()
        label.text = "facilityNameContent"
        label.font = UIFont.systemFont(ofSize: 14.0)
        return label
    }()
    var addressContent: UILabel = {
        let label = UILabel()
        label.text = "addressContent"
        label.font = UIFont.systemFont(ofSize: 14.0)
        return label
    }()
    var updateAtContent: UILabel = {
        let label = UILabel()
        label.text = "updateAtContent"
        label.font = UIFont.systemFont(ofSize: 14.0)
        return label
    }()
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [centerNameContent, facilityNameContent, addressContent, updateAtContent])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 5
        return stackView
    }()
    
    private lazy var allContentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleStackView, contentStackView])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        setupLayout()
    }
    
    private func setupLayout() {
        
        contentView.addSubview(allContentStackView)
        
        titleStackView.snp.makeConstraints { make in
            make.width.equalTo(100)
        }
        
        allContentStackView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.bottom.equalToSuperview()
        }


    }
}
