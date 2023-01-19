//
//  Result.swift
//  PiedraPapelTijeras
//
//  Created by MacBookMBA6 on 18/01/23.
//

import Foundation

struct Result{
    
    var ErrorMessage :  String?
    var Correct : Bool?
    var object : Any?
    var Objects : [Any]?
    var Ex : Error?
    
    init(ErrorMessage: String, Correct: Bool, object: Any, Objects: [Any], Ex: Error) {
        self.ErrorMessage = ErrorMessage
        self.Correct = Correct
        self.object = object
        self.Objects = Objects
        self.Ex = Ex
    }
    init() {
        self.ErrorMessage = ""
        self.Correct = false
        self.object = nil
        self.Objects = nil
        self.Ex = nil
    }
    
}
