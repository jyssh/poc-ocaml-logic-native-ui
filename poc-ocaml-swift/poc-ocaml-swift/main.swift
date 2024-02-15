//
//  main.swift
//  poc-ocaml-swift
//
//  Created by Jayesh Bhoot on 04/02/24.
//

import Foundation
import ModKit

ModKit.caml_startup(CommandLine.unsafeArgv)

// ----------

var n : Int32 = 8
print(ModKit.fib(n))

// ----------

// src: https://forums.swift.org/t/how-to-pass-swift-string-to-c-function-in-swift-5/28416/2
// Also explains how to pass char ** var in the same thread.
var name: NSString = "Jayesh"
var name_c = UnsafeMutablePointer<CChar>(mutating: name.utf8String)
print(String.init(cString: ModKit.say_hello(name_c)))

// ----------

var msgType: NSString = "greet"
var msgType_c = UnsafeMutablePointer<CChar>(mutating: msgType.utf8String)

var person = Person()
person.id = 1
person.name = "Jayesh Bhoot"
person.email = "fake@mail.com"
person.phone = ["123456668"]

// swift-protobuf github readme says serializedBytes() but it seems outdated. There is no serializedBytes().
let binaryData: Data = try person.serializedData()
// convert Data to an array of bytes [UInt8]
let binaryDataAsBytes = [UInt8](binaryData)

let data_pointer = UnsafeMutablePointer<UInt8>.allocate(capacity: binaryDataAsBytes.count)
data_pointer.update(from: binaryDataAsBytes, count: binaryDataAsBytes.count)
print(String.init(cString: ModKit.message(msgType_c, data_pointer, Int32(binaryDataAsBytes.count))))

// ----------

var msg_struct = Message()
msg_struct.type = msgType_c
msg_struct.data = data_pointer
msg_struct.length = UInt32(binaryDataAsBytes.count)
let msg_struct_ptr = UnsafeMutablePointer<Message>.allocate(capacity: 1)
msg_struct_ptr.update(from: &msg_struct, count: 1)
print(String.init(cString: ModKit.message2(msg_struct_ptr)))
