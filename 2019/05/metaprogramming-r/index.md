---
pagetitle: 初めてのRメタプログラミング
title: |
  <div style="font-size: 0.9em">
  初めての \
  Rメタプログラミング
  </div>
subtitle: |
  [Sendai.R #1](https://sendair.connpass.com/event/123977/)
author: |
  [\@igjit](https://twitter.com/igjit)
theme: white
revealjs-url: ../../../reveal.js
css: ../../../css/reveal_large_code.css
slideNumber: true
transition: none
history: true
---

<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

![](https://pbs.twimg.com/profile_images/378800000159013251/f5ddbed414eaafe0ef916e8619b58566.png)

[\@igjit](https://twitter.com/igjit)

- 東京から来ました
- Webアプリケーションエンジニア
- [Rで変なものを作るのが趣味](https://igjit.github.io/slides/)

---

いくつかのプログラミング言語を使ってきたけど

---

## Rはすごく不思議な言語

---

```r
x
# エラー:  オブジェクト 'x' がありません

log(x)
# エラー:  オブジェクト 'x' がありません

curve(log(x))  # これはok
```

---

いくつかのプログラミング言語を使ってきたけど

---

## Rはすごく強力な言語

---

<img src="../../../2018/12/nrc/images/logo/pipe.png" style="width:20%; box-shadow:none">

---

<p class="text-small">
[Tokyo.R#76 BeginneRSession-data pipeline](https://speakerdeck.com/kilometer/tokyo-dot-r-number-76-beginnersession-data-pipeline)
by [\@kilometer00](https://twitter.com/kilometer00)
</p>

![](images/ss-pipe1.png){width=80%}

---

<p class="text-small">
[Tokyo.R#76 BeginneRSession-data pipeline](https://speakerdeck.com/kilometer/tokyo-dot-r-number-76-beginnersession-data-pipeline)
by [\@kilometer00](https://twitter.com/kilometer00)
</p>

![](images/ss-pipe2.png){width=80%}

---

## すごい。

---

何がすごいか

---

渡した**コードの意味**が変わっている

- 引数が先頭に追加される
- プレースホルダー (`.`)

---

例えばJava​Script

---

<p style="font-size: 0.5em">
<https://developer.mozilla.org/ja/docs/Web/JavaScript/Reference/Operators/Pipeline_operator>
</p>

<img src="images/ss-js-pipe1.png" style="box-shadow:none">

---

<img src="images/ss-js-pipe2.png" style="box-shadow:none">

---

<img src="images/ss-js-pipe3.png" style="box-shadow:none">

---

Java​Scriptでパイプ演算子を使うには

<div class="fragment">
### 言語の進化を待たなければならない
</div>

---

Rだと

---

`%>%`は[magrittr](https://github.com/tidyverse/magrittr) packageで定義された**単なる演算子**

```r
library(magrittr)

1:10 %>% sum
```

---

自分で作ることもできる

![](images/ss-tiny-pipe.png)

<p class="text-small">
<https://igjit.github.io/slides/2018/01/tiny_pipe/#/>
</p>

---

宇宙のできる前のR(1.0.0)に異世界転生しても \
パイプ演算子を実装できる

![](images/ss-r1.png){width=70%}

<p class="text-small">
[宇宙が生まれる前の話](https://github.com/8-u8/TokyoR/blob/master/20190119/R%E8%A8%80%E8%AA%9E%E8%B6%85%E5%85%A5%E9%96%80_opened.pdf) by [\@0_u0](https://twitter.com/0_u0)
</p>

---

このセッションの目標

---

R言語について知る

- 演算子
- 遅延評価
- NSE

---

そしてメタプログラミングを使って

### パイプ演算子を実装できるようになる

---

<p class="text-small">
※以降の内容は基本的に[パイプ演算子自作入門](https://igjit.github.io/slides/2018/01/tiny_pipe/#/)を加筆修正したものになります。
</p>

---

## 1. 演算子

---

中置演算子

```r
1 + 2
```

関数呼び出し

```r
sum(1, 2)
```

---

実は

## R内で起きることすべては関数呼び出しである。

---

これは

```r
1 + 2
```

<div class="fragment">
これと等価

```r
`+`(1, 2)
```
</div>

---

これは

```r
1:10
```

<div class="fragment">
これと等価

```r
`:`(1, 10)
```
</div>

---

なのでこれは

```r
a %>% b
```

<div class="fragment">
これと等価

```r
`%>%`(a, b)
```
</div>

---

演算子を定義する

```r
`%add%` <- function(a, b) {
  a + b
}
```
<div class="fragment">
```r
1 %add% 2
# [1] 3
```
</div>

---

ここまでの知識で

## パイプ演算子を実装してみよう

---

これは

```r
a %>% b
```

<div class="fragment">
こういうことなので

```r
b(a)
```
</div>

---

こう実装できる

```r
`%pipe%` <- function(a, b) {
  b(a)
}
```

---

動いた

```r
1:10 %pipe% sum
# [1] 55
```

<div class="fragment">
chainもできる

```r
1:10 %pipe% log %pipe% plot
```
</div>

---

でも右辺が関数呼び出しだとだめ

```r
1:10 %pipe% sum()  # エラー
```

---

もう少し知識が必要

---

## 2. 遅延評価

---

Rの関数では

## 引数は遅延評価される

<div class="fragment">
つまり

## 引数が使われた場合に初めて評価される
</div>

---

```r
f <- function(a, b) {
  if (a > 0) b
}
```

<div class="fragment">
```r
f(1, stop("This is an error!"))
# f(1, stop("This is an error!")) でエラー (#1 から) : This is an error!

f(0, stop("This is an error!"))  # 何も起きない
```
</div>

---

## 3. 非標準評価

---

```r
curve(log(x))
```

![](../../../2018/01/tiny_pipe/images/log_x_m.png)

---

Rの関数は、引数の値だけでなく

## 引数を計算するコードを参照できる

---

この引数を計算するコードを利用する評価方法が

## 非標準評価

NSE (Non-standard evaluation)

---

`substitute()` で表現式を捕捉できる

```r
f <- function(x) {
  substitute(x)
}
```

```r
f(1 + 2)
# 1 + 2
```
---

`quote()` でも表現式を捕捉できる

```r
quote(1 + 2)
# 1 + 2
```

---

ただし関数内での挙動が違う

```r
f <- function(x) {
  substitute(x)
}

f(1 + 2)
# 1 + 2
```

```r
f <- function(x) {
  quote(x)
}

f(1 + 2)
# x
```

---

`eval()` で表現式を評価できる

```r
quote(1 + 2)
# 1 + 2

eval(quote(1 + 2))
# [1] 3
```

---

`eval()` の第2引数で環境を指定できる

```r
e <- new.env()
e$x <- 40

eval(quote(x + 2), e)
# [1] 42
```

---

## 4. メタプログラミング

---

`quote()` は表現式を返す

```r
quote(1 + 2)
# 1 + 2
```

---

表現式は

## 木構造

abstract syntax tree (AST) とも呼ばれる

---

`pryr::ast()` で木構造を見ることができる

```r
ast(1 + 2 * 3)
# \- ()
#   \- `+
#   \-  1
#   \- ()
#     \- `*
#     \-  2
#     \-  3 
```

---

<div style="display: inline-block">
<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">うぉ、 <a href="https://t.co/kvC7vXpkbw">pic.twitter.com/kvC7vXpkbw</a></p>&mdash; kilometer (@kilometer00) <a href="https://twitter.com/kilometer00/status/1119434786047533056?ref_src=twsrc%5Etfw">April 20, 2019</a></blockquote>
<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">Lisp、お前だったのか。</p>&mdash; kilometer (@kilometer00) <a href="https://twitter.com/kilometer00/status/1119435328886992897?ref_src=twsrc%5Etfw">April 20, 2019</a></blockquote>
</div>

---

表現式はlistのように扱える

```r
expr <- quote(1 + 2)

as.list(expr)
# [[1]]
# `+`
# 
# [[2]]
# [1] 1
# 
# [[3]]
# [1] 2

expr[[1]]
# `+`
```

---

表現式は修正できる

```r
expr <- quote(1 + 2)
expr[[1]] <- quote(`*`)

expr
# 1 * 2
```

---

ということは

---

### コードの意味を変えることができる

```r
f <- function(x) {
  expr <- substitute(x)
  expr[[1]] <- quote(`*`)  # 関数名を差し替える
  eval(expr)
}
```

```r
3 + 4
# [1] 7

f(3 + 4)
# [1] 12

f(3 > 4)
# [1] 12
```

---

構文木を読み書きする

## メタプログラミング

---

もういちどパイプ演算子を実装してみよう

---

`x %>% f(y)` が `f(x, y)` と等価

`f` の引数の先頭に `x` を追加すれば良い

---

バージョン2

```r
`%pipe2%` <- function(lhs, rhs) {
  env <- parent.frame()  # 関数の呼び出し環境
  expr <- substitute(rhs)
  eval(as.call(c(expr[[1]],
                 substitute(lhs),
                 as.list(expr[-1]))),
       env)
}
```

---

動いた

```r
1:10 %pipe2% head(n = 3)
# [1] 1 2 3
```

---

でもプレースホルダー (`.`) に対応していない

```r
1:10 %pipe2% head(.)  # エラー
```

---

もう少しがんばる

---

表現式がドットを含むかどうか確認する補助関数

```r
has_dot <- function(expr) {
  any(vapply(expr, identical, logical(1), quote(.)))
}
```

```r
has_dot(quote(1 + 2))
# [1] FALSE

has_dot(quote(1 + .))
# [1] TRUE
```

---

引数の先頭にドットを追加する補助関数

```r
insert_dot <- function(expr) {
  as.call(c(expr[[1]], quote(.), as.list(expr[-1])))
}
```

```r
insert_dot(quote(head(n = 3)))
# head(., n = 3)
```

---

バージョン3

```r
`%pipe3%` <- function(lhs, rhs) {
  env <- parent.frame()
  expr <- substitute(rhs)
  dotted <- if (has_dot(expr)) expr else insert_dot(expr)
  eval(dotted, list(. = lhs), env)
}
```

---

右辺にドットがあってもなくても動く

```r
1:10 %pipe3% head(.)
# [1] 1 2 3 4 5 6

1:10 %pipe3% head(n = 3)
# [1] 1 2 3
```

---

追加情報

---

<div style="display: inline-block">
<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">あーほんとだ<br>右辺が関数名だと動かないですね😇<br>ありがとうございます!</p>&mdash; igjit (@igjit) <a href="https://twitter.com/igjit/status/1128336965932204034?ref_src=twsrc%5Etfw">May 14, 2019</a></blockquote>
</div>

---

<div style="display: inline-block">
<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">書いた。Thanks <a href="https://twitter.com/Atsushi776?ref_src=twsrc%5Etfw">@Atsushi776</a><br>パイプ演算子自作入門のその後<a href="https://t.co/zU6G6ZTdU0">https://t.co/zU6G6ZTdU0</a></p>&mdash; igjit (@igjit) <a href="https://twitter.com/igjit/status/1129007901136150535?ref_src=twsrc%5Etfw">May 16, 2019</a></blockquote>
</div>

---

ちなみに本物のパイプ演算子を使いたい場合は

```r
library(magrittr)
```

---

`magrittr`のソースコード読むと楽しいよ。

<p class="text-small">
<https://github.com/tidyverse/magrittr>
</p>

---

## 参考文献

---

![](https://images-na.ssl-images-amazon.com/images/I/81weJloOAnL.jpg){height="600px"}

---

- 私が今まで読んだ中で最高のRの本
- 本当に徹底解説
- 興味深い話題
    - 環境オブジェクト
    - 関数型プログラミング
    - DSL
    - コードの最適化

---

追加情報

---

原著 (Advanced R) の[2nd edition](https://adv-r.hadley.nz/)では

[rlang](https://github.com/r-lib/rlang)を使ったよりモダンなメタプログラミングを説明している。

---

## まとめ

---

構文木を読み書きできる

### メタプログラミング

---

偉大なる力

---

使用例

- 構文木の変換 ([(続 ((Rで) 書く (Lisp) インタプリタ))](https://igjit.github.io/slides/2018/03/lisprr/#/31))
- 構文木を読んで型推論 ([Rがときめく型付けの魔法](https://igjit.github.io/slides/2019/04/typrr/#/))

---

<div style="display: inline-block">
<blockquote class="twitter-tweet" data-lang="ja"><p lang="ja" dir="ltr">抽象構文木を操作してこその人生なのです</p>&mdash; igjit (@igjit) <a href="https://twitter.com/igjit/status/968475819583594498?ref_src=twsrc%5Etfw">2018年2月27日</a></blockquote>
</div>

---

Rはすごく不思議な言語

Rはすごく強力な言語

<p class="fragment">
Rはすごく**楽しい**言語
</p>

---

## Enjoy!
