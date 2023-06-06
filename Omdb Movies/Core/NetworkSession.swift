//
//  NetworkSession.swift
//  Omdb Movies
//
//  Created by na on 5.06.2023.
//  Copyright © 2023 @ Numan Ayhan. All rights reserved.
//

import Foundation
import Alamofire

open class NetworkSession: Session {
    public convenience init() {
        self.init(eventMonitors: [NetworkLogger()])
    }
}
