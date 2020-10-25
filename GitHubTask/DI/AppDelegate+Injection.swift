//
//  AppDelegate+Injection.swift
//  TemplateProject
//
//  Created by Dejan on 08/10/2020.
//  Copyright © 2020 UHP. All rights reserved.
//

import Foundation
import Resolver
import Combine

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        register { GitRepositoryServiceImpl() as GitRepositoryService }
        register { AuthorizationServiceImpl() as AuthorizationService }
        register { UserDefaultsManagerImpl() as UserDefaultsManager }
    }
}
