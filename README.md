<img src="https://raw.githubusercontent.com/michaeldorner/ByteBackpacker/master/icon.png" width="200" align="right">
[![Build Status](https://travis-ci.org/michaeldorner/ByteBackpacker.svg)](https://travis-ci.org/michaeldorner/ByteBackpacker) [![codecov.io](https://codecov.io/github/michaeldorner/ByteBackpacker/coverage.svg?branch=master)](https://codecov.io/github/michaeldorner/ByteBackpacker?branch=master)

# ByteBackpacker

ByteBackpacker is a small utility written in Swift to pack value types into a `Byte` array and unpack them back. Additionally, there is a [`NSData`](https://developer.apple.com/library/mac/documentation/Cocoa/Reference/Foundation/Classes/NSData_Class/) [extension](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Extensions.html) to convert `NSData` objects into a `Byte` array. 

`Byte` is a [`typealias`](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Declarations.html#//apple_ref/doc/uid/TP40014097-CH34-ID361) for `UInt8`.


## Embedding in projects

1. Copy the [`ByteBackpacker.swift`](https://github.com/michaeldorner/ByteBackpacker/blob/master/ByteBackpacker/ByteBackpacker.swift) file (containing the `ByteBackpacker` class) to your project.
2. No second step, you are done. 

Although it can be used in the same way in Objective-C, I had clearly Swift projects in mind. The easiest way for Objective-C users is to embed the `ByteBackpacker.framework`. Of course, Swift users can also do this, but actually I do not see any advantages.

## Usage
Important for a proper usage: **ByteBackpacker does only support value types (e.g. numbers, structs, ...), but no reference types (e.g. classes)!** For further information see [Discussion](#discussion).

### Examples

#### From `Double` to `[Byte]` and from `[Byte]` to `Double`

```
let aDouble: Double = 1.0
let byteArray: [Byte] = ByteBackpacker.pack(aDouble)

// either without type inference
let doubleFromByteArray: Double = ByteBackpacker.unpack(byteArray)
let doubleFromByteArray = ByteBackpacker.unpack(byteArray) as Double

// or with type inference, but explizit type parameter
let doubleFromByteArray = ByteBackpacker.unpack(byteArray, toType: Double.self)
```

#### From `Double` over `NSData` to `[Byte]` and from `[Byte]` to `Double`

```
var aDouble: Double = 1.0
let data = NSData(bytes: &aDouble, length: sizeof(Double.self))
let byteArray = data.toByteArray()
let doubleFromByteArray = ByteBackpacker.unpack(byteArray, toType: Double.self)
```

### API

`Byte` is a [`typealias`](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Declarations.html#//apple_ref/doc/uid/TP40014097-CH34-ID361) for `UInt8`.

`ByteOrder` is an `enum` for [Little Endian and Big Endian](https://en.wikipedia.org/wiki/Endianness). Furthermore, there is the option for asking the platform you are using for the native byte order of the system: `ByteOrder.nativeByteOrder`. By default `.nativeByteOrder` is applied for packing and unpacking. 

For packing value types into a `[Byte]`, use

```class func pack<T>(var value: T, byteOrder: ByteOrder = .nativeByteOrder) -> [Byte]```

For unpacking a `[Byte]` into a value type, use either

```public class func unpack<T>(valueByteArray: [Byte], byteOrder: ByteOrder = .nativeByteOrder) -> T```

or otherwise, if you want to use type inference

```class func unpack<T>(valueByteArray: [Byte], toType type: T.Type, byteOrder: ByteOrder = .nativeByteOrder) -> T```


## Discussion

Unfortunately, there is no suitable option for specifying value types in Swift's generics (see [here the discussion on stackoverflow](http://stackoverflow.com/q/28782532/1864294)). It would be awesome to specify our methods like `func (un)pack<T: Any where T: ~AnyClass>(...)`, but until today Swift does not provide us this opportunities. We will see what the future brings us.

I would love to improve this project. Tell me your ideas, here in github, via mail or in [codereview.stackexchange.com](http://codereview.stackexchange.com/questions/114730/type-to-byte-array-conversion-in-swift).


## Contributions

- [ ] Add more test cases 
- [ ] Add more examples and how-tos 
- [ ] Find a solution for making sure, that `T` is a value type, but not a reference type 

## Licence 

ByteBackpacker is released under the MIT license. See [LICENSE](LICENSE) for details.
