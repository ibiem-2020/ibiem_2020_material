Cat and Print
=============

Print
-----

A simple message

``` r
print("Hello")
```

    ## [1] "Hello"

Now let’s personalize it

``` r
name = "Josh"
print("Hello, my name is", name)
```

    ## Warning in print.default("Hello, my name is", name): NAs introduced by coercion

    ## Error in print.default("Hello, my name is", name): invalid 'digits' argument

Hmm, why didn’t that work?

``` r
help(print)
```

Beacuse `print` needs everything that you want printed as the first
argument. We can do that with `paste`!

``` r
name = "Josh"
print(paste("Hello, my name is", name))
```

    ## [1] "Hello, my name is Josh"

Let’s output some more information. To make it easy to read let’s put it
on a new line by printing the *newline* character `\n`.

``` r
name = "Josh"
print(paste("Hello, my name is", name, ". \nToday we are learning some awesome R."))
```

    ## [1] "Hello, my name is Josh . \nToday we are learning some awesome R."

That didn’t work right. And also there is a space between “Josh” and the
period, that’s ugly. We can fix all that . . .

``` r
name = "Josh"
print(paste("Hello, my name is ", name, ".", sep=""))
```

    ## [1] "Hello, my name is Josh."

``` r
print("Today we are learning some awesome R.")
```

    ## [1] "Today we are learning some awesome R."

. . . but it is starting to make our code more complicated. And the
“\[1\]” at the beginning of each line is kind of ugly. Maybe it is time
for a more powerful tool . . .

Cat
---

`cat` is similar to `print`, but different. It is more of a power tool,
it gives you more control, but with that control comes a bit more work
on your part.

``` r
cat("Hello")
```

    ## Hello

``` r
name = "Josh"
cat("Hello, my name is", name)
```

    ## Hello, my name is Josh

``` r
name = "Josh"
cat("Hello, my name is", name, ". \nToday we are learning some awesome R.")
```

    ## Hello, my name is Josh . 
    ## Today we are learning some awesome R.

Print vs Cat
------------

So why use `print` at all? For a lot of day to day stuff it is more
convenient.

``` r
print("Hello! Let's do some math.")
```

    ## [1] "Hello! Let's do some math."

``` r
1+1
```

    ## [1] 2

``` r
print("That should equal 2")
```

    ## [1] "That should equal 2"

``` r
cat("Hello! Let's do some math.")
```

    ## Hello! Let's do some math.

``` r
1+1
```

    ## [1] 2

``` r
cat("That should equal 2")
```

    ## That should equal 2

All along `print` has been quietly putting a newline at the end of
whatever it prints, that is *usually* what we want. `cat` doesn’t do
that automatically. More *control* also usually means more *work*
because control is usually the opposite of automatic.

We can get `cat` to do what we want, its just a bit more work:

``` r
cat("Hello! Let's do some math.", fill=TRUE)
```

    ## Hello! Let's do some math.

``` r
1+1
```

    ## [1] 2

``` r
cat("That should equal 2")
```

    ## That should equal 2

Of course more control also means more options . . .

``` r
cat("Hello! Let's do some math.\n", 1+1, "\nThat should equal 2", fill=TRUE)
```

    ## Hello! Let's do some math.
    ##  2 
    ## That should equal 2
