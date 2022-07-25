## IMPORTXML(URL, XPathクエリ)
XML、HTML、CSV、TSV、RSS フィード、Atom XML フィードなど、さまざまな種類の構造化データからデータをインポートします。<br>
https://support.google.com/docs/answer/3093342?hl=ja<br>
XPathについて分かりやすいサイト<br>
https://blog.members.co.jp/article/37782<br>
<br>
【例1】<br>
スクレイピング対象のホームページのURLとXPathクエリを直接指定する<br>
=IMPORTXML("http//:・・・","・・・")<br>
【例2】<br>
スクレイピング対象のホームページのURLはセル$A$1、XPathクエリはセル$B$1を参照する<br>
=IMPORTXML($A$1,$B$1)<br>
【例3】<br>
span[1]の値だけが取得する<br>
=IMPORTXML($A$1,"//*[@id='contents']/section[2]/div/ul/li/a/span[1]")<br>
【例4】<br>
spanの値が複数ある時はすべて取得するbr>
=IMPORTXML($A$1,"//*[@id='contents']/section[2]/div/ul/li/a/span")
