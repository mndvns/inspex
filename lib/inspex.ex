defmodule Inspex do
  defmacro __using__(opts) do
    %{module: module} = __CALLER__

    Module.put_attribute(module, :inspex_name, Keyword.get(opts, :name, inspect(module)))
    Module.put_attribute(module, :inspex_drop, Keyword.get(opts, :drop, []))
    Module.put_attribute(module, :inspex_take, Keyword.get(opts, :take, false))
    Module.put_attribute(module, :inspex_sigil, Keyword.get(opts, :sigil, "#"))
    Module.put_attribute(module, :inspex_omit_default_values, Keyword.get(opts, :omit_default_values, true))

    quote do
      @before_compile unquote(__MODULE__)
    end
  end

  defmacro __before_compile__(%{module: module}) do
    inspex_name = Module.get_attribute(module, :inspex_name)
    inspex_drop = Module.get_attribute(module, :inspex_drop)
    inspex_take = Module.get_attribute(module, :inspex_take)
    inspex_sigil = Module.get_attribute(module, :inspex_sigil)
    inspex_omit_default_values = Module.get_attribute(module, :inspex_omit_default_values)

    quote do
      def __inspex_inspect__(conf, opts) do
        content = Map.from_struct(conf)

        unquote(if inspex_drop do
          quote do
            content = Map.drop(content, unquote(inspex_drop))
          end
        end)

        unquote(if inspex_take do
          quote do
            content = Map.take(content, unquote(inspex_take))
          end
        end)

        unquote(if inspex_omit_default_values do
          quote do
            default = %__MODULE__{}
            content = Enum.reject(content, fn {key, value} ->
              Map.get(default, key) == value
            end)
          end
        else
          quote do: content = Enum.into(content, [])
        end)

        content = Inspect.List.inspect(content, opts)

        Inspect.Algebra.concat [unquote(inspex_sigil <> inspex_name), content]
      end

      defimpl Inspect do
        defdelegate inspect(conf, opts), to: unquote(module), as: :__inspex_inspect__
      end
    end
  end
end
