import Foundation
import SQLite

// MARK: Main Conformance Dance
public protocol DataExpressibleValue {
    static func fromData(_ data: Data) -> Self
    func dataValue() -> Data
}

public extension DataExpressibleValue where Self: Codable {
    static func defaultFromData(_ data: Data, defaultValue: Self) -> Self {
        return (try? JSONDecoder().decode(Self.self, from: data)) ?? defaultValue
    }
    
    func defaultDataValue() -> Data {
        let data = try? JSONEncoder().encode(self)
        return data ?? Data()
    }
}

extension Array: DataExpressibleValue where Element: DataExpressibleValue {
    public static func fromData(_ data: Data) -> Array<Element> {
        let dataValues: [Data] = (try? JSONDecoder().decode([Data].self, from: data)) ?? []
        let array: [Element] = dataValues.compactMap({Element.fromData($0)})
        return array
    }
    
    public func dataValue() -> Data {
        let dataValues: [Data] = self.map({$0.dataValue()})
        let data = try? JSONEncoder().encode(dataValues)
        return data ?? Data()
    }
}

extension Array: Expressible where Element: DataExpressibleValue { }

extension Array: Value where Element: DataExpressibleValue {
    public typealias Datatype = Blob
    
    public static var declaredDatatype: String {
        Blob.declaredDatatype
    }
    
    public static func fromDatatypeValue(_ datatypeValue: Blob) -> Array<Element> {
        self.fromData(Data.fromDatatypeValue(datatypeValue))
    }
    
    public var datatypeValue: Blob {
        return self.dataValue().datatypeValue
    }
}

// MARK: Value type conformances

extension Int: DataExpressibleValue {
    public static func fromData(_ data: Data) -> Int {
        return (try? JSONDecoder().decode(Self.self, from: data)) ?? 0
    }
    
    public func dataValue() -> Data {
        let data = try? JSONEncoder().encode(self)
        return data ?? Data()
    }
}

extension Float: DataExpressibleValue {
    public static func fromData(_ data: Data) -> Float {
        return (try? JSONDecoder().decode(Self.self, from: data)) ?? 0
    }
    
    public func dataValue() -> Data {
        let data = try? JSONEncoder().encode(self)
        return data ?? Data()
    }
}

extension Double: DataExpressibleValue {
    public static func fromData(_ data: Data) -> Double {
        return (try? JSONDecoder().decode(Self.self, from: data)) ?? 0
    }
    
    public func dataValue() -> Data {
        let data = try? JSONEncoder().encode(self)
        return data ?? Data()
    }
}

extension String: DataExpressibleValue {
    public static func fromData(_ data: Data) -> String {
        return (try? JSONDecoder().decode(Self.self, from: data)) ?? ""
    }
    
    public func dataValue() -> Data {
        let data = try? JSONEncoder().encode(self)
        return data ?? Data()
    }
}
