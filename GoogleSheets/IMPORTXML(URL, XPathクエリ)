## IMPORTXML(URL, XPathクエリ)
XML、HTML、CSV、TSV、RSS フィード、Atom XML フィードなど、さまざまな種類の構造化データからデータをインポートします。<br>
https://support.google.com/docs/answer/3093342?hl=ja<br>
XPathについて分かりやすいサイト<br>
https://blog.members.co.jp/article/37782<br><br>
【使い方1】<br>
セル$A$1にスクレイピング対象のホームページのURLを記入後、任意のセルに下記の関数を入力する<br>
span[1]の値だけが取得できる<br>
=IMPORTXML($A$1,"//*[@id='contents']/section[2]/div/ul/li/a/span[1]")<br>
【使い方2】<br>
セル$A$1にスクレイピング対象のホームページのURLを記入後、任意のセルに下記の関数を入力する<br>
spanの値が複数ある時はその数だけ取得できる<br>
=IMPORTXML($A$1,"//*[@id='contents']/section[2]/div/ul/li/a/span")
