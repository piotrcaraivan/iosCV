//
//  Alerts.swift
//  realTictacToe
//
//  Created by Петр Караиван on 16.02.2023.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    var title: Text
    var message: Text
    var buttonTitle: Text
}

struct AlertContext {
    static let humanWin    = AlertItem(title: Text("You Win"),
                                       message: Text("You so smart. You are best!"),
                                       buttonTitle: Text("Hell Yeah!"))
    static let botWin    = AlertItem(title: Text("You Lost"),
                                     message: Text("You so dump"),
                                     buttonTitle: Text("Rematch"))
    static let draw    = AlertItem(title: Text("Draw"),
                                   message: Text("What a battle of wits we have there..."),
                                   buttonTitle: Text("Try Again"))
}
