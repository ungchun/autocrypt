import UIKit

class CenterListTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "CenterListTableViewCell"
    
    private let centerNameTitle: UILabel = {
        let label = UILabel()
        label.text = "센터명"
        label.textColor = .gray
        return label
    }()
    private let facilityNameTitle: UILabel = {
        let label = UILabel()
        label.text = "건물명"
        label.textColor = .gray
        return label
    }()
    private let addressTitle: UILabel = {
        let label = UILabel()
        label.text = "주소"
        label.textColor = .gray
        return label
    }()
    private let updateAtTitle: UILabel = {
        let label = UILabel()
        label.text = "업데이트 시간"
        label.textColor = .gray
        return label
    }()
    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [centerNameTitle, facilityNameTitle, addressTitle, updateAtTitle])
        stackView.axis = .vertical
        stackView.backgroundColor = .green
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var centerNameContent: UILabel = {
        let label = UILabel()
        label.text = "centerNameContent"
        return label
    }()
    var facilityNameContent: UILabel = {
        let label = UILabel()
        label.text = "facilityNameContent"
        return label
    }()
    var addressContent: UILabel = {
        let label = UILabel()
        label.text = "addressContent"
        return label
    }()
    var updateAtContent: UILabel = {
        let label = UILabel()
        label.text = "updateAtContent"
        return label
    }()
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [centerNameContent, facilityNameContent, addressContent, updateAtContent])
        stackView.axis = .vertical
        stackView.backgroundColor = .gray
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var allContentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleStackView, contentStackView])
        stackView.axis = .horizontal
//        stackView.distribution = .fillProportionally
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
        
        titleStackView.snp.makeConstraints { make in
            make.width.equalTo(150)
        }
        
        contentView.addSubview(allContentStackView)

        allContentStackView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }

    }
}
