# Install ocamlfind and ocaml-protoc in local opam switch
$ opam install ocamlfind ocaml-protoc

# $ ocamlopt -output-obj -o modcaml.o mod.ml        
# ld: warning: /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/lib/libSystem.tbd, ignoring unexpected dylib text stub file

# Ensure that the ocamlfind being used belongs to the same local switch, and does not point to a global installation.
# Otherwise ocamlfind won't be able to locate the packages installed in the local opam switch.
# .mli comes before their .ml counterparts.
ocamlfind ocamlopt -output-obj -o modcaml.o -linkpkg -package pbrt messages_types.mli messages_types.ml messages_pb.mli messages_pb.ml mod.ml
ocamlopt -c modwrap.c    

# cp `ocamlopt -where`/libasmrun.a mod.a && chmod +w mod.a
cp (ocamlopt -where)/libasmrun.a mod.a && chmod +w mod.a

ar r mod.a modcaml.o modwrap.o        

# cc -o prog -I `ocamlc -where` main.c mod.a -lcurses        
cc -o prog -I (ocamlc -where) main.c mod.a -lcurses        

$ rm -rf macos/ModKit.xcframework 

$ xcodebuild -create-xcframework -library mod.a -headers include -output macos/ModKit.xcframework


# Generate .pb.swift in current folder
$ protoc --swift_out=. my.proto

