//
//  main.swift
//  poc-ocaml-swift
//
//  Created by Jayesh Bhoot on 04/02/24.
//

import Foundation
import ModKit

ModKit.caml_startup(CommandLine.unsafeArgv)

var n : Int32 = 8
print(ModKit.fib(n))

// src: https://forums.swift.org/t/how-to-pass-swift-string-to-c-function-in-swift-5/28416/2
// Also explains how to pass char ** var in the same thread.

var str: NSString = "Jayesh"
var str_c = UnsafeMutablePointer<CChar>(mutating: str.utf8String)
//var str_c_opt = UnsafeMutablePointer<CChar>?(str_c)

// Alternative approach from the above thread, that does not need Obj-C's NSString, but is deemed to be unsafe
//var _str = "Jayesh"
//var _str_c = UnsafeMutablePointer<CChar>(mutating: _str.cString(using: .utf8))

print(String.init(cString: ModKit.say_hello(str_c)))

