import XCTest
import SQLite
@testable import SQLite_swift_extensions

final class SQLite_swift_extensionsTests: XCTestCase {
    func testSaveData() throws {
        let db = try Connection(.temporary)
        let testTable = Table("test")
        let testColumn = Expression<[Double]>("double_array")
        
        try db.run(testTable.create { t in
            t.column(testColumn)
        })

        try db.run(testTable.insert(testColumn <- [0, 1, 2]))
    }
    
    func testSaveDataEnocode() throws {
        struct TestStructure: Codable, DataExpressibleValue {
            let constant: Int
            
            static func fromData(_ data: Data) -> TestStructure {
                self.defaultFromData(data, defaultValue: .init(constant: 0))
            }
            
            func dataValue() -> Data {
                self.defaultDataValue()
            }
        }
        
        let db = try Connection(.temporary)
        let testTable = Table("test")
        let testColumn = Expression<[TestStructure]>("test_structure_array")
        
        try db.run(testTable.create { t in
            t.column(testColumn)
        })

        try db.run(testTable.insert(testColumn <- [.init(constant: 0), .init(constant: 1), .init(constant: 2)]))
    }

}
