---
title: 社内のRユーザーを増やすためにやったこと
author: '<a href="https://twitter.com/igjit">@igjit</a>'
theme: white
revealjs-url: ../../../reveal.js
css: ../../../css/reveal.css
slideNumber: true
transition: none
---

# 私の仕事

---

Webアプリケーションエンジニア

---

Webサービス作ってます

---

仕事で使う言語

# Ruby

---

ビジネスサイドが使う分析ツール

# Google<br>スプレッドシート

---

社内のRユーザー

# 私だけ

---

![](images/num_install1.png)

---

趣味で

---

第39回 TokyoR

<iframe src="//www.slideshare.net/slideshow/embed_code/key/3HbfBlZBCllo4y" width="595" height="485" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe>

---

社内のRユーザーを増やすためにやったこと

# 1. 自社サービスでRを使う

---

自社サービスにレコメンデーションを実装したい

---

10章 k近傍法：推薦システム

![O'Reilly Japan - 入門 機械学習](https://www.oreilly.co.jp/books/images/picture_large978-4-87311-594-8.jpeg)

---

## in R

---

Rubyから雑にRを呼び出す

---

Ruby

```ruby
# rubyの子プロセスとしてRscriptを呼び出す
result = `Rscript foo.R data.csv`
raise 'Rscript failed' if $CHILD_STATUS != 0

# Rscriptで標準出力に吐いた結果をparseする
CSV.parse(result, headers: true)
```

R

```r
args = commandArgs(trailingOnly = TRUE)
csv.file = args[1]

df <- read.csv(csv.file, header = TRUE)

## 何かやる
out.df <- do.something(df)

write.csv(out.df)
```

---

Rのコードを書いたけど

---

マージには最低2人のコードレビューが必要

---

同僚にRのコードをレビューをしてもらうために

---

![](images/ss_r_intro.png)

---

周りのエンジニアをRユーザーにした

---

![](images/num_install2.png)

---

非エンジニアもRユーザーにしたい

# 2. 社内勉強会を開く


---

![](https://images-na.ssl-images-amazon.com/images/I/51EFK1XNQ5L.jpg)

---

## in R

---

### マンガでわかる統計学 in R

[igjit/manga-statistics-r](https://github.com/igjit/manga-statistics-r)

---

非エンジニアもRを使い始めた

- デザイナー
- ライター
- セールス
- カスタマーサクセス
- コーポレートデザイン

---

![](images/num_install3.png)

---

でもアクティブユーザーは

---

![](images/num_user3.png)

# 私だけ

---

みんながRを使う機会を作ろう

# 3. もくもく会を開く

---

![](images/ss_moku.png)

---

週1回定時後に集まって

---

![](images/moku.jpg)

---

各自好きなことやってます

- [Rによるやさしい統計学](http://shop.ohmsha.co.jp/shopdetail/000000001781/)読む
- [みどり本](https://www.iwanami.co.jp/book/b257893.html)読む
- [Kaggleのチュートリアル](http://trevorstephens.com/kaggle-titanic-tutorial/getting-started-with-r/)やる

---

![](images/num_user4.png)

---

今後も地道にユーザーを増やしていきます。

---

ご意見ください。

![](https://pbs.twimg.com/profile_images/378800000159013251/f5ddbed414eaafe0ef916e8619b58566.png)

[\@igjit](https://twitter.com/igjit)
