defmodule GbkToUtf8Agent do

   def start_link() do
    Agent.start_link(fn ->
      String.split(GbkToUtf8Map.cp936string(), "\r\n", trim: true)
    |> Enum.filter(fn l -> !String.starts_with?(l, "#") end)
    #|> IO.inspect()
    |> Enum.map(fn l ->
      [gbk, utf8, _] = String.split(l, "\t")
      gbk = String.replace(gbk, ["0x0", "0x"], "")
      utf8 = String.replace(utf8, "0x", "")
      {gbk, utf8}
    end)
    |> Map.new()
    end, name: __MODULE__)
  end

  def get(code) do
    Agent.get(__MODULE__, fn map ->
        Map.get(map, code, "0")
    end)
  end
end
