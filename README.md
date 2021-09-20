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

```bash
Name                ips        average  deviation         median         99th %
iconv gbk        1.12 M        0.89 μs  ±3206.85%        0.70 μs        1.10 μs
my gbk          0.151 M        6.60 μs   ±299.76%        5.30 μs       18.40 μs

Comparison:
iconv gbk        1.12 M
my gbk          0.151 M - 7.41x slower +5.71 μs
```

## agent 版本

```bash
Name                ips        average  deviation         median         99th %
iconv gbk        1.40 M        0.71 μs  ±4253.70%        0.50 μs        0.80 μs
my gbk         0.0349 M       28.63 μs    ±49.11%       26.70 μs       61.30 μs

Comparison:
iconv gbk        1.40 M
my gbk         0.0349 M - 40.19x slower +27.92 μs
```

# 改进版本

```bash
Name                ips        average  deviation         median         99th %
iconv gbk        1.08 M        0.92 μs  ±3138.57%        0.80 μs        1.20 μs
my gbk           0.99 M        1.01 μs  ±2144.22%        0.80 μs        1.30 μs

Comparison:
iconv gbk        1.08 M
my gbk           0.99 M - 1.09x slower +0.0841 μs
```

长文本

```bash
Name                ips        average  deviation         median         99th %
iconv gbk        7.58 K       0.132 ms    ±10.26%       0.129 ms       0.186 ms
my gbk           0.31 K        3.20 ms     ±8.86%        3.22 ms        3.93 ms

Comparison:
iconv gbk        7.58 K
my gbk           0.31 K - 24.27x slower +3.07 ms
```

# 优化 binary 的版本

```bash
Name                ips        average  deviation         median         99th %
my gbk           1.69 M      592.16 ns  ±3633.05%         450 ns         750 ns
iconv gbk        1.39 M      720.13 ns  ±4209.94%         550 ns         950 ns

Comparison:
my gbk           1.69 M
iconv gbk        1.39 M - 1.22x slower +127.97 ns
```

长文本

```bash
Name                ips        average  deviation         median         99th %
iconv gbk        7.61 K       0.131 ms     ±8.70%       0.129 ms       0.188 ms
my gbk           0.41 K        2.42 ms     ±9.41%        2.44 ms        3.02 ms

Comparison:
iconv gbk        7.61 K
my gbk           0.41 K - 18.42x slower +2.29 ms
```