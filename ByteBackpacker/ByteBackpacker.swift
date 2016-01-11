/*
This file is part of ByteBackpacker Project. It is subject to the license terms in the LICENSE file found in the top-level directory of this distribution and at https://github.com/michaeldorner/ByteBackpacker/blob/master/LICENSE. No part of ByteBackpacker Project, including this file, may be copied, modified, propagated, or distributed except according to the terms contained in the LICENSE file.
*/

import Foundation


public typealias Byte = UInt8


public enum ByteOrder {
    case BigEndian
    case LittleEndian
    
    static let nativeByteOrder: ByteOrder = (Int(CFByteOrderGetCurrent()) == Int(CFByteOrderLittleEndian.rawValue)) ? .LittleEndian : .BigEndian
}


public class ByteBackpacker {
    
    private static let referenceTypeErrorString = "TypeError: Reference Types are not supported."
    
    
    public class func unpack<T: Any>(valueByteArray: [Byte], byteOrder: ByteOrder = .nativeByteOrder) -> T {
        assert(!(T.self is AnyObject), referenceTypeErrorString)
        let bytes = (byteOrder == .LittleEndian) ? valueByteArray : valueByteArray.reverse()
        return bytes.withUnsafeBufferPointer {
            return UnsafePointer<T>($0.baseAddress).memory
        }
    }
    

    public class func unpack<T: Any>(valueByteArray: [Byte], toType type: T.Type, byteOrder: ByteOrder = .nativeByteOrder) -> T {
        assert(!(T.self is AnyObject), referenceTypeErrorString)
        let bytes = (byteOrder == .LittleEndian) ? valueByteArray : valueByteArray.reverse()
        return bytes.withUnsafeBufferPointer {
            return UnsafePointer<T>($0.baseAddress).memory
        }
    }
    

    public class func pack<T: Any>(var value: T, byteOrder: ByteOrder = .nativeByteOrder) -> [Byte] {
        assert(!(T.self is AnyObject), referenceTypeErrorString)
        let valueByteArray = withUnsafePointer(&value) {
            Array(UnsafeBufferPointer(start: UnsafePointer<Byte>($0), count: sizeof(T)))
        }
        return (byteOrder == .LittleEndian) ? valueByteArray : valueByteArray.reverse()
    }
}


public extension NSData {

    func toByteArray() -> [Byte] {
        let count = length / sizeof(Byte)
        var array = [Byte](count: count, repeatedValue: 0)
        getBytes(&array, length:count * sizeof(Byte))
        return array
    }
}