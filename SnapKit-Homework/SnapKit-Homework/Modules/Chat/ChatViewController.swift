//
//  ChatViewController.swift
//  SnapKit-Homework
//
//  Created by Олег Романов on 03.03.2022.
//

import UIKit
import SnapKit

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private var backImage: UIImage = {
        var image = UIImage(named: "backIcon")?.withRenderingMode(.alwaysOriginal)
        return image ?? UIImage()
    }()

    private lazy var tableView = UITableView()

    private lazy var footerView = WriteMessageView()

    private let store: [String:[DatesMessages]] = [
        "3": [DatesMessages(
            date: "Sep 14, 2021",
            messages: [
                Message(isFrom: false,
                        messageText: "Alex, let’s meet this weekend. I’ll check with Dave too 😎",
                        time: "8:27 PM"),
                Message(isFrom: true,
                        messageText: "Sure. Let’s aim for saturday",
                        time: "8:56 PM"),
                Message(isFrom: true,
                        messageText: "I’m visiting mom this sunday 👻",
                        time: "8:56 PM"),
                Message(isFrom: false,
                        messageText: "Alrighty! Will give you a call shortly 🤗",
                        time: "9:01 PM"),
                Message(isFrom: true,
                        messageText: "❤️",
                        time: "9:04 PM")]
        )]
    ]

    private var data: [DatesMessages] = []
    private var profileImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(footerView)
        view.addSubview(tableView)
        footerView.delegate = self
        setupTableView()
        setupNavigationBar()
        makeConstraints()
    }

    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = false

        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navBarAppearance.titleTextAttributes = [NSAttributedString.Key.font: UIFont.habibiFont(style: .regular, size: 14)]
        navBarAppearance.backgroundColor = .systemGray6
        navigationController?.navigationBar.isTranslucent = false
        navBarAppearance.setBackIndicatorImage(backImage, transitionMaskImage: backImage)

        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationItem.hidesSearchBarWhenScrolling = false
    }

    private func setupTableView() {
        tableView.register(MyMessageCell.self, forCellReuseIdentifier: "MessageIdentifier")
        tableView.register(ToMeMessageCell.self, forCellReuseIdentifier: "ToMeMessageIdentifier")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }

    private func makeConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.trailing.leading.equalToSuperview()
            make.bottom.equalTo(footerView.snp.top)
        }
        footerView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.trailing.leading.equalToSuperview()
        }
    }

    func config(id: String, image: UIImage, name: String) {
        fetchDataById(id: id)
        self.profileImage = image
        navigationItem.title = name
    }

    private func fetchDataById(id: String) {
        data = store[id] ?? []
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].messages?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = data[indexPath.section].messages else {
            return UITableViewCell()
        }
        if model[indexPath.row].isFrom ?? false {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MessageIdentifier", for: indexPath) as? MyMessageCell else {
                return UITableViewCell()
            }
            cell.config(text: model[indexPath.row].messageText ?? "", date: model[indexPath.row].time ?? "")
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ToMeMessageIdentifier", for: indexPath) as? ToMeMessageCell else {
                return UITableViewCell()
            }
            cell.config(text: model[indexPath.row].messageText ?? "", date: model[indexPath.row].time ?? "", image: profileImage ?? UIImage())
            return cell
        }

    }
}

extension ChatViewController: WriteMessageViewDelegate {
    func sendMessage(text: String) {
        let lastIndex = data.endIndex
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a "
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        let currentDateStr = formatter.string(from: Date())
        if lastIndex == .zero {
            data.append(DatesMessages(date: "Today",
                                      messages: [
                                        Message(isFrom: true,
                                                messageText: text,
                                                time: currentDateStr)]))
        } else {
            data[lastIndex - 1].messages?.append(Message(isFrom: true,
                                                messageText: text,
                                                time: currentDateStr))
        }
        tableView.reloadData()
    }
}

