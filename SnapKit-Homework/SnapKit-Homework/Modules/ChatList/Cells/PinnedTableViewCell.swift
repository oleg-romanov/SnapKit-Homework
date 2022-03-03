//
//  PinnedTableViewCell.swift
//  SnapKit-Homework
//
//  Created by Олег Романов on 03.03.2022.
//

import UIKit
import SnapKit

class PinnedTableViewCell: UITableViewCell {

    // MARK: - Constants

    enum Constants {
        enum Numbers {
            static let fontSize: CGFloat = 12
            static let itemWidth: CGFloat = 80
            static let itemHeight: CGFloat = 72
            static let sectionInsetLeft: CGFloat = 8
        }

        enum Constraints {
            static let labelTop: CGFloat = 11
            static let labelLeft: CGFloat = 24
            static let collectionViewTop: CGFloat = 16
            static let collectionViewBottom: CGFloat = 20
            static let collectionViewHeight: CGFloat = 72
        }

        enum Identifier {
            static let pinnedCellIdentifier = "PinnedCell"
        }

        enum Text {
            static let pinnedText = "PINNED"
        }
    }

    // MARK: - Instance Properties

    private var collectionView: UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout())

    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = Constants.Text.pinnedText
        label.font = .habibiFont(style: .regular, size: Constants.Numbers.fontSize)
        return label
    }()

    private var chatsData: [ChatsModel] = []

    // MARK: - Instance Methods

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupCollectionView()
        addSubviews()
        makeConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addSubviews() {
        contentView.addSubview(collectionView)
        contentView.addSubview(label)
    }

    private func makeConstraints() {
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Constants.Constraints.collectionViewTop)
            make.leading.equalToSuperview().inset(Constants.Constraints.labelLeft)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(Constants.Constraints.collectionViewTop)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(Constants.Constraints.collectionViewBottom)
            make.height.equalTo(Constants.Constraints.collectionViewHeight)
        }
    }

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: Constants.Numbers.itemWidth, height: Constants.Numbers.itemHeight)
        layout.sectionInset = .zero
        layout.minimumLineSpacing = .zero
        layout.sectionInset = UIEdgeInsets(top: .zero, left: Constants.Numbers.sectionInsetLeft, bottom: .zero, right: .zero)

        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white

        collectionView.register(PinnedCollectionViewCell.self, forCellWithReuseIdentifier: Constants.Identifier.pinnedCellIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    }

    // MARK: - Internal Methods

    func configure(data: [ChatsModel]) {
        self.chatsData = data
    }
}

// MARK: - CollectionViewDataSource

extension PinnedTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chatsData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Identifier.pinnedCellIdentifier, for: indexPath) as? PinnedCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(image: chatsData[indexPath.row].image ?? UIImage(), name: chatsData[indexPath.row].name ?? "")
        return cell
    }
}

