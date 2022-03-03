//
//  ChatView.swift
//  SnapKit-Homework
//
//  Created by Олег Романов on 03.03.2022.
//

import UIKit
import SnapKit

class ChatView: UIView {

    // MARK: - Instance Properties

    private var isFrom: Bool = false

    var textLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = .zero
        label.font = .habibiFont(style: .regular, size: 14)

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

    override func layoutSubviews() {
        super.layoutSubviews()
        if isFrom {
            roundCorners(corners: [.bottomLeft, .topLeft, .topRight], radius: 12)
        } else {
            roundCorners(corners: [.bottomLeft, .bottomRight, .topRight], radius: 12)
        }
    }

    private func addSubviews() {
        addSubview(textLabel)
    }

    private func makeConstraints() {
        textLabel.snp.makeConstraints { make in
            make.bottom.top.equalToSuperview().inset(4)
            make.leading.trailing.equalToSuperview().inset(8)
        }
    }

    func makeRoundedCorners(from: Bool) {
        self.isFrom = from
    }
}

extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
