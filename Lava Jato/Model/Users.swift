//
//  Users.swift
//  Lava Jato
//
//  Created by Luiz Claudio Mattos da Silva on 11/05/22.
//

import Foundation

// MARK: - Person
struct Person: Codable {
    var totalValue: Double?
    var registerUsers: [RegisterUser]?
}

// MARK: - RegisterUser
struct RegisterUser: Codable {
    var historyID: String?
    var name, email: String?
    var date: String?
    var telephoneNumber: String?
    var gender: String?
    var birthDate: String?
    var cpf: String?
    var maritalStatus: String?
    var iconImage, note: String?
}
