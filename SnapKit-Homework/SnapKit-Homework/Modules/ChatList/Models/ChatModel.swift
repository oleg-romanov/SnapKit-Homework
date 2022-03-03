//
//  ChatModel.swift
//  SnapKit-Homework
//
//  Created by Олег Романов on 03.03.2022.
//

import UIKit

struct ChatsModel {
    var id: String?
    var image: UIImage?
    var name: String?
    var lastMessage: String?
    var timePassed: String?

    init(id: String,
         image: UIImage,
         name: String,
         lastMessage: String,
         timePassed: String
    ) {
        self.id = id
        self.image = image
        self.name = name
        self.lastMessage = lastMessage
        self.timePassed = timePassed
    }
}
