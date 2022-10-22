import UIKit
import SnapKit
import RxSwift

class CenterListTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = String(describing: CenterListTableViewCell.self)
    
    // MARK: Views
    //
    private let centerNameTitle: UILabel = {
        let label = UILabel()
        label.text = "센터명"
        label.font = UIFont.systemFont(ofSize: CommonSize.LabelFontSize)
        label.textColor = .gray
        return label
    }()
    private let facilityNameTitle: UILabel = {
        let label = UILabel()
        label.text = "건물명"
        label.font = UIFont.systemFont(ofSize: CommonSize.LabelFontSize)
        label.textColor = .gray
        return label
    }()
    private let addressTitle: UILabel = {
        let label = UILabel()
        label.text = "주소"
        label.font = UIFont.systemFont(ofSize: CommonSize.LabelFontSize)
        label.textColor = .gray
        return label
    }()
    private let updateAtTitle: UILabel = {
        let label = UILabel()
        label.text = "업데이트 시간"
        label.font = UIFont.systemFont(ofSize: CommonSize.LabelFontSize)
        label.textColor = .gray
        return label
    }()
    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [centerNameTitle, facilityNameTitle, addressTitle, updateAtTitle])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let centerNameContent: UILabel = {
        let label = UILabel()
        label.text = "centerNameContent"
        label.font = UIFont.systemFont(ofSize: CommonSize.LabelFontSize)
        return label
    }()
    private let facilityNameContent: UILabel = {
        let label = UILabel()
        label.text = "facilityNameContent"
        label.font = UIFont.systemFont(ofSize: CommonSize.LabelFontSize)
        return label
    }()
    private let addressContent: UILabel = {
        let label = UILabel()
        label.text = "addressContent"
        label.font = UIFont.systemFont(ofSize: CommonSize.LabelFontSize)
        return label
    }()
    private let updateAtContent: UILabel = {
        let label = UILabel()
        label.text = "updateAtContent"
        label.font = UIFont.systemFont(ofSize: CommonSize.LabelFontSize)
        return label
    }()
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [centerNameContent, facilityNameContent, addressContent, updateAtContent])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
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
    
    // MARK: init
    //
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        makeConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUI(_ item: Datum) {
        centerNameContent.text = item.centerName
        facilityNameContent.text = item.facilityName
        addressContent.text = item.address
        updateAtContent.text = item.updatedAt
    }
    
    // MARK: functions
    //
    private func addSubviews() {
        contentView.addSubview(allContentStackView)
    }
    private func makeConstraints() {
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
