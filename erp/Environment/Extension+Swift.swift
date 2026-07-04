//
//  Extension+Swift.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 04/07/2026.
//

func withResultOperation<T>(_ body: () async throws -> T) async -> Result<T, Error> {
    do {
        return .success(try await body())
    } catch {
        return .failure(error)
    }
}
