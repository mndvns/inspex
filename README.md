# Inspex

A simple `Inspect` protocol wrapper.

## Usage

```elixir
defmodule MyModule do
  use Inspex

  defstruct [:one, :two, :three]
end
```

IEx:

```elixir
iex> %MyModule{} |> IO.inspect()
#MyModule[]
iex> %MyModule{one: :ok} |> IO.inspect()
#MyModule[one: :ok]
```

## Installation

```elixir
def deps do
  [
    {:inspex, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/inspex](https://hexdocs.pm/inspex).
