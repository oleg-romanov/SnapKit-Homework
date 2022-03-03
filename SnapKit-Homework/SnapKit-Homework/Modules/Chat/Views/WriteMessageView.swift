//
//  WriteMessageView.swift
//  SnapKit-Homework
//
//  Created by Олег Романов on 03.03.2022.
//

import UIKit
import SnapKit

protocol WriteMessageViewDelegate {
    func sendMessage(text: String)
}

class WriteMessageView: UIView {

    private lazy var textField: MessageTextField = {
        let input = MessageTextField()
        input.placeholder = "Type your message here..."
        input.font = .habibiFont(style: .regular, size: 14)
        input.tintColor = .black
        input.backgroundColor = UIColor(named: "Colors/toMeMessageColor")
        input.layer.cornerRadius = 20

        return input
    }()

    private lazy var sendButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "send")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)

        return button
    }()

    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "Colors/toMeMessageColor")

        return view
    }()

    var delegate: WriteMessageViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        addSubviews()
        makeConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addSubviews() {
        textField.addSubview(sendButton)
        addSubview(textField)
        addSubview(separatorView)
    }

    private func makeConstraints() {
        sendButton.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview().inset(4)
        }
        textField.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.centerX.equalToSuperview()
            make.width.equalTo(343)
            make.height.equalTo(40)
            make.bottom.equalToSuperview().inset(36)
        }
        separatorView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
    }

    @objc func sendMessage() {
        delegate?.sendMessage(text: textField.text ?? "")
        textField.text = ""
    }
}
