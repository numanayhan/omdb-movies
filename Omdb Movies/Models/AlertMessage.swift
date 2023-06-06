//
//  AlertMessage.swift
//  Omdb Movies
//
//  Created by na on 5.06.2023.
//  Copyright © 2023 @ Numan Ayhan. All rights reserved.
//

import Foundation
public struct AlertMessage: Codable {
    public var title: String?
    public var message: String?
    public var buttonPositive: String?
    public var buttonNeutral: String?
    public var buttonNegative: String?
    public var url: String?
    public var dismissOnFailure: Bool
    public var status: ProcessStatus

    public init(
        title: String? = nil,
        message: String? = nil,
        buttonPositive: String? = nil,
        buttonNeutral: String? = nil,
        buttonNegative: String? = nil,
        url: String? = nil,
        dismissOnFailure: Bool = false,
        status: ProcessStatus = .undefined
    ) {
        self.title = title
        self.message = message
        self.buttonPositive = buttonPositive
        self.buttonNeutral = buttonNeutral
        self.buttonNegative = buttonNegative
        self.url = url
        self.dismissOnFailure = dismissOnFailure
        self.status = status
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        buttonPositive = try values.decodeIfPresent(String.self, forKey: .buttonPositive)
        buttonNeutral = try values.decodeIfPresent(String.self, forKey: .buttonNeutral)
        buttonNegative = try values.decodeIfPresent(String.self, forKey: .buttonNegative)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        dismissOnFailure = false
        status = .undefined
    }

    public enum CodingKeys: String, CodingKey {
        case title
        case message
        case buttonPositive
        case buttonNeutral
        case buttonNegative
        case url
    }

    static var genericMessage = AlertMessage(title: "", message: "unknownError", buttonPositive: "Kapat")
}
