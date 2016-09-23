//: Playground - noun: a place where people can play

import Cocoa
import ByteBackpacker


// From `Double` to `[Byte]`
let aDouble: Double = 1.0
let aByteArray: [Byte] = ByteBackpacker.pack(aDouble)

// From `[Byte]` to `Double`
let option_1: Double = ByteBackpacker.unpack(aByteArray)
let option_2 = ByteBackpacker.unpack(aByteArray) as Double
let option_3 = ByteBackpacker.unpack(aByteArray, toType: Double.self)

// From `Double` to `Data` to `[Byte]` to `Double`
var anotherDouble: Double = 2.0
let data = Data(bytes: &anotherDouble, count: MemoryLayout<Double>.size)
var byteArrayFromNSData = data.toByteArray()
let doubleFromByteArray = ByteBackpacker.unpack(byteArrayFromNSData, toType: Double.self)

// From `[Byte]` to `Data`
let anotherByteArray: [Byte] = [0, 0, 0, 0, 0, 0, 8, 64]
let dataFromByteArray = Data(bytes: anotherByteArray)
