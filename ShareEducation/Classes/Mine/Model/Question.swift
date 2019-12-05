//
//  Question.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/12/5.
//  Copyright © 2019 严明俊. All rights reserved.
//

import Foundation

class Question {
    var question: String
    var answer: String
    var expand: Bool = false
    
    init(question: String, answer: String) {
        self.question = question
        self.answer = answer
    }
}
