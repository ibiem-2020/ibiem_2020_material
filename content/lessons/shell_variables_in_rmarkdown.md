Every R Chunk is a Piece of the Continent
=========================================

As we have seen, R chunks share an environment - a variable defined in
one R chunk is available in all the R chunks after it in the document.

``` r
secret_identity="Dracula"
print(secret_identity)
```

    ## [1] "Dracula"

``` r
print(secret_identity)
```

    ## [1] "Dracula"

``` r
secret_identity="Count Chocula"
print(secret_identity)
```

    ## [1] "Count Chocula"

``` r
print(secret_identity)
```

    ## [1] "Count Chocula"

Every Bash Chunk is an Island
=============================

In RMarkdown bash chunks behave differently than R chunks. In RMarkdown
each bash chunk is its own environment, so shell variables defined in
one bash chunk are not available in any others.

``` bash
export SECRET_IDENTITY=Dracula
echo $SECRET_IDENTITY
```

    ## Dracula

``` bash
echo $SECRET_IDENTITY
```

> By default bash does not raise an error when you try to use an
> undefined variable, undefined variables just default to empty values.

``` bash
set -u
echo $SECRET_IDENTITY
```

    ## Error in running command bash

> `set -u` is a safety belt - after calling it in a bash session, bash
> *will* raise an error if you try to use an undefined variable. Of
> course, in Rmarkdown calling `set -u` in a chunk only affects that
> chunk.

Building an R Bridge to Bash
============================

R can communicate with bash through shell variables. We can define shell
variables using the R function `Sys.setenv`.

``` r
Sys.setenv(MY_NAME="Inigo Montoya")
```

The bash chunks in an RMarkdown document borrow the environment of the R
chunks, so shell variables defined with `Sys.setenv` are available
within bash chunks.

``` bash
echo $MY_NAME
```

    ## Inigo Montoya

R chunks can get the values of shell variables with `Sys.getenv`,
although it doesn’t work for shell variables defined within a bash chunk

``` r
Sys.getenv("MY_NAME")
```

    ## [1] "Inigo Montoya"

`Sys.setenv` can assign a value to a shell variable from an R variable

``` r
Sys.setenv(SECRET_IDENTITY=secret_identity)
```

``` bash
echo $SECRET_IDENTITY
```

    ## Count Chocula

There is no need for the shell variable to have the same name as the R
variable.

``` r
Sys.setenv(MY_NAME=secret_identity)
```

``` bash
echo $MY_NAME
```

    ## Count Chocula

It is common practice for the names of shell variables to be
capitalized, but that is not a requirment

``` r
Sys.setenv(icecream="Cookie Dough")
```

``` bash
echo $icecream
```

    ## Cookie Dough
