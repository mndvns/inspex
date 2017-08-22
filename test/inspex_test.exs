defmodule Test.Inspex do
  use ExUnit.Case
  doctest Inspex

  defmodule Foo do
    use Inspex, [
      name: "wtf",
      sigil: "@",
      drop: [:baz],
      take: [:foo, :qux, :fin],
    ]

    defstruct [
      foo: "bar",
      baz: "qwe",
      qux: "zin",
      fin: 200,
    ]
  end

  test "inspect foo" do
    IO.inspect %Foo{
      foo: "hi foo",
      baz: "i'm hidden",
      qux: "hi qux",
      fin: 200
    }
  end
end
