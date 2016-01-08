//
//  ByteBackpacker.swift
//  ByteBackpacker
//
//  Created by Michael Dorner on 21.12.15.
//  Copyright © 2015 Michael Dorner. All rights reserved.
//

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