---
pagetitle: Kaggle初コンペにRで挑戦した話
title: |
  Kaggle初コンペに \
  Rで挑戦した話
subtitle: |
  [Tokyo.R #99](https://tokyor.connpass.com/event/249096/)
author: |
  <a href="https://twitter.com/igjit" class="name">@igjit</a>
theme: white
revealjs-url: ../../../reveal.js
css:
  - ../../../css/reveal.css
  - ../../../css/fix_highlight_zenburn.css
slideNumber: true
transition: none
history: true
---

<style type="text/css" rel="stylesheet">
.reveal .bordered-table table td { border: 1px solid; }
.reveal .bordered-table table tbody tr:last-child td { border: 1px solid; }
</style>

![](https://igjit.github.io/images/avatar.png){width=256}

<a href="https://twitter.com/igjit" class="name">@igjit</a>

- ソフトウェアエンジニア
- [Rで変なものを作る](https://igjit.github.io/slides/) 人

---

共著で本を書きました。

![](images/r-efficiency-book.jpg){width="30%"}

<p class="text-small" style="margin-top:0">
<https://gihyo.jp/book/2022/978-4-297-12524-0>
</p>

---

本題

---

Kaggleコンペに初挑戦して

<div class="fragment">
銅メダルを獲りました！
![](images/ss-leaderboard.png)
</div>

---

### 概要

---

[H&M Personalized Fashion Recommendations](https://www.kaggle.com/competitions/h-and-m-personalized-fashion-recommendations/overview)

![](images/ss-h-and-m-title.png)

<p class="text-small">
過去の購買履歴を元にファッションアイテムを推薦する
</p>

---

### チーム

---

![](images/ss-team.png){width="70%"}

- 会社の同僚
- データエンジニア2人、データアナリスト2人

---

やったこと

---

### まずは評価指標を確認

---

![](images/ss-evaluation.png){.img-shadow width="100%"}

<p style="font-size: 0.4em">
<https://www.kaggle.com/competitions/h-and-m-personalized-fashion-recommendations/overview/evaluation>
</p>

---

なるほどわからん

---

[Kaggleで勝つデータ分析の技術](https://gihyo.jp/book/2019/978-4-297-10843-4)
を読む

![](images/kaggle-book.jpg){.img-shadow width="30%"}

----

2.3.6 レコメンデーションにおける評価指標

で MAP@K がくわしく説明されている。

---

### とりあえずfirst submit

---

Kaggle NotebookでR, Pythonのコードを実行、共有できる。

[Rでコードを書いて](https://www.kaggle.com/code/igjit1/my-first-h-m-submission-with-r)submit

![](images/ss-first-submit.png){.img-shadow width="80%"}

---

### 他の人のNotebookを読む

---

有用なNotebookが多数公開されているので読んで参考にする

![](images/ss-notebooks.png){.img-shadow width="75%"}

----

私は

- [Recommend Items Purchased Together - [0.021]](https://www.kaggle.com/code/cdeotte/recommend-items-purchased-together-0-021)
- [H&M Trending Products Weekly](https://www.kaggle.com/code/byfone/h-m-trending-products-weekly)
- [H&M EDA & Rule Base by Customer Age](https://www.kaggle.com/code/hechtjp/h-m-eda-rule-base-by-customer-age)

を参考にして

---

ルールベースの推薦を[Rで実装](https://www.kaggle.com/code/igjit1/lb-0-0235-h-m-rule-base-solution-in-r)

![](images/ss-my-solution.png){.img-shadow width="80%"}

---

個々のスコアはメダル圏に達しなかったけど

---

最終日にチームみんなの予測をアンサンブルさせた結果、

<div class="fragment">
銅メダルを獲得できた！
![](images/ss-leaderboard.png)
</div>

---

後日

---

上位のチームの解法が多数公開されていて

- [実務でレコメンドをやっているのでKaggle H&Mコンペに参加しました](https://yng87.github.io/blog/2022/05/kaggle_hm/)
- [【Kaggle】H&Mコンペ参加記(133rd/2952🥈)](https://zenn.dev/zerebom/articles/9e6bad764d3f97)
- [DeNA・MoT AI技術共有会発表資料 H&Mコンペの振り返り](https://speakerdeck.com/kuto5046/denamot-aiji-shu-gong-you-hui-fa-biao-zi-liao-h-and-mkonpefalsezhen-rifan-ri)

---

- 1st stage: 質の高い複数のcandidate generation
- 2nd stage: GBDTでreranking

の2-stageレコメンドが一般的だった模様

---

Rでも[Tidymodels](https://www.tidymodels.org/)で[LightGBM](https://lightgbm.readthedocs.io/en/latest/R/index.html)を使えるし、  
Rで上位を目指せたかもしれない。

---

Q: RでKaggleを戦えるのか

---

A: コンペによってはいけるかも

---

ただ、現時点では、Pythonを読む必要がある

---

H&Mコンペで公開されたNotebokの数

<div class="fragment">
|        |   n |
|:---|---:|
| Python | 405 |
| R      |  14 |
</div>

----

そのうち4件は私

![](images/ss-notebooks-r.png){.img-shadow width="90%"}

---

みんなRでKaggleやろうな！

---

### Rで良かったところ

---

圧倒的に快適なデータ整形

![](images/logo/dplyr.png){width=25%}
![](images/logo/tidyr.png){width=25%}
![](images/logo/pipe.png){width=25%}

---

purrrで書いたリスト処理をfurrrでらくらく並列化

![](images/logo/purrr.png){width=25%}
![](images/logo/furrr.png){width=25%}

---

ほかにも便利なパッケージたくさん

![](images/logo/lubridate.png){width=25%}
![](images/logo/stringr.png){width=25%}

---

みんなRでKaggleやろうな！

---

Kaggleは楽しい

<div style="margin-top:1.2em">
- real worldの課題
- 世界中のエキスパートが同じ問題を解く
- チームメイトと友情・努力・勝利
</div>

---

## Enjoy!
