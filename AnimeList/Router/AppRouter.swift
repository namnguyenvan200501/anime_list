//
//  AppRouter.swift
//  AnimeList
//
//  Created by Nam Nguyễn on 04/04/2024.
//

import Foundation
import UIKit

class AppRouter: BaseRouter {
    static var sharedInstance = AppRouter()

    init() {
        let initialRoute: Route = RouterController.home
        super.init(with: initialRoute)
    }

    required init(with route: Route) {
        super.init(with: route)
    }
}

