//
//  PinnedCollectionViewCell.swift
//  SnapKit-Homework
//
//  Created by Олег Романов on 03.03.2022.
//

import UIKit
import SnapKit

class PinnedCollectionViewCell: UICollectionViewCell {

    // MARK: - Constants

    enum Constants {
        enum Numbers {
            static let imageWidth: CGFloat = 48
            static let two: CGFloat = 2
            static let fontSize: CGFloat = 13
        }

        enum Constraints {
            static let labelTop: CGFloat = 8
        }
    }

    // MARK: - Instance Properties

    private lazy var profileImage: UIImageView = {
        var imageView = UIImageView()
        imageView.layer.cornerRadius = Constants.Numbers.imageWidth / Constants.Numbers.two

        return imageView
    }()

    private lazy var nameLabel: UILabel = {
        var label = UILabel()
        label.font = .habibiFont(style: .regular, size: Constants.Numbers.fontSize)
        label.tintColor = .black

        return label
    }()

    // MARK: - Instance Methods

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        makeConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addSubviews() {
        contentView.addSubview(profileImage)
        contentView.addSubview(nameLabel)
    }

    private func makeConstraints() {
        profileImage.snp.makeConstraints { make in
            make.size.equalTo(Constants.Numbers.imageWidth)
            make.top.centerX.equalToSuperview()
        }

        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.bottom).offset(Constants.Constraints.labelTop)
            make.centerX.equalTo(profileImage)
        }
    }

    // MARK: - Public Methods

    func configure(image: UIImage, name: String) {
        profileImage.image = image
        nameLabel.text = name
    }
}
