# GbkToUtf8

将GBK转换为Utf8

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `gbk_to_utf8` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:gbk_to_utf8, "~> 0.1.1"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/gbk_to_utf8](https://hexdocs.pm/gbk_to_utf8).

# bench vs icon

```bash
Name                ips        average  deviation         median         99th %
iconv gbk      992.89 K        1.01 μs  ±3239.79%        0.80 μs        1.40 μs
my gbk         284.13 K        3.52 μs   ±433.32%        3.10 μs        7.90 μs

Comparison:
iconv gbk      992.89 K
my gbk         284.13 K - 3.49x slower +2.51 μs
```