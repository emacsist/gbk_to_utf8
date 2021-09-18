defmodule GbkToUtf8Test do
  use ExUnit.Case
  doctest GbkToUtf8

  # |>Enum.map(fn {k,v}->{v,k} end) |> Map.new
  test "test gbk file" do
    GbkToUtf8.start()

    assert GbkToUtf8.get_utf_by_gbk_string(File.read!("hello.gbk.txt")) == "测试中文 gbk 编码"
  end

  test "test gbk2" do
    GbkToUtf8.start()

    File.read!("hello2.gbk.txt") |> IO.inspect()

    GbkToUtf8.get_utf_by_gbk_string(File.read!("hello2.gbk.txt"))
    |> IO.inspect()
  end
end
