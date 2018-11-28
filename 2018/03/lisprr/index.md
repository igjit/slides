---
title: (続 ((Rで) 書く (Lisp) インタプリタ))
author: '<a href="https://twitter.com/igjit">@igjit</a>'
theme: white
revealjs-url: ../../../reveal.js
css: ../../../css/reveal_large_code.css
slideNumber: true
transition: none
history: true
---

前回のTokyo.Rでこんな話をしました。

---

<https://igjit.github.io/slides/2018/01/tiny_pipe/>
![](images/ss_pipe.png)

---

言いたかったのは

---

## Rはすごく不思議な言語

---

# 演算子

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

代入も

```r
x <- 2
```

<div class="fragment">
関数呼び出し

```r
`<-`(x, 10)
```
</div>

---

制御構文も

```r
if (x < 0) -x else x
```

<div class="fragment">
関数呼び出し

```r
`if`(x < 0, -x, x)
```
</div>

---

## !?

# 遅延評価

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

# メタプログラミング

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

## Lispっぽい

<figure><img src="images/alien.png" style="box-shadow: none;"></figure>

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
expr[[1]] <-  quote(`*`)

expr
# 1 * 2
```

---

構文木を読み書きする

## メタプログラミング

---

ところでだいぶ前のTokyo.Rでこんな話をしました。

---

<iframe src="//www.slideshare.net/slideshow/embed_code/key/3HbfBlZBCllo4y" width="595" height="485" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe>

---

## メタプログラミングを使えばもっと簡単に書けるのでは？

---

やってみた。

---

## lisprr

<https://github.com/igjit/lisprr>

---

インストール

```r
devtools::install_github("igjit/lisprr")
```

# あそびかた

---

S式をRの表現式に変換する

```r
lisprr::translate("(+ 1 2)")
#> 1 + 2
```

<div class="fragment">
```r
lisprr::translate("(lambda (x) (+ x 2))")
#> function(x = NULL) {
#>     x + 2
#> }
```
</div>

---

S式を実行

```r
lisprr::evaluate("(+ 1 2)")
#> [1] 3
```

---

Lispで書いた関数を

```r
lisprr::evaluate("(define add2 (lambda (x) (+ x 2)))",
                 parent.frame())
```

<div class="fragment">
Rで使える

```r
add2(40)
#> [1] 42
```
</div>

---

REPLを起動すると

```r
> lisprr::repl()
```

---

Rコンソール上でLispが動く

```lisp
lisprr> (+ 1 2)
3
lisprr> (define add2 (lambda (x) (+ x 2)))
#<closure>
lisprr> (add2 40)
42
```

---

Rの関数も使える

```lisp
lisprr> (: 1 10)
1 2 3 4 5 6 7 8 9 10
lisprr> (plot iris)
```

---

*demo*

---

作ってみた感想

---

## 楽しい！

<figure><img src="images/alien.png" style="box-shadow: none;"></figure>

---

<div style="display: inline-block">

<blockquote class="twitter-tweet" data-lang="ja"><p lang="ja" dir="ltr">抽象構文木を操作してこその人生なのです</p>&mdash; igjit (@igjit) <a href="https://twitter.com/igjit/status/968475819583594498?ref_src=twsrc%5Etfw">2018年2月27日</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

</div>

---

## lisprr

<https://github.com/igjit/lisprr>

---

## Enjoy!

<figure><img src="images/alien.png" style="box-shadow: none;"></figure>
