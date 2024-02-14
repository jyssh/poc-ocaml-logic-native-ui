#!/opt/local/bin/fish

# https://stackoverflow.com/questions/59678144/fish-shell-rm-with-wildcard-and-not-found-files#comment105536171_59678144
set rmfiles *.{a,o,cmx,cmi}
rm -f $rmfiles

and ocamlfind ocamlopt -output-obj -o modcaml.o -linkpkg -package pbrt messages_types.mli messages_types.ml messages_pb.mli messages_pb.ml mod.ml

and ocamlopt -c modwrap.c

and cp (ocamlopt -where)/libasmrun.a mod.a && chmod +w mod.a

and ar r mod.a modcaml.o modwrap.o

and cc -o prog -I (ocamlc -where) main.c mod.a -lcurses

and rm -rf macos/ModKit.xcframework

and xcodebuild -create-xcframework -library mod.a -headers include -output macos/ModKit.xcframework
