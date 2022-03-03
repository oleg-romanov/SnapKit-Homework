//
//  ProfileViewController.swift
//  SnapKit-Homework
//
//  Created by Олег Романов on 03.03.2022.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController {

    // MARK: - Constants

    enum Constants {
        enum Text {
            static let messages = "Messages"
            static let location = "Brooklyn, NY"
            static let logout = "Logout"
            static let name = "Alex Tsimikas"
        }

        enum Numbers {
            static let buttonFontSize: CGFloat = 17
            static let labelFontSize: CGFloat = 14
            static let logoutButtonBorderWidth: CGFloat = 1
            static let largeTitleFontSize: CGFloat = 34
            static let logoutButtonCornerRadius: CGFloat = 18
        }

        enum Constraints {
            static let labelTop: CGFloat = 19
            static let labelLeading: CGFloat = 25
            static let buttonHeight: CGFloat = 36
            static let buttonWidth: CGFloat = 143
        }

        enum ImageName {
            static let logoutButtonImageName = "logout"
        }

        enum ColorName {
            static let logoutButtonColorName = "black"
        }
    }

    // MARK: - Instance Properties

    private lazy var messagesBarButtonItem: UIBarButtonItem = {
        let button = UIBarButtonItem(title: Constants.Text.messages,
                                     style: .plain,
                                     target: self,
                                     action: #selector(navigateToMessages))
        button.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.habibiFont(style: .regular, size: Constants.Numbers.buttonFontSize)], for: .normal)
        button.tintColor = .black
        return button
    }()

    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Text.location
        label.font = .habibiFont(style: .regular,
                                 size: Constants.Numbers.labelFontSize)
        label.tintColor = .black
        return label
    }()

    private lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        let fontMetrics = UIFontMetrics(forTextStyle: .body)
        button.titleLabel?.font = .habibiFont(style: .regular, size: Constants.Numbers.labelFontSize)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        button.setTitle(Constants.Text.logout, for: .normal)
        button.setImage(UIImage(named: Constants.ImageName.logoutButtonImageName), for: .normal)
        button.layer.cornerRadius = Constants.Numbers.logoutButtonCornerRadius
        button.layer.borderWidth = Constants.Numbers.logoutButtonBorderWidth
        button.layer.borderColor = UIColor(named: Constants.ColorName.logoutButtonColorName)?.cgColor
        return button
    }()

    // MARK: - Instance Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupView()
        makeConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        setupNavigationBar()
    }

    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = Constants.Text.name
        navigationItem.rightBarButtonItem = messagesBarButtonItem

        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont.habibiFont(style: .regular, size: Constants.Numbers.largeTitleFontSize)]
        navBarAppearance.backgroundColor = .systemGray6
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.backButtonTitle = ""

        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }

    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(locationLabel)
        view.addSubview(logoutButton)
    }

    private func makeConstraints() {
        locationLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(UIEdgeInsets(
                top: Constants.Constraints.labelTop,
                left: Constants.Constraints.labelLeading,
                bottom: 0,
                right: Constants.Constraints.labelLeading
            ))
        }

        logoutButton.snp.makeConstraints { make in
            make.top.equalTo( view.safeAreaLayoutGuide).inset(view.bounds.height/6)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(CGSize(
                width: Constants.Constraints.buttonWidth,
                height: Constants.Constraints.buttonHeight
            ))
        }
    }

    // MARK: - Actions

    @objc private func navigateToMessages() {
        let viewController = ChatListViewController()
        navigationController?.pushViewController(viewController, animated: false)
    }
}

