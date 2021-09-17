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
      [gbk, utf8, _] = String.split(l, "\t")
      gbk = String.replace(gbk, "0x", "")
      utf8 = String.replace(utf8, "0x", "")
      {gbk, utf8}
    end)
    #|> IO.inspect()
    |> Enum.each(fn {gbk, utf8} ->
      :persistent_term.put({__MODULE__, gbk}, utf8)
    end)
  end

  def get_utf_by_gbk_string(gbk_in) do
    List.to_string(get_utf_by_gbk(gbk_in))
  end

  def get_utf_by_gbk(gbk_in) do
    Enum.map(gbk_to_utf(gbk_in, byte_size(gbk_in) - 1, 0, []) |> tl() |> Enum.reverse(), fn e ->
      case Integer.parse(e, 16) do
        {n, _} -> n
        :error -> 0
      end
    end)
  end

  defp gbk_to_utf(gbk_bin, bs, current, acc) when current - 1 == bs do
    [find_gbk_utf_one(binary_part(gbk_bin, current - 1, 1)) | acc]
  end

  defp gbk_to_utf(gbk_bin, bs, current, acc) when current - 2 == bs do
    [find_gbk_utf_two(binary_part(gbk_bin, current - 2, 2)) | acc]
  end

  defp gbk_to_utf(gbk_bin, bs, current, acc) do
    first_byte = binary_part(gbk_bin, current, 1)
    <<first_byte_value::8>> = first_byte

    if first_byte_value <= 0x7F do
      # 表示是单字节字符
      gbk_to_utf(gbk_bin, bs, current + 1, [find_gbk_utf_one(first_byte) | acc])
    else
      # 表示是双字节字符
      gbk_to_utf(gbk_bin, bs, current + 2, [
        find_gbk_utf_two(binary_part(gbk_bin, current, 2)) | acc
      ])
    end
  end

  # 单字节 <<x>>
  defp find_gbk_utf_one(b1) do
    <<c::8>> = b1
    :persistent_term.get({__MODULE__, Integer.to_string(c, 16)}, "0")
  end

  # 双字节 <<x1,x2>>
  defp find_gbk_utf_two(b1) do
    <<c::16>> = b1
    :persistent_term.get({__MODULE__, Integer.to_string(c, 16)}, "0")
  end
end
