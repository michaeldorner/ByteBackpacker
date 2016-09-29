<img src="https://raw.githubusercontent.com/michaeldorner/ByteBackpacker/master/icon.png" width="200" align="right">
![Swift](http://img.shields.io/badge/swift-3.0-brightgreen.svg)
[![Build Status](https://travis-ci.org/michaeldorner/ByteBackpacker.svg)](https://travis-ci.org/michaeldorner/ByteBackpacker) [![codecov](https://codecov.io/gh/michaeldorner/ByteBackpacker/branch/master/graph/badge.svg)](https://codecov.io/gh/michaeldorner/ByteBackpacker)
[![codebeat badge](https://codebeat.co/badges/390a34ec-d7ba-4165-bb38-c338247ec04a)](https://codebeat.co/projects/github-com-michaeldorner-bytebackpacker)
[![License](http://img.shields.io/:license-mit-blue.svg?style=flat-square)](http://badges.mit-license.org)

# ByteBackpacker

> ByteBackpacker is a small utility written in Swift 3 to pack value types into a `Byte`¹ array and unpack them back. 

Additionally, there is a [`Data`](https://developer.apple.com/reference/foundation/data) (formerly `NSData`) [extension](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Extensions.html) to convert `Data` objects into a `Byte` array. 


¹ `Byte` is a [`typealias`](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Declarations.html#//apple_ref/doc/uid/TP40014097-CH34-ID361) for `UInt8`.

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)
- [API](#api)
- [Discussion](#discussion)
- [Contributions](#contributions)
- [License](#license)


## Installation

1. Copy the [`ByteBackpacker.swift`](https://github.com/michaeldorner/ByteBackpacker/blob/master/ByteBackpacker/ByteBackpacker.swift) file (containing the `ByteBackpacker` class) to your  project.
2. No second step, you are done. 

(Un)fortunately there is a lot of work going on Swift. This made larger changes to ByteBackpacker needed. The following table shows the compatibility.

| Swift version | ByteBackpacker 1.0 | ByteBackpacker 1.1 and later |
| :-: | :-: | :-: |
| Swift 2.0 | ✓ | ✗ |
| Swift 3.0 | ✗ | ✓ |

Hopefully the APIs will be stable now.

Although it can be used in the same way in Objective-C, I had clearly Swift projects in mind. The easiest way for Objective-C users is to embed the `ByteBackpacker.framework`. Of course, Swift users can also do this, but actually I do not see any advantages.

## Usage
Important for a proper usage: **ByteBackpacker does only support value types (e.g. numbers, structs, ...), but no reference types (e.g. classes)!** For further information see [Discussion](#discussion).

All examples can be seen running in the [`ByteBackpackerPlayground.playground`](ByteBackpackerPlayground.playground). Let's have a look on some general use cases:

#### From `Double` to `[Byte]`
```
let aDouble: Double = 1.0
let aByteArray: [Byte] = ByteBackpacker.pack(aDouble)
```

#### From `[Byte]` to `Double`
```
let option_1: Double = ByteBackpacker.unpack(aByteArray)
let option_2 = ByteBackpacker.unpack(aByteArray) as Double
let option_3 = ByteBackpacker.unpack(aByteArray, toType: Double.self)
```

#### From `Double` to `Data` to `[Byte]` to `Double`
```
var anotherDouble: Double = 2.0
let data = Data(bytes: &anotherDouble, count: MemoryLayout<Double>.size)
var byteArrayFromNSData = data.toByteArray()
let doubleFromByteArray = ByteBackpacker.unpack(byteArrayFromNSData, toType: Double.self)
```

#### From `[Byte]` to `Data`
```
let anotherByteArray: [Byte] = [0, 0, 0, 0, 0, 0, 8, 64]
let dataFromByteArray = Data(bytes: anotherByteArray)
```


## API

`Byte` is a [`typealias`](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Declarations.html#//apple_ref/doc/uid/TP40014097-CH34-ID361) for `UInt8`.

`ByteOrder` is an `enum` for [Little Endian and Big Endian](https://en.wikipedia.org/wiki/Endianness). Furthermore, there is the option for asking the platform you are using for the native byte order of the system: `ByteOrder.nativeByteOrder`. By default `.nativeByteOrder` is applied for packing and unpacking. 

For packing value types into a `[Byte]`, use

```open class func pack<T: Any>( _ value: T, byteOrder: ByteOrder = .nativeByteOrder) -> [Byte]```

For unpacking a `[Byte]` into a value type, use either

```open class func unpack<T: Any>(_ valueByteArray: [Byte], byteOrder: ByteOrder = .nativeByteOrder) -> T```

or otherwise, if you want to use type inference

```open class func unpack<T: Any>(_ valueByteArray: [Byte], toType type: T.Type, byteOrder: ByteOrder = .nativeByteOrder) -> T```


## Discussion

Unfortunately, there is no suitable option for specifying value types in Swift's generics (see [here the discussion on stackoverflow](http://stackoverflow.com/q/28782532/1864294)). It would be awesome to specify our methods like `func (un)pack<T: Any where T: ~AnyClass>(...)`, but until today Swift does not provide us this opportunities. We will see what the future brings.

I would love to improve this project. Tell me your ideas, here in github, via mail or in [codereview.stackexchange.com](http://codereview.stackexchange.com/questions/114730/type-to-byte-array-conversion-in-swift).


## Contributions

### To-Do

- [ ] Find a solution for making sure, that `T` is a value type, but not a reference type 
- [ ] Add documentation to the source code for a nice Xcode integration
- [ ] Add more test cases 
- [ ] Add more examples and how-tos if requested


### Acknowledgements

Many thanks to 
* [Martin R](http://codereview.stackexchange.com/users/35991/martin-r) for [his suggestions in codereview.stackexchange.com](http://codereview.stackexchange.com/a/114738/61640) 
* [iCodist](https://github.com/iCodist/ByteBackpacker) for his update to Swift 3 and Xcode 8 


## License 

ByteBackpacker is released under the MIT license. See [LICENSE](LICENSE) for more details.
