import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(ByteBackpackerReferenceTypeTests.allTests),
        testCase(ByteBackpackerValueTypeTests.allTests),
    ]
}
#endif
