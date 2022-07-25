## QUERY(データ, クエリ, [見出し])
Google Visualization API のクエリ言語を使用して、データ全体に対するクエリを実行します。<br>
https://support.google.com/docs/answer/3093343?hl=ja<br>
* データ - クエリを実行するセルの範囲です。<br>
データの各列に指定できるのは、ブール値、数値（日付/時刻など）、文字列の値のみです。
1 つの列に異なる種類のデータが含まれている場合は、その列に大多数含まれる種類のデータをクエリに使用します。小数の種類のデータは NULL 値とみなされます。
* クエリ - Google Visualization API のクエリ言語で記述された、実行対象のクエリです。
クエリの値は二重引用符で囲むか、適切なテキストを含むセルへの参照にする必要があります。
クエリ言語について詳しくは、https://developers.google.com/chart/interactive/docs/querylanguage をご覧ください。
* 見出し - [省略可] - データの上部にある見出し行の数です。省略した場合や -1 と指定した場合は、データの内容に基づいて推測されます。見出し行が3行あるなら、3と指定する。trueはNG
<br>
【例1】<br>
A列の値でグループ化して、件数を集計する。Aの値の昇順に並べる。<br>
=QUERY(<br>
    A:A,<br>
    "SELECT A, COUNT(A) GROUP BY A ORDER BY A")<br>
 <br>
 【例2】<br>
A列,B列,C列の値を検索する。ラベルをlabelA、labelB、labelCとする。<br>
見出し行を3行とする。＊4行目から検索される。<br>
=QUERY(<br>
    A:C,<br>
    "SELECT A, B, C, label A 'labelA', B 'labelB', C 'labelC'",<br>
    3)<br>
 <br>
