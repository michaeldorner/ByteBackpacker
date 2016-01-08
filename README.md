# ByteBackpacker

ByteBackpacker is a small utility written in Swift to pack and unpack value types into a `Byte` array. Additionally, there is a [`NSData`](https://developer.apple.com/library/mac/documentation/Cocoa/Reference/Foundation/Classes/NSData_Class/) [extension](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Extensions.html) to convert `NSData` objects into a `Byte` array. 

`Byte` is a [`typealias`](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Declarations.html#//apple_ref/doc/uid/TP40014097-CH34-ID361) for `UInt8`.


## Embedding in projects

1. Copy the [`ByteBackpacker.swift`](https://github.com/michaeldorner/ByteBackpacker/blob/master/ByteBackpacker/ByteBackpacker.swift) file (containing the `ByteBackpacker` class) to your project.
2. No second step, you are done. 

If you want, you can embed the `ByteBackpacker.framework`, but at the moment I do not see any advantages going this way. 


## Usage

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

`Byte` is a typealias for `UInt8`.

ByteOrder is an enum for Little Endian and Big Endian. Furthermore, there is the option for asking the platform you are using for the native byte order of the system: `ByteOrder.nativeByteOrder`. By default `.nativeByteOrder` is applied for packing and unpacking. 

For packing value types into a `[Byte]`, use

```class func pack<T>(var value: T, byteOrder: ByteOrder = .nativeByteOrder) -> [Byte]```

For unpacking a `[Byte]` into a value type, use either

```class func unpack<T>(valueByteArray: [Byte], toType type: T.Type, byteOrder: ByteOrder = .nativeByteOrder) -> T```

if you want to use type inference, or otherwise

```public class func unpack<T>(valueByteArray: [Byte], byteOrder: ByteOrder = .nativeByteOrder) -> T```


### Contributions

Feel free to use this code, but you can help me: 
* Some test functions exists, but they are not complete. 
* I would love to improve this project. Tell me your ideas, here in github, via mail or in [codereview.stackexchange.com](http://codereview.stackexchange.com/questions/114730/type-to-byte-array-conversion-in-swift).
