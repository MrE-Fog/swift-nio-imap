//===----------------------------------------------------------------------===//
//
// This source file is part of the SwiftNIO open source project
//
// Copyright (c) 2020 Apple Inc. and the SwiftNIO project authors
// Licensed under Apache License v2.0
//
// See LICENSE.txt for license information
// See CONTRIBUTORS.txt for the list of SwiftNIO project authors
//
// SPDX-License-Identifier: Apache-2.0
//
//===----------------------------------------------------------------------===//

import NIO
@testable import NIOIMAPCore
import XCTest

class RenameParameter_Tests: EncodeTestClass {}

// MARK: - Encoding

extension RenameParameter_Tests {
    func testEncode() {
        let inputs: [(NIOIMAP.RenameParameter, String, UInt)] = [
            (.name("some", value: nil), "some", #line),
            (.name("test", value: .simple(.number(1))), "test 1", #line),
        ]

        for (input, expectedString, line) in inputs {
            self.testBuffer.clear()
            let size = self.testBuffer.writeRenameParameter(input)
            XCTAssertEqual(size, expectedString.utf8.count, line: line)
            XCTAssertEqual(self.testBufferString, expectedString, line: line)
        }
    }

    func testEncode_multiple() {
        let inputs: [([NIOIMAP.RenameParameter], String, UInt)] = [
            ([], "", #line),
            ([.name("some", value: nil)], " (some)", #line),
            ([.name("some1", value: nil), .name("some2", value: nil), .name("some3", value: nil)], " (some1 some2 some3)", #line),
        ]

        for (input, expectedString, line) in inputs {
            self.testBuffer.clear()
            let size = self.testBuffer.writeRenameParameters(input)
            XCTAssertEqual(size, expectedString.utf8.count, line: line)
            XCTAssertEqual(self.testBufferString, expectedString, line: line)
        }
    }
}