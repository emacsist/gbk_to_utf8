defmodule GbkToUtf8 do
  @moduledoc """
  通过 CP936 映射文件, 将GBK编码转换为UTF8编码

  1. GbkToUtf8.start
  2. GbkToUtf8.get_utf_by_gbk_string(File.read!('/mnt/d/hello.gbk.txt'))
  """

  @doc """
  将 CP936 文件加载到 :persistent_term, key , value 都删除了 0x 前缀
  """
  def start do
    String.split(GbkToUtf8Map.cp936string(), "\r\n", trim: true)
    |> Enum.filter(fn l -> !String.starts_with?(l, "#") end)
    #|> IO.inspect()
    |> Enum.map(fn l ->
      #IO.inspect(l)
      [gbk, utf8, _] = String.split(l, "\t", trim: true)
      gbk = String.replace(gbk, ["0x"], "") |> String.trim()
      utf8 = String.replace(utf8, "0x", "") |> String.trim()
      if String.length(utf8) == 0 do
        #IO.inspect(l)
        {gbk |> String.to_integer(16), 0}
      else
        {gbk |> String.to_integer(16), utf8 |> String.to_integer(16)}
      end


    end)
    #|> IO.inspect()
    |> Enum.each(fn {gbk, utf8} ->
      :persistent_term.put({__MODULE__, gbk}, utf8)
    end)
  end

  def get_utf_by_gbk_string(gbk_in) do
    get_utf_by_gbk(gbk_in) |> List.to_string()
  end

  def get_utf_by_gbk(gbk_in) do
    gbk_to_utf(gbk_in, []) |> Enum.reverse
  end

  defp gbk_to_utf(<<first_byte::8>>, acc) do
    [find_gbk_utf_one(first_byte) | acc]
  end

  defp gbk_to_utf(<<two_byte::16>>, acc) do
    [find_gbk_utf_two(two_byte) | acc]
  end

  defp gbk_to_utf(<<first_byte::8, rest1::binary>> = gbk_bin, acc) do
    if first_byte <= 0x7F do
      # 表示是单字节字符
      gbk_to_utf(rest1, [find_gbk_utf_one(first_byte) | acc])
    else
      # 表示是双字节字符
      <<two_byte::16, rest2::binary>> = gbk_bin
      gbk_to_utf(rest2, [find_gbk_utf_two(two_byte) | acc])
    end
  end

  # 单字节 <<x>>
  defp find_gbk_utf_one(b1) do
    :persistent_term.get({__MODULE__, b1}, 0)
    # GbkToUtf8Agent.get(Base.encode16(b1))
  end

  # 双字节 <<x1,x2>>
  defp find_gbk_utf_two(b2) do
    :persistent_term.get({__MODULE__, b2}, 0)
    # GbkToUtf8Agent.get(Base.encode16(b2))
  end

end
