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

import struct NIO.ByteBuffer

extension NIOIMAP {
    /// IMAPv4 `Namespace-Response`
    public struct NamespaceResponse: Equatable {
        public var userNamespace: [NamespaceDescription]
        public var otherUserNamespace: [NamespaceDescription]
        public var sharedNamespace: [NamespaceDescription]

        public static func userNamespace(_ userNamespace: [NamespaceDescription], otherUserNamespace: [NamespaceDescription], sharedNamespace: [NamespaceDescription]) -> Self {
            Self(userNamespace: userNamespace, otherUserNamespace: otherUserNamespace, sharedNamespace: sharedNamespace)
        }
    }
}

// MARK: - Encoding

extension ByteBuffer {
    @discardableResult mutating func writeNamespaceResponse(_ response: NIOIMAP.NamespaceResponse) -> Int {
        self.writeString("NAMESPACE ") +
            self.writeNamespace(response.userNamespace) +
            self.writeSpace() +
            self.writeNamespace(response.otherUserNamespace) +
            self.writeSpace() +
            self.writeNamespace(response.sharedNamespace)
    }
}