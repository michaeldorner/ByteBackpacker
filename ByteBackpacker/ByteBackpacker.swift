/*
This file is part of ByteBackpacker Project. It is subject to the license terms in the LICENSE file found in the top-level directory of this distribution and at https://github.com/michaeldorner/ByteBackpacker/blob/master/LICENSE. No part of ByteBackpacker Project, including this file, may be copied, modified, propagated, or distributed except according to the terms contained in the LICENSE file.
*/

import Foundation


public typealias Byte = UInt8


public enum ByteOrder {
    case bigEndian
    case littleEndian
    
    static let nativeByteOrder: ByteOrder = (Int(CFByteOrderGetCurrent()) == Int(CFByteOrderLittleEndian.rawValue)) ? .littleEndian : .bigEndian
}


open class ByteBackpacker {
    
    private static let referenceTypeErrorString = "TypeError: Reference Types are not supported."
    
    open class func unpack<T: Any>(_ valueByteArray: [Byte], byteOrder: ByteOrder = .nativeByteOrder) -> T {
        assert(!(T.self is AnyClass), ByteBackpacker.referenceTypeErrorString)
        let bytes = (byteOrder == .littleEndian) ? valueByteArray : valueByteArray.reversed()
        return bytes.withUnsafeBufferPointer {
            return $0.baseAddress!.withMemoryRebound(to: T.self, capacity: 1) {
                $0.pointee
            }
        }
    }
    

    open class func unpack<T: Any>(_ valueByteArray: [Byte], toType type: T.Type, byteOrder: ByteOrder = .nativeByteOrder) -> T {
        assert(!(T.self is AnyClass), ByteBackpacker.referenceTypeErrorString)
        let bytes = (byteOrder == .littleEndian) ? valueByteArray : valueByteArray.reversed()
        return bytes.withUnsafeBufferPointer {
            return $0.baseAddress!.withMemoryRebound(to: T.self, capacity: 1) {
                $0.pointee
            }
        }
    }
    

    open class func pack<T: Any>( _ value: T, byteOrder: ByteOrder = .nativeByteOrder) -> [Byte] {
        assert(!(T.self is AnyClass), ByteBackpacker.referenceTypeErrorString)
        var value = value // inout works only for var not let types
        let valueByteArray = withUnsafePointer(to: &value) {
            Array(UnsafeBufferPointer(start: $0.withMemoryRebound(to: Byte.self, capacity: 1){$0}, count: MemoryLayout<T>.size))
        }
        return (byteOrder == .littleEndian) ? valueByteArray : valueByteArray.reversed()
    }
}


public extension Data {

    func toByteArray() -> [Byte] {
        let count = self.count / MemoryLayout<Byte>.size
        var array = [Byte](repeating: 0, count: count)
        copyBytes(to: &array, count:count * MemoryLayout<Byte>.size)
        return array
    }
}


