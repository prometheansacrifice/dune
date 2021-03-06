Variant feature is auto enabled when virtual_modules is used

  $ dune build --root variants-without-using
  Entering directory 'variants-without-using'

  $ dune build --root variants-using
  Entering directory 'variants-using'

virtual libraries may not implement their virtual modules

  $ dune build --root invalid-virtual-lib
  Entering directory 'invalid-virtual-lib'
  File "dune", line 3, characters 18-21:
  3 |  (virtual_modules foo bar))
                        ^^^
  Error: Module Foo has an implementation, it cannot be listed here
  [1]

  $ cd module-fields && ocaml test.ml
  impl: true. modules_without_implementation: true. virtual_modules: true
  File "dune", line 3, characters 33-34:
  3 |  (modules_without_implementation m)
                                       ^
  Error: Module M has an implementation, it cannot be listed here
  -------------------------
  impl: true. modules_without_implementation: true. virtual_modules: false
  File "dune", line 3, characters 33-34:
  3 |  (modules_without_implementation m))
                                       ^
  Error: Module M has an implementation, it cannot be listed here
  -------------------------
  impl: true. modules_without_implementation: false. virtual_modules: true
  File "dune", line 3, characters 18-19:
  3 |  (virtual_modules m))
                        ^
  Error: Module M has an implementation, it cannot be listed here
  -------------------------
  impl: true. modules_without_implementation: false. virtual_modules: false
  -------------------------
  impl: false. modules_without_implementation: true. virtual_modules: true
  File "dune", line 4, characters 18-19:
  4 |  (virtual_modules m))
                        ^
  Error: These modules appear in the virtual_libraries and modules_without_implementation fields: 
  - M
  This is not possible.
  -------------------------
  impl: false. modules_without_implementation: true. virtual_modules: false
  -------------------------
  impl: false. modules_without_implementation: false. virtual_modules: true
  -------------------------
  impl: false. modules_without_implementation: false. virtual_modules: false
  File "dune", line 1, characters 0-21:
  1 | (library
  2 |  (name foo))
  Warning: Some modules don't have an implementation.
  You need to add the following field to this stanza:
  
    (modules_without_implementation m)
  
  This will become an error in the future.
  -------------------------
