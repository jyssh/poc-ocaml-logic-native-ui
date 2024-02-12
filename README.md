$ ocamlopt -output-obj -o modcaml.o mod.ml        
ld: warning: /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/lib/libSystem.tbd, ignoring unexpected dylib text stub file

$ ocamlopt -c modwrap.c    

$ cp `ocamlopt -where`/libasmrun.a mod.a && chmod +w mod.a
fish> cp (ocamlopt -where)/libasmrun.a mod.a && chmod +w mod.a

$ ar r mod.a modcaml.o modwrap.o        

$ cc -o prog -I `ocamlc -where` main.c mod.a -lcurses        
fish> cc -o prog -I (ocamlc -where) main.c mod.a -lcurses        

$ rm -rf macos/ModKit.xcframework 

$ xcodebuild -create-xcframework -library mod.a -headers include -output macos/ModKit.xcframework

