//
//  ChatTableViewCell.swift
//  SnapKit-Homework
//
//  Created by Олег Романов on 03.03.2022.
//

import UIKit
import SnapKit

class ChatTableViewCell: UITableViewCell {

    // MARK: - Constants

    enum Constants {
        enum Colors {
            static let lightBlack = "lightBlack"
            static let grayText = "grayText"
        }

        enum Numbers {
            static let imageWidth: CGFloat = 40
            static let fontSize: CGFloat = 14
            static let dateFontSize: CGFloat = 12
            static let stackViewSpacing: Int = 4
        }

        enum Constraints {
            static let imageTopBottom: CGFloat = 26
            static let imageLeading: CGFloat = 24
            static let stackViewLeading: CGFloat = 8
        }
    }

    // MARK: - Instance Properties

    private lazy var profileImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = Constants.Numbers.imageWidth / 2

        return image
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .habibiFont(style: .regular, size: Constants.Numbers.fontSize)
        label.textColor = UIColor(named: Constants.Colors.lightBlack)

        return label
    }()

    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.font = .habibiFont(style: .regular, size: Constants.Numbers.fontSize)
        label.textColor = UIColor(named: Constants.Colors.grayText)

        return label
    }()

    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .habibiFont(style: .regular, size: Constants.Numbers.dateFontSize)

        return label
    }()

    private lazy var textStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.spacing = Constants.Constraints.stackViewLeading
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(messageLabel)

        return stackView
    }()

    // MARK: - Instance Methods

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        makeConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addSubviews() {
        contentView.addSubview(profileImageView)
        contentView.addSubview(textStackView)
        contentView.addSubview(dateLabel)
        contentView.backgroundColor = .white
    }

    private func makeConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Constants.Constraints.imageTopBottom)
            make.bottom.equalToSuperview().inset(Constants.Constraints.imageTopBottom)
            make.leading.equalToSuperview().inset(Constants.Constraints.imageLeading)
        }
        textStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(profileImageView.snp.trailing).offset(Constants.Constraints.stackViewLeading)
        }
        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Constants.Constraints.imageLeading)
            make.trailing.equalToSuperview().inset(Constants.Constraints.imageLeading)
        }
    }

    // MARK: - Public Methods

    func configure(image: UIImage, name: String, message: String, date: String) {
        self.profileImageView.image = image
        self.nameLabel.text = name
        self.messageLabel.text = message
        self.dateLabel.text = date
    }
}
