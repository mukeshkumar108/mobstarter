//
//  DataLoader.swift
//  mobstarter
//
//  Created by Mukesh Kumar on 23/09/2025.
//

import Foundation

// MARK: - Data Loading Utility
public struct DataLoader {

    // MARK: - Card Loading
    public static func loadCards() -> [CardItem] {
        guard let url = Bundle.main.url(forResource: "cards", withExtension: "json") else {
            print("❌ cards.json not found in bundle")
            return CardItem.previewCards
        }

        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let cards = try decoder.decode([CardItem].self, from: data)
            print("✅ Loaded \(cards.count) cards from JSON")
            return cards
        } catch {
            print("❌ Error loading cards.json: \(error.localizedDescription)")
            return CardItem.previewCards
        }
    }

    // MARK: - Generic JSON Loading
    public static func loadJSON<T: Decodable>(filename: String, type: T.Type) -> T {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            fatalError("❌ \(filename).json not found in bundle")
        }

        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(T.self, from: data)
            print("✅ Loaded \(filename).json successfully")
            return decodedData
        } catch {
            fatalError("❌ Error loading \(filename).json: \(error.localizedDescription)")
        }
    }

    // MARK: - Error Handling
    public enum DataLoaderError: Error {
        case fileNotFound(String)
        case decodingFailed(String)
        case unknown(Error)

        var localizedDescription: String {
            switch self {
            case .fileNotFound(let filename):
                return "File not found: \(filename).json"
            case .decodingFailed(let filename):
                return "Failed to decode: \(filename).json"
            case .unknown(let error):
                return "Unknown error: \(error.localizedDescription)"
            }
        }
    }
}

// MARK: - Preview Support
public extension DataLoader {
    static func loadPreviewCards() -> [CardItem] {
        return CardItem.previewCards
    }
}
