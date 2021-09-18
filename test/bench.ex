:application.start(:iconv)

GbkToUtf8Agent.start_link()

GbkToUtf8.start()
#gbk_bin = File.read!("hello.gbk.txt") |> IO.inspect()
gbk_bin = File.read!("6v.gbk.html")

GbkToUtf8.get_utf_by_gbk_string(gbk_bin)
:iconv.convert("gbk", "utf-8", gbk_bin)

Benchee.run(%{
  "my gbk" => fn -> GbkToUtf8.get_utf_by_gbk_string(gbk_bin) end,
  "iconv gbk" => fn -> :iconv.convert("gbk", "utf-8", gbk_bin) end
})
