//
//  AppError.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 13/07/2026.
//

import SwiftData

enum AppError: Error {

    case modelNotFound(PersistentIdentifier)
}
