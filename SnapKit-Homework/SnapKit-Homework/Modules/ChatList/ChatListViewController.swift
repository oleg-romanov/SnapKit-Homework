//
//  ChatListViewController.swift
//  SnapKit-Homework
//
//  Created by Олег Романов on 03.03.2022.
//

import UIKit

class ChatListViewController: UITableViewController {

    // MARK: - Constants

    enum Constants {
        enum Text {
            static let backIcon = "backIcon"
            static let placeholder = "Who do you want to chat with?"
            static let navigationTitle = "MESSAGES"
        }

        enum Identifiers {
            static let pinned = "PinnedTableViewCell"
            static let chats = "ChatTableViewCell"
        }

        enum Numbers {
            static let fontSize: CGFloat = 17
            static let one: Int = 1
        }
    }

    // MARK: - Instance Properties

    private var backImage: UIImage = {
        var image = UIImage(named: Constants.Text.backIcon)?.withRenderingMode(.alwaysOriginal)

        return image ?? UIImage()
    }()

    private lazy var searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.hidesNavigationBarDuringPresentation = false

        return controller
    }()

    private var pinnedChatsData: [ChatsModel] = [
        ChatsModel(
            id: "0",
            image: UIImage(named: "Kim")?.withRenderingMode(.alwaysOriginal) ?? UIImage(),
            name: "Kim",
            lastMessage: "",
            timePassed: ""
        ),
        ChatsModel(
            id: "1",
            image: UIImage(named: "Steve")?.withRenderingMode(.alwaysOriginal) ?? UIImage(),
            name: "Steve",
            lastMessage: "",
            timePassed: ""
        ),
        ChatsModel(
            id: "2",
            image: UIImage(named: "Mia")?.withRenderingMode(.alwaysOriginal) ?? UIImage(),
            name: "Mia",
            lastMessage: "",
            timePassed: ""
        )]

    private var chatsData: [ChatsModel] = [
        ChatsModel(
            id: "3",
            image: UIImage(named: "Jessica")?.withRenderingMode(.alwaysOriginal) ?? UIImage(),
            name: "Jessica Thompson",
            lastMessage: "Hey you! Are u there?",
            timePassed: "4h ago"
        ),
        ChatsModel(
            id: "4",
            image: UIImage(named: "Kat")?.withRenderingMode(.alwaysOriginal) ?? UIImage(),
            name: "Kat Williams",
            lastMessage: "OMG! OMG! OMG!",
            timePassed: "5h ago"
        ),
        ChatsModel(
            id: "5",
            image: UIImage(named: "Jacob")?.withRenderingMode(.alwaysOriginal) ?? UIImage(),
            name: "Jacob Washington",
            lastMessage: "Sure. Sunday works for me!",
            timePassed: "20/9/21"
        ),
        ChatsModel(
            id: "6",
            image: UIImage(named: "Leslie")?.withRenderingMode(.alwaysOriginal) ?? UIImage(),
            name: "Leslie Alexander",
            lastMessage: "Sent you an invite for next monday.",
            timePassed: "19/9/21"
        ),
        ChatsModel(
            id: "7",
            image: UIImage(named: "Tony")?.withRenderingMode(.alwaysOriginal) ?? UIImage(),
            name: "Tony Monta",
            lastMessage: "How’s Alicia doing? Ask her to give m...",
            timePassed: "19/9/21"
        ),
    ]

    // MARK: - Instance Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupView()
        setupTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        setupSearchBar()
    }

    private func setupSearchBar() {
        searchController.searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: Constants.Text.placeholder, attributes: [NSAttributedString.Key.font: UIFont.habibiFont(style: .regular, size: Constants.Numbers.fontSize)])
    }

    private func setupNavigationBar() {
        navigationItem.searchController = searchController
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = Constants.Text.navigationTitle

        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navBarAppearance.titleTextAttributes = [NSAttributedString.Key.font: UIFont.habibiFont(style: .regular, size: Constants.Numbers.fontSize)]
        navBarAppearance.backgroundColor = .systemGray6
        navBarAppearance.setBackIndicatorImage(backImage, transitionMaskImage: backImage)
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.backButtonTitle = ""

        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationItem.hidesSearchBarWhenScrolling = false
    }

    private func setupTableView() {
        tableView.register(PinnedTableViewCell.self, forCellReuseIdentifier: Constants.Identifiers.pinned)
        tableView.register(ChatTableViewCell.self, forCellReuseIdentifier: Constants.Identifiers.chats)
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: .zero,
                                                left: .zero,
                                                bottom: .zero,
                                                right: .zero)
        tableView.tableFooterView = UIView()
    }

    private func setupView() {
        view.backgroundColor = .white
    }
}

// MARK: - UITableView

extension ChatListViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == .zero {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.pinned, for: indexPath) as? PinnedTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(data: pinnedChatsData)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.chats, for: indexPath) as? ChatTableViewCell else {
                return UITableViewCell()
            }
            let model = chatsData[indexPath.row - Constants.Numbers.one]
            cell.configure(image: model.image ?? UIImage(),
                           name: model.name ?? "",
                           message: model.lastMessage ?? "",
                           date: model.timePassed ?? "")
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatsData.count + Constants.Numbers.one
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = ChatViewController()
        controller.config(id: chatsData[indexPath.row - 1].id ?? "",
                          image: chatsData[indexPath.row - 1].image ?? UIImage(),
                          name: chatsData[indexPath.row - 1].name ?? "")
        navigationController?.pushViewController(controller, animated: true)

        tableView.deselectRow(at: indexPath, animated: false)
    }
}

