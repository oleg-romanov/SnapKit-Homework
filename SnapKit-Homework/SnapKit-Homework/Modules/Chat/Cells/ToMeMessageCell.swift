//
//  ToMeMessageCell.swift
//  SnapKit-Homework
//
//  Created by Олег Романов on 03.03.2022.
//

import UIKit

class ToMeMessageCell: UITableViewCell {

    // MARK: - Instance Properties

    private lazy var profileImage = UIImageView()

    private lazy var messageView: ChatView = {
        let view = ChatView()
        view.makeRoundedCorners(from: false)
        view.backgroundColor = UIColor(named: "Colors/toMeMessageColor")
        view.textLabel.textColor = .black

        return view
    }()

    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = .habibiFont(style: .regular, size: 12)
        label.textColor = UIColor(named: "Colors/blackDateColor")

        return label
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
        contentView.addSubview(messageView)
        contentView.addSubview(timeLabel)
        contentView.addSubview(profileImage)
    }

    private func makeConstraints() {
        profileImage.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(24)
            make.leading.equalToSuperview().inset(20)
            make.height.width.equalTo(24)
        }
        messageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(24)
            make.width.lessThanOrEqualTo(268)
            make.leading.equalTo(profileImage.snp.trailing).inset(-4)
        }
        timeLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.top.equalTo(messageView.snp.bottom)
            make.trailing.equalTo(messageView.snp.trailing)
        }
    }

    // MARK: - Public Methods

    func config(text: String, date: String, image: UIImage) {
        messageView.textLabel.text = text
        timeLabel.text = date
        profileImage.image = image
    }
}

