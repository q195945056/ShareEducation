//
//  ShareData.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/11/18.
//  Copyright © 2019 严明俊. All rights reserved.
//

import Foundation
import Cache

class ShareData: Codable {
    static let shared: ShareData = {
        let config = DiskConfig(name: "Cache")
        var shared: ShareData?
        do {
            let diskStorage = try DiskStorage<ShareData>(config: config, transformer: TransformerFactory.forCodable(ofType: ShareData.self))
            shared = try diskStorage.object(forKey: "ShareData")
        } catch {
            shared = ShareData()
        }
        return shared!
    }()
    
    var gradetypes: [GradeType]?
    
    var areas: [String: [Area]]?

    var courses: [Course]?
    
    var splashResources: [Resource]?
    
    var bannerResources: [Resource]?
    
    var resourcetypes: [Resourcetype]! {
        didSet {
            for resourceType in resourcetypes {
                switch resourceType.type {
                case .splash:
                    splashResources = resourceType.resources
                case .banner:
                    bannerResources = resourceType.resources
                default:
                    break
                }
            }
        }
    }
    
    func postNotification() {
        courses!.insert(Course.default, at: 0)
        areas!["不限"] = [Area.default]
        NotificationCenter.default.post(name: ShareData.shareDataDidUpdateNotification , object: nil)
    }

    
    func saveOnDisk() throws {
        let config = DiskConfig(name: "Cache")
        let diskStorage = try DiskStorage<ShareData>(config: config, transformer: TransformerFactory.forCodable(ofType: ShareData.self))
        try! diskStorage.setObject(self, forKey: "ShareData")
    }
    
    func findGrade(by gradeID: Int) -> Grade {
        if let gradeTypes = gradetypes {
            for gradeType in gradeTypes {
                for grade in gradeType.grades {
                    if grade.id == gradeID {
                        return grade
                    }
                }
            }
        }
        
        return Grade.default
    }
    
    func findArea(by areaID: Int) -> Area {
        if let areas = areas {
            for (_, value) in areas {
                for area in value {
                    if area.id == areaID {
                        return area
                    }
                }
            }
        }
        return Area.default
    }
    
    func findArea(by name: String) -> Area {
        if let areas = areas {
            for (_, value) in areas {
                for area in value {
                    if area.name == name {
                        return area
                    }
                }
            }
        }
        return Area.default
    }
    
}

extension ShareData {
    static let shareDataDidUpdateNotification = Notification.Name(rawValue: "shareDataDidUpdateNotification")
}
