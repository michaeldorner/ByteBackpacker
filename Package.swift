// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.
/*
 This file is part of ByteBackpacker Project. It is subject to the license terms in the LICENSE file found in the top-level directory of this distribution and at https://github.com/michaeldorner/ByteBackpacker/blob/master/LICENSE. No part of ByteBackpacker Project, including this file, may be copied, modified, propagated, or distributed except according to the terms contained in the LICENSE file.
 */

import PackageDescription

let package = Package(
    name: "ByteBackpacker",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "ByteBackpacker",
            targets: ["ByteBackpacker"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "ByteBackpacker",
            dependencies: [],
            path: "Sources"),
        .testTarget(
            name: "ByteBackpackerTests",
            dependencies: ["ByteBackpacker"],
            path: "Tests"),
    ]
)
