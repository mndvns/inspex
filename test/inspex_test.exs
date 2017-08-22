defmodule Test.Inspex do
  use ExUnit.Case
  doctest Inspex

  defmodule Foo do
    use Inspex, [
      name: "wtf",
      sigil: "@",
      drop: [:baz],
      take: [:foo, :qux, :fin],
      omit_values: ["hi qux"],
      omit_pairs: [fin: 300],
      omit_keys: [:fen],
    ]

    defstruct [
      foo: "bar",
      baz: "qwe",
      qux: "zin",
      fin: 200,
      fen: nil,
    ]
  end

  test "inspect foo" do
    IO.inspect %Foo{
      foo: "hi foo",
      baz: "i'm hidden",
      qux: "hi qux",
      fin: 300,
      fen: 100,
    }
  end
end
