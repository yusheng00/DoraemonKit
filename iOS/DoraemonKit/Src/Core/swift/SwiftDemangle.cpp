//===--- SwiftDemangle.cpp - Public demangling interface ------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2017 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//
//
// Functions in the libswiftDemangle library, which provides external
// access to Swift's demangler.
//
//===----------------------------------------------------------------------===//

#include "Demangle.h"

extern "C" int symbolic_demangle_swift(const char *symbol,
                                       char *buffer,
                                       size_t buffer_length,
                                       int simplified) {
    swift::Demangle::DemangleOptions opts;
    if (simplified) {
        opts = swift::Demangle::DemangleOptions::SimplifiedUIDemangleOptions();
        if (simplified == 2) {
            opts.ShowFunctionArgumentTypes = false;
        }
    }

    std::string demangled =
        swift::Demangle::demangleSymbolAsString(llvm::StringRef(symbol), opts);

    if (demangled.size() == 0 || demangled.size() >= buffer_length) {
        return false;
    }

    memcpy(buffer, demangled.c_str(), demangled.size());
    buffer[demangled.size()] = '\0';
    return true;
}

extern "C" int symbolic_demangle_is_swift_symbol(const char *symbol) {
    return swift::Demangle::isSwiftSymbol(symbol);
}
