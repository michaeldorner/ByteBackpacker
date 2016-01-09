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
    /**
     @warning *Important:* This function required an explicit type definition, because no type inference is possible:
     
        let d: Double = ByteBackPacker.unpack(byteArray) 
     
     or
     
        let d = ByteBackPacker.unpack(byteArray) as Double
     
     - parameter valueByteArray: <#valueByteArray description#>
     - parameter byteOrder:      <#byteOrder description#>
     
     - returns: <#return value description#>
     */
    
    public class func unpack<T>(valueByteArray: [Byte], byteOrder: ByteOrder = .nativeByteOrder) -> T {
        let bytes = (byteOrder == .LittleEndian) ? valueByteArray : valueByteArray.reverse()
        return bytes.withUnsafeBufferPointer {
            return UnsafePointer<T>($0.baseAddress).memory
        }
    }
    
    /**
     <#Description#>
     
     - parameter valueByteArray: <#valueByteArray description#>
     - parameter type:           <#type description#>
     - parameter byteOrder:      <#byteOrder description#>
     
     - returns: <#return value description#>
     */
    public class func unpack<T>(valueByteArray: [Byte], toType type: T.Type, byteOrder: ByteOrder = .nativeByteOrder) -> T {
        let bytes = (byteOrder == .LittleEndian) ? valueByteArray : valueByteArray.reverse()
        return bytes.withUnsafeBufferPointer {
            return UnsafePointer<T>($0.baseAddress).memory
        }
    }
    
    /**
     <#Description#>
     
     - parameter value:     <#value description#>
     - parameter byteOrder: <#byteOrder description#>
     
     - returns: <#return value description#>
     */
    public class func pack<T>(var value: T, byteOrder: ByteOrder = .nativeByteOrder) -> [Byte] {
        let valueByteArray = withUnsafePointer(&value) {
            Array(UnsafeBufferPointer(start: UnsafePointer<Byte>($0), count: sizeof(T)))
        }
        return (byteOrder == .LittleEndian) ? valueByteArray : valueByteArray.reverse()
    }
}


public extension NSData {
    /**
     <#Description#>
     
     - returns: A Byte array.
     */
    func toByteArray() -> [Byte] {
        let count = length / sizeof(Byte)
        var array = [Byte](count: count, repeatedValue: 0)
        getBytes(&array, length:count * sizeof(Byte))
        return array
    }
}