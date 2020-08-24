//
//  Cache+Shared.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/11/26.
//  Copyright © 2019 严明俊. All rights reserved.
//

import Cache

let documentStorage: Storage<User> = {
    let diskConfig = DiskConfig(name: "Document")
    let memoryConfig = MemoryConfig(expiry: .never)
    
    let storage = try? Storage<User>(
        diskConfig: diskConfig,
        memoryConfig: memoryConfig,
        transformer: TransformerFactory.forCodable(ofType: User.self)
    )
    return storage!
}()

let cacheStorage: Storage<String> = {
    let diskConfig = DiskConfig(name: "Cache")
    let memoryConfig = MemoryConfig(expiry: .never)
    
    let storage = try? Storage<String>(
        diskConfig: diskConfig,
        memoryConfig: memoryConfig,
        transformer: TransformerFactory.forCodable(ofType: String.self)
    )
    return storage!
}()

let diskStorage: DiskStorage<String> = {
    let diskConfig = DiskConfig(name: "Cache")
    let storage = try? DiskStorage(config: diskConfig, transformer: TransformerFactory.forCodable(ofType: String.self))
    return storage!
}()
