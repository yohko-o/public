library(devtools)
library(pipeR)

# 要変更。作業フォルダを指定する。
setwd("./code/script")


# ツイート情報を取得
# 処理内容
# Teitterをキーワード検索し、最新5000件のツイート情報を取得
# csvファイルに保存
library(rtweet)
keyword <- search_tweets("スイカバーフラッペ",n=5000,include_rts = FALSE,langs = "ja", timeout = 60 * 10)
# keyword <- search_tweets("ラ・フランスフラッペ",n=5000,include_rts = FALSE,langs = "ja", timeout = 60 * 10)

write.csv(keyword$text,file = "../datas/data/tweets1.txt")
write.csv(keyword$text,file = "../datas/data_sample/sample1.txt")


# 取得したツイート情報の表記ゆれ対応
# 処理内容
# 余計なスペースの削除
# 全角英数字を半角に,半角のひらがな、カタカナを全角に変換。(一部の全角記号が残る)
# 英文字を小文字へ統一
# URLの削除
# 絵文字(一部の絵文字が残る<U+0301>、<U+030>)
# @リプの削除
library(magrittr)
library(dplyr)
library(stringi)
library(stringr)

keyword_1 <- read.csv("../datas/data/tweets1.txt")

keyword_1$x %<>% str_squish(.)
keyword_1$x %<>% stri_trans_nfkc(.)
keyword_1$x %<>% str_to_lower(.)
keyword_1 %<>% dplyr::mutate(keyword_1,x=gsub(x,pattern="(<u\\+.+>|´|<u\\+.+>|<U+0301>)",replacement = ""))
keyword_1 %<>% dplyr::mutate(keyword_1,x=gsub(x,pattern="https?://[a-z0-9/\\-\\._~\\!\\(\\)\\*#\\$'&,:;=\\?@\\[]+",replacement = ""))
keyword_1 %<>% dplyr::mutate(keyword_1,x=gsub(x,pattern="@.+( |$)",replacement = ""))

write.table(keyword_1$x,file = "../datas/data/tweets2.txt", row.names = FALSE, col.names = FALSE)
write.table(keyword_1$x,file = "../datas/data_sample/sample2.txt", row.names = FALSE, col.names = FALSE)

# 確認用
# library(RMeCab)
# sample <-RMeCabFreq("../datas/data/tweets2.txt")


# 表記ゆれ対応をしたツイート情報を解析
# 処理内容
# 処理したtweets2.txtを改めてRMeCabで解析
# 改行の削除
# RMecabの解析結果から出力対象の単語を抽出
# (品詞の抽出（名詞と形容詞のみ）、数字・不要列・顔文字の削除、出現頻度の集約、降順で並べ替え、出現頻度30以上に絞り込み)
# sample_r1の集計結果を元に、出力対象外の単語を除外

library(RMeCab)
library(dplyr)
library(magrittr)
library(stringr)

sample <- RMeCabFreq("../datas/data/tweets2.txt")
write.csv(sample,file = "../datas/data_sample/sample3.txt")

# 改行の削除
sample$Term <- str_remove_all(sample$Term, "\n")


sample_r1 <- sample %>% filter(Info1 %in% c("名詞", "形容詞")) %>%
  filter(str_detect(Term, "[:punct:]") == 'FALSE') %>%
  filter(Info2 != "数") %>%
  select(Term, Freq) %>%
  group_by(Term) %>%
  summarise(count = sum(Freq)) %>%
  ungroup() %>%
  arrange(desc(count)) # %>%
#  filter(count >= 30) # 30個以上に絞る
View(sample_r1)
write.csv(sample_r1,file = "../datas/data_sample/sample4.txt")

sample_r2 <- sample_r1 %>% filter(!(Term %in% c("ファミマ", "ファミリーマート", "FamilyMart"))) %>%
  filter(!(Term %in% c("ファミマフラッペ", "スイカバーフラッペ", "スイカフラッペ", "フラッペ"))) %>%
  filter(!(Term %in% c("今日", "ん", "の", "日", "明日", "昨日"))) %>%
filter(!(Term %in% c("ー", "~", "w", "oh")))
View(sample_r2)
write.csv(sample_r2,file = "../datas/data_sample/sample5.txt")


# 可視化
# 処理内容
# 処理済みのツイート情報をwordcloud2を利用して、可視化した

library(wordcloud2)
library(webshot)
library(htmlwidgets)

Photo <- wordcloud2(sample_r2, size=1.6, color='random-light', backgroundColor="black")
saveWidget(Photo, "tmp.html", selfcontained = F)
webshot("tmp.html", "wordcloud.png", delay = 60, vwidth = 800, vheight = 800)


