# The Elixir test framework, ExUnit, uses some clever code-quoting tricks.
# For example, if you assert
# assert 5 < 4
# you’ll get the error
# Assertion with < failed
# code: 5 < 4
# lhs: 5
# rhs: 4
# The test code parsed the assertion parameter into the left-hand side, the
# operator, and the right-hand side.
# The Elixir source code is on GitHub (at https://github.com/elixir-lang/elixir). The
# implementation of this is in the file elixir/lib/ex_unit/lib/ex_unit/assertions.ex. Spend
# some time reading this file, and work out how it implements this trick.
# (Hard) Once you’ve done that, see if you can use the same technique to
# implement a function that takes an arbitrary arithmetic expression and
# returns a natural-language version.
# explain do: 2 + 3 * 4
# #=> multiply 3 and 4, then add 2
# report
