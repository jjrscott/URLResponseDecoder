//
//  URLResponseDecoder.swift
//
//
//  Created by John Scott on 29/12/2023.
//

import Foundation

public struct URLResponseDecoder {
    public func decode<T>(_ type: T.Type, from result: (Data, URLResponse)) throws -> T where T : Decodable {
        guard let response = result.1 as? HTTPURLResponse else { fatalError() }
        return try T(from: _Decoder(result: (result.0, response), codingPath: [], userInfo: [:]))
    }
    
    struct _Decoder: Decoder {
        let result: (Data, HTTPURLResponse)
        
        var codingPath: [CodingKey]
        
        var userInfo: [CodingUserInfoKey : Any]
        
        func container<Key>(keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key> where Key : CodingKey {
            guard let key = Key(intValue: result.1.statusCode) ?? Key(stringValue: "default") else { throw GenericError("HTTP Staus Code \(result.1.statusCode) not supported") }
            return KeyedDecodingContainer(StatusDecodingContainer<Key>(result: result, codingPath: codingPath, allKeys: [key]))
        }
        
        func unkeyedContainer() throws -> UnkeyedDecodingContainer {
            fatalError()
        }
        
        func singleValueContainer() throws -> SingleValueDecodingContainer {
            fatalError()
        }
    }
    
    struct StatusDecodingContainer<Key: CodingKey>: KeyedDecodingContainerProtocol {
        let result: (Data, HTTPURLResponse)
        
        var codingPath: [CodingKey]
        
        var allKeys: [Key]
        
        func contains(_ key: Key) -> Bool {
            fatalError()
        }
        
        func decodeNil(forKey key: Key) throws -> Bool {
            fatalError()
        }
        
        func decode(_ type: Bool.Type, forKey key: Key) throws -> Bool {
            fatalError()
        }
        
        func decode(_ type: String.Type, forKey key: Key) throws -> String {
            fatalError()
        }
        
        func decode(_ type: Double.Type, forKey key: Key) throws -> Double {
            fatalError()
        }
        
        func decode(_ type: Float.Type, forKey key: Key) throws -> Float {
            fatalError()
        }
        
        func decode(_ type: Int.Type, forKey key: Key) throws -> Int {
            fatalError()
        }
        
        func decode(_ type: Int8.Type, forKey key: Key) throws -> Int8 {
            fatalError()
        }
        
        func decode(_ type: Int16.Type, forKey key: Key) throws -> Int16 {
            fatalError()
        }
        
        func decode(_ type: Int32.Type, forKey key: Key) throws -> Int32 {
            fatalError()
        }
        
        func decode(_ type: Int64.Type, forKey key: Key) throws -> Int64 {
            fatalError()
        }
        
        func decode(_ type: UInt.Type, forKey key: Key) throws -> UInt {
            fatalError()
        }
        
        func decode(_ type: UInt8.Type, forKey key: Key) throws -> UInt8 {
            fatalError()
        }
        
        func decode(_ type: UInt16.Type, forKey key: Key) throws -> UInt16 {
            fatalError()
        }
        
        func decode(_ type: UInt32.Type, forKey key: Key) throws -> UInt32 {
            fatalError()
        }
        
        func decode(_ type: UInt64.Type, forKey key: Key) throws -> UInt64 {
            fatalError()
        }
        
        func decode<T>(_ type: T.Type, forKey key: Key) throws -> T where T : Decodable {
            fatalError()
        }
        
        func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type, forKey key: Key) throws -> KeyedDecodingContainer<NestedKey> where NestedKey : CodingKey {
            return KeyedDecodingContainer(PayloadDecodingContainer<NestedKey>(result: result, codingPath: codingPath, allKeys: []))
        }
        
        func nestedUnkeyedContainer(forKey key: Key) throws -> UnkeyedDecodingContainer {
            fatalError()
        }
        
        func superDecoder() throws -> Decoder {
            fatalError()
        }
        
        func superDecoder(forKey key: Key) throws -> Decoder {
            fatalError()
        }
    }
    
    struct PayloadDecodingContainer<Key: CodingKey>: KeyedDecodingContainerProtocol {
        let result: (Data, HTTPURLResponse)

        var codingPath: [CodingKey]
        
        var allKeys: [Key]
        
        func contains(_ key: Key) -> Bool {
            fatalError()
        }
        
        func decodeNil(forKey key: Key) throws -> Bool {
            fatalError()
        }
        
        func decode(_ type: Bool.Type, forKey key: Key) throws -> Bool {
            fatalError()
        }
        
        func decode(_ type: String.Type, forKey key: Key) throws -> String {
            String(data: result.0, encoding: .utf8)!
        }
        
        func decode(_ type: Double.Type, forKey key: Key) throws -> Double {
            fatalError()
        }
        
        func decode(_ type: Float.Type, forKey key: Key) throws -> Float {
            fatalError()
        }
        
        func decode(_ type: Int.Type, forKey key: Key) throws -> Int {
            fatalError()
        }
        
        func decode(_ type: Int8.Type, forKey key: Key) throws -> Int8 {
            fatalError()
        }
        
        func decode(_ type: Int16.Type, forKey key: Key) throws -> Int16 {
            fatalError()
        }
        
        func decode(_ type: Int32.Type, forKey key: Key) throws -> Int32 {
            fatalError()
        }
        
        func decode(_ type: Int64.Type, forKey key: Key) throws -> Int64 {
            fatalError()
        }
        
        func decode(_ type: UInt.Type, forKey key: Key) throws -> UInt {
            fatalError()
        }
        
        func decode(_ type: UInt8.Type, forKey key: Key) throws -> UInt8 {
            fatalError()
        }
        
        func decode(_ type: UInt16.Type, forKey key: Key) throws -> UInt16 {
            fatalError()
        }
        
        func decode(_ type: UInt32.Type, forKey key: Key) throws -> UInt32 {
            fatalError()
        }
        
        func decode(_ type: UInt64.Type, forKey key: Key) throws -> UInt64 {
            fatalError()
        }
        
        func decode<T>(_ type: T.Type, forKey key: Key) throws -> T where T : Decodable {
            if T.self is Data.Type {
                return result.0 as! T
            } else if T.self is String.Type {
                return String(data: result.0, encoding: .utf8)! as! T
            } else {
                switch result.1.mimeType {
                case "application/json":
                    return try JSONDecoder().decode(T.self, from: result.0)
                default:
                    fatalError()
                }
            }
        }
        
        func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type, forKey key: Key) throws -> KeyedDecodingContainer<NestedKey> where NestedKey : CodingKey {
            fatalError()
        }
        
        func nestedUnkeyedContainer(forKey key: Key) throws -> UnkeyedDecodingContainer {
            fatalError()
        }
        
        func superDecoder() throws -> Decoder {
            fatalError()
        }
        
        func superDecoder(forKey key: Key) throws -> Decoder {
            fatalError()
        }
    }
}
