Setup
=====

First we load libraries.

``` r
library(readr)
library(fs)
library(dplyr)
library(tibble)
library(Biostrings)
# library(R.utils)
```

Paths, Directories, and Shell Variables
---------------------------------------

To keep the code readable and portable, it is nice to assign paths to
variables. We also need to use the R `Sys.setenv` command to make shell
variables that can be used in the bash chunks below.

Check Data Integrity
--------------------

``` bash
cd $RAW_FASTQ_DIR
md5sum -c md5sum.txt
```

    ## barcodes.fastq.gz: OK
    ## forward.fastq.gz: OK
    ## reverse.fastq.gz: OK
    ## sample_metadata.tsv: OK

Demultiplexing
==============

We will be using `fastq-multx` to demultiplex the data. It does not have
very good documentation. But, we can get some instructions if we run it
without any command line options.

``` bash
fastq-multx
```

    ## Usage: fastq-multx [-g|-l|-B] <barcodes.fil> <read1.fq> -o r1.%.fq [mate.fq -o r2.%.fq] ...
    ## Version: 1.02.772
    ## 
    ## Output files must contain a '%' sign which is replaced with the barcode id in the barcodes file.
    ## Output file can be n/a to discard the corresponding data (use this for the barcode read)
    ## 
    ## Barcodes file (-B) looks like this:
    ## 
    ## <id1> <sequence1>
    ## <id2> <sequence2> ...
    ## 
    ## Default is to guess the -bol or -eol based on clear stats.
    ## 
    ## If -g is used, then it's parameter is an index lane, and frequently occuring sequences are used.
    ## 
    ## If -l is used then all barcodes in the file are tried, and the *group* with the *most* matches is chosen.
    ## 
    ## Grouped barcodes file (-l or -L) looks like this:
    ## 
    ## <id1> <sequence1> <group1>
    ## <id1> <sequence1> <group1>
    ## <id2> <sequence2> <group2>...
    ## 
    ## Mated reads, if supplied, are kept in-sync
    ## 
    ## Options:
    ## 
    ## -o FIL1     Output files (one per input, required)
    ## -g SEQFIL   Determine barcodes from the indexed read SEQFIL
    ## -l BCFIL    Determine barcodes from any read, using BCFIL as a master list
    ## -L BCFIL    Determine barcodes from <read1.fq>, using BCFIL as a master list
    ## -B BCFIL    Use barcodes from BCFIL, no determination step, codes in <read1.fq>
    ## -H          Use barcodes from illumina's header, instead of a read
    ## -b          Force beginning of line (5') for barcode matching
    ## -e          Force end of line (3') for batcode matching
    ## -t NUM      Divide threshold for auto-determine by factor NUM (1), > 1 = more sensitive
    ## -G NAME     Use group(s) matching NAME only
    ## -x          Don't trim barcodes off before writing out destination
    ## -n          Don't execute, just print likely barcode list
    ## -v C        Verify that mated id's match up to character C (Use ' ' for illumina)
    ## -m N        Allow up to N mismatches, as long as they are unique (1)
    ## -d N        Require a minimum distance of N between the best and next best (2)
    ## -q N        Require a minimum phred quality of N to accept a barcode base (0)

Barcode Table
-------------

The `fastq-multx` help tells us that we can supply it with a
tab-separated file specifying the sample ID in the first column and the
barcode sequence that corresponds with it in the second column. We can
easily generate a file like this from our map file using the unix `cut`
command. The purpose of `cut` is to extract specific columns from files.
The sample IDs and barcode sequences are in columns (fields) 1 and 2 of
the map file. Here is the command that we want to use.

``` bash
set -u
cut --fields 1,2 $MAP_FILE > $BARCODE_TABLE
```

Now let’s take a peek at the barcode tsv that we have generated to be
sure it looks as expected.

``` bash
set -u
head $BARCODE_TABLE
```

    ## #SampleID    BarcodeSequence
    ## #q2:types    categorical
    ## BAQ1370.1.2  GCCCAAGTTCAC
    ## BAQ1370.3    GCGCCGAATCTT
    ## BAQ1370.1.3  ATAAAGAGGAGG
    ## BAQ1552.1.1  ATCCCAGCATGC
    ## BAQ1552.2    GCTTCCAGACAA
    ## BAQ2420.1.1  ACACAGTCCTGA
    ## BAQ2420.1.2  ATTATACGGCGC
    ## BAQ2420.2    TAAACGCGACTC

Running fastq-multx
-------------------

We now have everything we need to run `fastq-multx`. Here is an
explanation for the command line options that we use

-m : number of mismatches to allow in barcode (relative to the barcode
supplied in the barcode table) -x : don’t trim barcodes (this isn’t
necessary) -B BARCODE\_FILE : a list of known barcodes, and the
associated sample names -d : minimum edit distance between the best and
next best match BARCODE\_FASTQ : the index read FASTQ, which will be
used to demultiplex other reads R1\_FASTQ : the R1 raw data to
demultiplex R2\_FASTQ : (optional) if data is paired-end, the R2 raw
data to demultiplex

-o OUTPUT\_FILE(s) : fastq-multx will produce a separate file for each
barcode (two files when paired-end reads are input, three files when
barcodes are in a separate I1 FASTQ). This option provides a template
for naming the output file - the program will fill in the “%” with the
barcode.

Because of the way `fastq-multx` is designed (to allow demuxing of
FASTQs that have the barcode embeded in the R1 sequence), it will
actually demux the I1 FASTQ. Since we are only interesed in the R1 and
R2, we can ignore the demuxed I1 files.

``` bash
set -u
fastq-multx -m 3 -d 2 -x -B $BARCODE_TABLE \
  $BARCODE_FASTQ \
  $R1_FASTQ \
  $R2_FASTQ \
  -o $DEMUX_DIR/%_I1.fastq.gz \
  -o $DEMUX_DIR/%.forward.fastq.gz \
  -o $DEMUX_DIR/%.reverse.fastq.gz
```

    ## Using Barcode File: /home/guest/scratch/atacama_1pct/barcodes_for_fastqmultx.tsv
    ## End used: start
    ## Skipped because of distance < 2 : 78
    ## Id   Count   File(s)
    ## BAQ1370.1.2  3   /home/guest/scratch/atacama_1pct/demux/BAQ1370.1.2_I1.fastq.gz  /home/guest/scratch/atacama_1pct/demux/BAQ1370.1.2.forward.fastq.gz /home/guest/scratch/atacama_1pct/demux/BAQ1370.1.2.reverse.fastq.gz
    ## BAQ1370.3    640 /home/guest/scratch/atacama_1pct/demux/BAQ1370.3_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/BAQ1370.3.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/BAQ1370.3.reverse.fastq.gz
    ## BAQ1370.1.3  28  /home/guest/scratch/atacama_1pct/demux/BAQ1370.1.3_I1.fastq.gz  /home/guest/scratch/atacama_1pct/demux/BAQ1370.1.3.forward.fastq.gz /home/guest/scratch/atacama_1pct/demux/BAQ1370.1.3.reverse.fastq.gz
    ## BAQ1552.1.1  5   /home/guest/scratch/atacama_1pct/demux/BAQ1552.1.1_I1.fastq.gz  /home/guest/scratch/atacama_1pct/demux/BAQ1552.1.1.forward.fastq.gz /home/guest/scratch/atacama_1pct/demux/BAQ1552.1.1.reverse.fastq.gz
    ## BAQ1552.2    12  /home/guest/scratch/atacama_1pct/demux/BAQ1552.2_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/BAQ1552.2.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/BAQ1552.2.reverse.fastq.gz
    ## BAQ2420.1.1  5   /home/guest/scratch/atacama_1pct/demux/BAQ2420.1.1_I1.fastq.gz  /home/guest/scratch/atacama_1pct/demux/BAQ2420.1.1.forward.fastq.gz /home/guest/scratch/atacama_1pct/demux/BAQ2420.1.1.reverse.fastq.gz
    ## BAQ2420.1.2  1   /home/guest/scratch/atacama_1pct/demux/BAQ2420.1.2_I1.fastq.gz  /home/guest/scratch/atacama_1pct/demux/BAQ2420.1.2.forward.fastq.gz /home/guest/scratch/atacama_1pct/demux/BAQ2420.1.2.reverse.fastq.gz
    ## BAQ2420.2    8   /home/guest/scratch/atacama_1pct/demux/BAQ2420.2_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/BAQ2420.2.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/BAQ2420.2.reverse.fastq.gz
    ## BAQ2420.3    4   /home/guest/scratch/atacama_1pct/demux/BAQ2420.3_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/BAQ2420.3.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/BAQ2420.3.reverse.fastq.gz
    ## BAQ2420.1.3  53  /home/guest/scratch/atacama_1pct/demux/BAQ2420.1.3_I1.fastq.gz  /home/guest/scratch/atacama_1pct/demux/BAQ2420.1.3.forward.fastq.gz /home/guest/scratch/atacama_1pct/demux/BAQ2420.1.3.reverse.fastq.gz
    ## BAQ2462.1    785 /home/guest/scratch/atacama_1pct/demux/BAQ2462.1_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/BAQ2462.1.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/BAQ2462.1.reverse.fastq.gz
    ## BAQ2462.2    1   /home/guest/scratch/atacama_1pct/demux/BAQ2462.2_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/BAQ2462.2.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/BAQ2462.2.reverse.fastq.gz
    ## BAQ2462.3    2   /home/guest/scratch/atacama_1pct/demux/BAQ2462.3_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/BAQ2462.3.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/BAQ2462.3.reverse.fastq.gz
    ## BAQ2687.1    1   /home/guest/scratch/atacama_1pct/demux/BAQ2687.1_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/BAQ2687.1.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/BAQ2687.1.reverse.fastq.gz
    ## BAQ2687.2    22  /home/guest/scratch/atacama_1pct/demux/BAQ2687.2_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/BAQ2687.2.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/BAQ2687.2.reverse.fastq.gz
    ## BAQ2687.3    4   /home/guest/scratch/atacama_1pct/demux/BAQ2687.3_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/BAQ2687.3.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/BAQ2687.3.reverse.fastq.gz
    ## BAQ2838.1    3   /home/guest/scratch/atacama_1pct/demux/BAQ2838.1_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/BAQ2838.1.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/BAQ2838.1.reverse.fastq.gz
    ## BAQ2838.2    6   /home/guest/scratch/atacama_1pct/demux/BAQ2838.2_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/BAQ2838.2.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/BAQ2838.2.reverse.fastq.gz
    ## BAQ2838.3    8   /home/guest/scratch/atacama_1pct/demux/BAQ2838.3_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/BAQ2838.3.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/BAQ2838.3.reverse.fastq.gz
    ## BAQ3473.1    1671    /home/guest/scratch/atacama_1pct/demux/BAQ3473.1_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/BAQ3473.1.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/BAQ3473.1.reverse.fastq.gz
    ## BAQ3473.2    10  /home/guest/scratch/atacama_1pct/demux/BAQ3473.2_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/BAQ3473.2.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/BAQ3473.2.reverse.fastq.gz
    ## BAQ3473.3    20  /home/guest/scratch/atacama_1pct/demux/BAQ3473.3_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/BAQ3473.3.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/BAQ3473.3.reverse.fastq.gz
    ## BAQ4166.1.1  4   /home/guest/scratch/atacama_1pct/demux/BAQ4166.1.1_I1.fastq.gz  /home/guest/scratch/atacama_1pct/demux/BAQ4166.1.1.forward.fastq.gz /home/guest/scratch/atacama_1pct/demux/BAQ4166.1.1.reverse.fastq.gz
    ## BAQ4166.1.2  2   /home/guest/scratch/atacama_1pct/demux/BAQ4166.1.2_I1.fastq.gz  /home/guest/scratch/atacama_1pct/demux/BAQ4166.1.2.forward.fastq.gz /home/guest/scratch/atacama_1pct/demux/BAQ4166.1.2.reverse.fastq.gz
    ## BAQ4166.2    31  /home/guest/scratch/atacama_1pct/demux/BAQ4166.2_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/BAQ4166.2.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/BAQ4166.2.reverse.fastq.gz
    ## BAQ4166.3    16  /home/guest/scratch/atacama_1pct/demux/BAQ4166.3_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/BAQ4166.3.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/BAQ4166.3.reverse.fastq.gz
    ## BAQ4166.1.3  7   /home/guest/scratch/atacama_1pct/demux/BAQ4166.1.3_I1.fastq.gz  /home/guest/scratch/atacama_1pct/demux/BAQ4166.1.3.forward.fastq.gz /home/guest/scratch/atacama_1pct/demux/BAQ4166.1.3.reverse.fastq.gz
    ## BAQ4697.1    6   /home/guest/scratch/atacama_1pct/demux/BAQ4697.1_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/BAQ4697.1.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/BAQ4697.1.reverse.fastq.gz
    ## BAQ4697.2    850 /home/guest/scratch/atacama_1pct/demux/BAQ4697.2_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/BAQ4697.2.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/BAQ4697.2.reverse.fastq.gz
    ## BAQ4697.3    23  /home/guest/scratch/atacama_1pct/demux/BAQ4697.3_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/BAQ4697.3.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/BAQ4697.3.reverse.fastq.gz
    ## BAQ895.2 25  /home/guest/scratch/atacama_1pct/demux/BAQ895.2_I1.fastq.gz /home/guest/scratch/atacama_1pct/demux/BAQ895.2.forward.fastq.gz    /home/guest/scratch/atacama_1pct/demux/BAQ895.2.reverse.fastq.gz
    ## BAQ895.3 4   /home/guest/scratch/atacama_1pct/demux/BAQ895.3_I1.fastq.gz /home/guest/scratch/atacama_1pct/demux/BAQ895.3.forward.fastq.gz    /home/guest/scratch/atacama_1pct/demux/BAQ895.3.reverse.fastq.gz
    ## YUN1005.1.1  7   /home/guest/scratch/atacama_1pct/demux/YUN1005.1.1_I1.fastq.gz  /home/guest/scratch/atacama_1pct/demux/YUN1005.1.1.forward.fastq.gz /home/guest/scratch/atacama_1pct/demux/YUN1005.1.1.reverse.fastq.gz
    ## YUN1005.2    3   /home/guest/scratch/atacama_1pct/demux/YUN1005.2_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/YUN1005.2.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/YUN1005.2.reverse.fastq.gz
    ## YUN1005.3    1   /home/guest/scratch/atacama_1pct/demux/YUN1005.3_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/YUN1005.3.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/YUN1005.3.reverse.fastq.gz
    ## YUN1005.1.3  5   /home/guest/scratch/atacama_1pct/demux/YUN1005.1.3_I1.fastq.gz  /home/guest/scratch/atacama_1pct/demux/YUN1005.1.3.forward.fastq.gz /home/guest/scratch/atacama_1pct/demux/YUN1005.1.3.reverse.fastq.gz
    ## YUN1242.1    2   /home/guest/scratch/atacama_1pct/demux/YUN1242.1_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/YUN1242.1.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/YUN1242.1.reverse.fastq.gz
    ## YUN1242.2    4   /home/guest/scratch/atacama_1pct/demux/YUN1242.2_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/YUN1242.2.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/YUN1242.2.reverse.fastq.gz
    ## YUN1242.3    4   /home/guest/scratch/atacama_1pct/demux/YUN1242.3_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/YUN1242.3.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/YUN1242.3.reverse.fastq.gz
    ## YUN1609.1    3   /home/guest/scratch/atacama_1pct/demux/YUN1609.1_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/YUN1609.1.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/YUN1609.1.reverse.fastq.gz
    ## YUN1609.3    7   /home/guest/scratch/atacama_1pct/demux/YUN1609.3_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/YUN1609.3.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/YUN1609.3.reverse.fastq.gz
    ## YUN2029.1    14  /home/guest/scratch/atacama_1pct/demux/YUN2029.1_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/YUN2029.1.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/YUN2029.1.reverse.fastq.gz
    ## YUN2029.2    18  /home/guest/scratch/atacama_1pct/demux/YUN2029.2_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/YUN2029.2.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/YUN2029.2.reverse.fastq.gz
    ## YUN2029.3    12  /home/guest/scratch/atacama_1pct/demux/YUN2029.3_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/YUN2029.3.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/YUN2029.3.reverse.fastq.gz
    ## YUN3008.1.1  20  /home/guest/scratch/atacama_1pct/demux/YUN3008.1.1_I1.fastq.gz  /home/guest/scratch/atacama_1pct/demux/YUN3008.1.1.forward.fastq.gz /home/guest/scratch/atacama_1pct/demux/YUN3008.1.1.reverse.fastq.gz
    ## YUN3008.1.2  5   /home/guest/scratch/atacama_1pct/demux/YUN3008.1.2_I1.fastq.gz  /home/guest/scratch/atacama_1pct/demux/YUN3008.1.2.forward.fastq.gz /home/guest/scratch/atacama_1pct/demux/YUN3008.1.2.reverse.fastq.gz
    ## YUN3008.2    12  /home/guest/scratch/atacama_1pct/demux/YUN3008.2_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/YUN3008.2.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/YUN3008.2.reverse.fastq.gz
    ## YUN3008.3    1   /home/guest/scratch/atacama_1pct/demux/YUN3008.3_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/YUN3008.3.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/YUN3008.3.reverse.fastq.gz
    ## YUN3008.1.3  30  /home/guest/scratch/atacama_1pct/demux/YUN3008.1.3_I1.fastq.gz  /home/guest/scratch/atacama_1pct/demux/YUN3008.1.3.forward.fastq.gz /home/guest/scratch/atacama_1pct/demux/YUN3008.1.3.reverse.fastq.gz
    ## YUN3153.1    7   /home/guest/scratch/atacama_1pct/demux/YUN3153.1_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/YUN3153.1.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/YUN3153.1.reverse.fastq.gz
    ## YUN3153.2    5   /home/guest/scratch/atacama_1pct/demux/YUN3153.2_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/YUN3153.2.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/YUN3153.2.reverse.fastq.gz
    ## YUN3153.3    24  /home/guest/scratch/atacama_1pct/demux/YUN3153.3_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/YUN3153.3.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/YUN3153.3.reverse.fastq.gz
    ## YUN3184.1    1   /home/guest/scratch/atacama_1pct/demux/YUN3184.1_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/YUN3184.1.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/YUN3184.1.reverse.fastq.gz
    ## YUN3184.2    4   /home/guest/scratch/atacama_1pct/demux/YUN3184.2_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/YUN3184.2.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/YUN3184.2.reverse.fastq.gz
    ## YUN3259.1.1  2   /home/guest/scratch/atacama_1pct/demux/YUN3259.1.1_I1.fastq.gz  /home/guest/scratch/atacama_1pct/demux/YUN3259.1.1.forward.fastq.gz /home/guest/scratch/atacama_1pct/demux/YUN3259.1.1.reverse.fastq.gz
    ## YUN3259.1.2  6   /home/guest/scratch/atacama_1pct/demux/YUN3259.1.2_I1.fastq.gz  /home/guest/scratch/atacama_1pct/demux/YUN3259.1.2.forward.fastq.gz /home/guest/scratch/atacama_1pct/demux/YUN3259.1.2.reverse.fastq.gz
    ## YUN3259.2    9   /home/guest/scratch/atacama_1pct/demux/YUN3259.2_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/YUN3259.2.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/YUN3259.2.reverse.fastq.gz
    ## YUN3259.3    5   /home/guest/scratch/atacama_1pct/demux/YUN3259.3_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/YUN3259.3.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/YUN3259.3.reverse.fastq.gz
    ## YUN3259.1.3  10  /home/guest/scratch/atacama_1pct/demux/YUN3259.1.3_I1.fastq.gz  /home/guest/scratch/atacama_1pct/demux/YUN3259.1.3.forward.fastq.gz /home/guest/scratch/atacama_1pct/demux/YUN3259.1.3.reverse.fastq.gz
    ## YUN3346.1    4   /home/guest/scratch/atacama_1pct/demux/YUN3346.1_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/YUN3346.1.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/YUN3346.1.reverse.fastq.gz
    ## YUN3346.2    4   /home/guest/scratch/atacama_1pct/demux/YUN3346.2_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/YUN3346.2.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/YUN3346.2.reverse.fastq.gz
    ## YUN3346.3    4   /home/guest/scratch/atacama_1pct/demux/YUN3346.3_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/YUN3346.3.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/YUN3346.3.reverse.fastq.gz
    ## YUN3428.1    22  /home/guest/scratch/atacama_1pct/demux/YUN3428.1_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/YUN3428.1.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/YUN3428.1.reverse.fastq.gz
    ## YUN3428.2    26  /home/guest/scratch/atacama_1pct/demux/YUN3428.2_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/YUN3428.2.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/YUN3428.2.reverse.fastq.gz
    ## YUN3428.3    19  /home/guest/scratch/atacama_1pct/demux/YUN3428.3_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/YUN3428.3.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/YUN3428.3.reverse.fastq.gz
    ## YUN3533.1.1  978 /home/guest/scratch/atacama_1pct/demux/YUN3533.1.1_I1.fastq.gz  /home/guest/scratch/atacama_1pct/demux/YUN3533.1.1.forward.fastq.gz /home/guest/scratch/atacama_1pct/demux/YUN3533.1.1.reverse.fastq.gz
    ## YUN3533.1.2  8   /home/guest/scratch/atacama_1pct/demux/YUN3533.1.2_I1.fastq.gz  /home/guest/scratch/atacama_1pct/demux/YUN3533.1.2.forward.fastq.gz /home/guest/scratch/atacama_1pct/demux/YUN3533.1.2.reverse.fastq.gz
    ## YUN3533.2    27  /home/guest/scratch/atacama_1pct/demux/YUN3533.2_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/YUN3533.2.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/YUN3533.2.reverse.fastq.gz
    ## YUN3533.3    3   /home/guest/scratch/atacama_1pct/demux/YUN3533.3_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/YUN3533.3.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/YUN3533.3.reverse.fastq.gz
    ## YUN3533.1.3  3   /home/guest/scratch/atacama_1pct/demux/YUN3533.1.3_I1.fastq.gz  /home/guest/scratch/atacama_1pct/demux/YUN3533.1.3.forward.fastq.gz /home/guest/scratch/atacama_1pct/demux/YUN3533.1.3.reverse.fastq.gz
    ## YUN3856.1.1  0   /home/guest/scratch/atacama_1pct/demux/YUN3856.1.1_I1.fastq.gz  /home/guest/scratch/atacama_1pct/demux/YUN3856.1.1.forward.fastq.gz /home/guest/scratch/atacama_1pct/demux/YUN3856.1.1.reverse.fastq.gz
    ## YUN3856.1.2  9   /home/guest/scratch/atacama_1pct/demux/YUN3856.1.2_I1.fastq.gz  /home/guest/scratch/atacama_1pct/demux/YUN3856.1.2.forward.fastq.gz /home/guest/scratch/atacama_1pct/demux/YUN3856.1.2.reverse.fastq.gz
    ## YUN3856.2    6   /home/guest/scratch/atacama_1pct/demux/YUN3856.2_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/YUN3856.2.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/YUN3856.2.reverse.fastq.gz
    ## YUN3856.3    7   /home/guest/scratch/atacama_1pct/demux/YUN3856.3_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/YUN3856.3.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/YUN3856.3.reverse.fastq.gz
    ## YUN3856.1.3  2   /home/guest/scratch/atacama_1pct/demux/YUN3856.1.3_I1.fastq.gz  /home/guest/scratch/atacama_1pct/demux/YUN3856.1.3.forward.fastq.gz /home/guest/scratch/atacama_1pct/demux/YUN3856.1.3.reverse.fastq.gz
    ## unmatched    129884  /home/guest/scratch/atacama_1pct/demux/unmatched_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/unmatched.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/unmatched.reverse.fastq.gz
    ## total    135487

The Unmatched Problem
---------------------

### Reverse Complement the barcodes

``` r
read_tsv(map.file, comment= "#q2") %>% # read in map file, dropping the line that starts with "#q2"
  select(Sample = "#SampleID", 
         BarcodeSequence) %>%          # select only the columns with sample ID (renamed to get rid of "#") and the barcode itself
  deframe %>%                          # convert to a named vector (expected input for DNAStringSet constructor)
  DNAStringSet %>%                     # convert to DNAStringSet
  reverseComplement %>%                # reverse complement the barcodes
  as.data.frame %>%                    # convert to dataframe for write_delim
  rownames_to_column %>% 
  write_delim(rc.barcode.table,        # output barcodes to a file 
              delim="\t", 
              col_names=FALSE)
```

    ## Parsed with column specification:
    ## cols(
    ##   .default = col_double(),
    ##   `#SampleID` = col_character(),
    ##   BarcodeSequence = col_character(),
    ##   LinkerPrimerSequence = col_character(),
    ##   ExtractGroupNo = col_character(),
    ##   TransectName = col_character(),
    ##   SiteName = col_character(),
    ##   Vegetation = col_character(),
    ##   Description = col_character()
    ## )

    ## See spec(...) for full column specifications.

``` r
# clean up the output from the previous demultiplexing step
if (dir_exists(demux.dir)) {dir_delete(demux.dir)}
dir_create(demux.dir)
```

### Run Demux with RC barcodes

``` bash
set -u
fastq-multx -m 3 -d 2 -x -B $RC_BARCODE_TABLE \
  $BARCODE_FASTQ \
  $R1_FASTQ \
  $R2_FASTQ \
  -o $DEMUX_DIR/%_I1.fastq.gz \
  -o $DEMUX_DIR/%.forward.fastq.gz \
  -o $DEMUX_DIR/%.reverse.fastq.gz
```

    ## Using Barcode File: /home/guest/scratch/atacama_1pct/rc_barcodes_for_fastqmultx.tsv
    ## End used: start
    ## Skipped because of distance < 2 : 205
    ## Id   Count   File(s)
    ## BAQ1370.1.2  2   /home/guest/scratch/atacama_1pct/demux/BAQ1370.1.2_I1.fastq.gz  /home/guest/scratch/atacama_1pct/demux/BAQ1370.1.2.forward.fastq.gz /home/guest/scratch/atacama_1pct/demux/BAQ1370.1.2.reverse.fastq.gz
    ## BAQ1370.3    2   /home/guest/scratch/atacama_1pct/demux/BAQ1370.3_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/BAQ1370.3.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/BAQ1370.3.reverse.fastq.gz
    ## BAQ1370.1.3  10  /home/guest/scratch/atacama_1pct/demux/BAQ1370.1.3_I1.fastq.gz  /home/guest/scratch/atacama_1pct/demux/BAQ1370.1.3.forward.fastq.gz /home/guest/scratch/atacama_1pct/demux/BAQ1370.1.3.reverse.fastq.gz
    ## BAQ1552.1.1  5   /home/guest/scratch/atacama_1pct/demux/BAQ1552.1.1_I1.fastq.gz  /home/guest/scratch/atacama_1pct/demux/BAQ1552.1.1.forward.fastq.gz /home/guest/scratch/atacama_1pct/demux/BAQ1552.1.1.reverse.fastq.gz
    ## BAQ1552.2    7   /home/guest/scratch/atacama_1pct/demux/BAQ1552.2_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/BAQ1552.2.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/BAQ1552.2.reverse.fastq.gz
    ## BAQ2420.1.1  806 /home/guest/scratch/atacama_1pct/demux/BAQ2420.1.1_I1.fastq.gz  /home/guest/scratch/atacama_1pct/demux/BAQ2420.1.1.forward.fastq.gz /home/guest/scratch/atacama_1pct/demux/BAQ2420.1.1.reverse.fastq.gz
    ## BAQ2420.1.2  686 /home/guest/scratch/atacama_1pct/demux/BAQ2420.1.2_I1.fastq.gz  /home/guest/scratch/atacama_1pct/demux/BAQ2420.1.2.forward.fastq.gz /home/guest/scratch/atacama_1pct/demux/BAQ2420.1.2.reverse.fastq.gz
    ## BAQ2420.2    668 /home/guest/scratch/atacama_1pct/demux/BAQ2420.2_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/BAQ2420.2.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/BAQ2420.2.reverse.fastq.gz
    ## BAQ2420.3    723 /home/guest/scratch/atacama_1pct/demux/BAQ2420.3_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/BAQ2420.3.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/BAQ2420.3.reverse.fastq.gz
    ## BAQ2420.1.3  733 /home/guest/scratch/atacama_1pct/demux/BAQ2420.1.3_I1.fastq.gz  /home/guest/scratch/atacama_1pct/demux/BAQ2420.1.3.forward.fastq.gz /home/guest/scratch/atacama_1pct/demux/BAQ2420.1.3.reverse.fastq.gz
    ## BAQ2462.1    974 /home/guest/scratch/atacama_1pct/demux/BAQ2462.1_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/BAQ2462.1.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/BAQ2462.1.reverse.fastq.gz
    ## BAQ2462.2    647 /home/guest/scratch/atacama_1pct/demux/BAQ2462.2_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/BAQ2462.2.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/BAQ2462.2.reverse.fastq.gz
    ## BAQ2462.3    510 /home/guest/scratch/atacama_1pct/demux/BAQ2462.3_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/BAQ2462.3.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/BAQ2462.3.reverse.fastq.gz
    ## BAQ2687.1    967 /home/guest/scratch/atacama_1pct/demux/BAQ2687.1_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/BAQ2687.1.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/BAQ2687.1.reverse.fastq.gz
    ## BAQ2687.2    715 /home/guest/scratch/atacama_1pct/demux/BAQ2687.2_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/BAQ2687.2.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/BAQ2687.2.reverse.fastq.gz
    ## BAQ2687.3    941 /home/guest/scratch/atacama_1pct/demux/BAQ2687.3_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/BAQ2687.3.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/BAQ2687.3.reverse.fastq.gz
    ## BAQ2838.1    655 /home/guest/scratch/atacama_1pct/demux/BAQ2838.1_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/BAQ2838.1.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/BAQ2838.1.reverse.fastq.gz
    ## BAQ2838.2    549 /home/guest/scratch/atacama_1pct/demux/BAQ2838.2_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/BAQ2838.2.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/BAQ2838.2.reverse.fastq.gz
    ## BAQ2838.3    392 /home/guest/scratch/atacama_1pct/demux/BAQ2838.3_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/BAQ2838.3.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/BAQ2838.3.reverse.fastq.gz
    ## BAQ3473.1    1173    /home/guest/scratch/atacama_1pct/demux/BAQ3473.1_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/BAQ3473.1.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/BAQ3473.1.reverse.fastq.gz
    ## BAQ3473.2    979 /home/guest/scratch/atacama_1pct/demux/BAQ3473.2_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/BAQ3473.2.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/BAQ3473.2.reverse.fastq.gz
    ## BAQ3473.3    1372    /home/guest/scratch/atacama_1pct/demux/BAQ3473.3_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/BAQ3473.3.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/BAQ3473.3.reverse.fastq.gz
    ## BAQ4166.1.1  1130    /home/guest/scratch/atacama_1pct/demux/BAQ4166.1.1_I1.fastq.gz  /home/guest/scratch/atacama_1pct/demux/BAQ4166.1.1.forward.fastq.gz /home/guest/scratch/atacama_1pct/demux/BAQ4166.1.1.reverse.fastq.gz
    ## BAQ4166.1.2  1409    /home/guest/scratch/atacama_1pct/demux/BAQ4166.1.2_I1.fastq.gz  /home/guest/scratch/atacama_1pct/demux/BAQ4166.1.2.forward.fastq.gz /home/guest/scratch/atacama_1pct/demux/BAQ4166.1.2.reverse.fastq.gz
    ## BAQ4166.2    1373    /home/guest/scratch/atacama_1pct/demux/BAQ4166.2_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/BAQ4166.2.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/BAQ4166.2.reverse.fastq.gz
    ## BAQ4166.3    1330    /home/guest/scratch/atacama_1pct/demux/BAQ4166.3_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/BAQ4166.3.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/BAQ4166.3.reverse.fastq.gz
    ## BAQ4166.1.3  1121    /home/guest/scratch/atacama_1pct/demux/BAQ4166.1.3_I1.fastq.gz  /home/guest/scratch/atacama_1pct/demux/BAQ4166.1.3.forward.fastq.gz /home/guest/scratch/atacama_1pct/demux/BAQ4166.1.3.reverse.fastq.gz
    ## BAQ4697.1    917 /home/guest/scratch/atacama_1pct/demux/BAQ4697.1_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/BAQ4697.1.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/BAQ4697.1.reverse.fastq.gz
    ## BAQ4697.2    840 /home/guest/scratch/atacama_1pct/demux/BAQ4697.2_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/BAQ4697.2.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/BAQ4697.2.reverse.fastq.gz
    ## BAQ4697.3    1144    /home/guest/scratch/atacama_1pct/demux/BAQ4697.3_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/BAQ4697.3.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/BAQ4697.3.reverse.fastq.gz
    ## BAQ895.2 14  /home/guest/scratch/atacama_1pct/demux/BAQ895.2_I1.fastq.gz /home/guest/scratch/atacama_1pct/demux/BAQ895.2.forward.fastq.gz    /home/guest/scratch/atacama_1pct/demux/BAQ895.2.reverse.fastq.gz
    ## BAQ895.3 4   /home/guest/scratch/atacama_1pct/demux/BAQ895.3_I1.fastq.gz /home/guest/scratch/atacama_1pct/demux/BAQ895.3.forward.fastq.gz    /home/guest/scratch/atacama_1pct/demux/BAQ895.3.reverse.fastq.gz
    ## YUN1005.1.1  940 /home/guest/scratch/atacama_1pct/demux/YUN1005.1.1_I1.fastq.gz  /home/guest/scratch/atacama_1pct/demux/YUN1005.1.1.forward.fastq.gz /home/guest/scratch/atacama_1pct/demux/YUN1005.1.1.reverse.fastq.gz
    ## YUN1005.2    2   /home/guest/scratch/atacama_1pct/demux/YUN1005.2_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/YUN1005.2.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/YUN1005.2.reverse.fastq.gz
    ## YUN1005.3    454 /home/guest/scratch/atacama_1pct/demux/YUN1005.3_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/YUN1005.3.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/YUN1005.3.reverse.fastq.gz
    ## YUN1005.1.3  9   /home/guest/scratch/atacama_1pct/demux/YUN1005.1.3_I1.fastq.gz  /home/guest/scratch/atacama_1pct/demux/YUN1005.1.3.forward.fastq.gz /home/guest/scratch/atacama_1pct/demux/YUN1005.1.3.reverse.fastq.gz
    ## YUN1242.1    587 /home/guest/scratch/atacama_1pct/demux/YUN1242.1_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/YUN1242.1.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/YUN1242.1.reverse.fastq.gz
    ## YUN1242.2    9   /home/guest/scratch/atacama_1pct/demux/YUN1242.2_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/YUN1242.2.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/YUN1242.2.reverse.fastq.gz
    ## YUN1242.3    834 /home/guest/scratch/atacama_1pct/demux/YUN1242.3_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/YUN1242.3.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/YUN1242.3.reverse.fastq.gz
    ## YUN1609.1    777 /home/guest/scratch/atacama_1pct/demux/YUN1609.1_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/YUN1609.1.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/YUN1609.1.reverse.fastq.gz
    ## YUN1609.3    8   /home/guest/scratch/atacama_1pct/demux/YUN1609.3_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/YUN1609.3.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/YUN1609.3.reverse.fastq.gz
    ## YUN2029.1    14  /home/guest/scratch/atacama_1pct/demux/YUN2029.1_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/YUN2029.1.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/YUN2029.1.reverse.fastq.gz
    ## YUN2029.2    938 /home/guest/scratch/atacama_1pct/demux/YUN2029.2_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/YUN2029.2.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/YUN2029.2.reverse.fastq.gz
    ## YUN2029.3    4   /home/guest/scratch/atacama_1pct/demux/YUN2029.3_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/YUN2029.3.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/YUN2029.3.reverse.fastq.gz
    ## YUN3008.1.1  3   /home/guest/scratch/atacama_1pct/demux/YUN3008.1.1_I1.fastq.gz  /home/guest/scratch/atacama_1pct/demux/YUN3008.1.1.forward.fastq.gz /home/guest/scratch/atacama_1pct/demux/YUN3008.1.1.reverse.fastq.gz
    ## YUN3008.1.2  6   /home/guest/scratch/atacama_1pct/demux/YUN3008.1.2_I1.fastq.gz  /home/guest/scratch/atacama_1pct/demux/YUN3008.1.2.forward.fastq.gz /home/guest/scratch/atacama_1pct/demux/YUN3008.1.2.reverse.fastq.gz
    ## YUN3008.2    0   /home/guest/scratch/atacama_1pct/demux/YUN3008.2_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/YUN3008.2.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/YUN3008.2.reverse.fastq.gz
    ## YUN3008.3    5   /home/guest/scratch/atacama_1pct/demux/YUN3008.3_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/YUN3008.3.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/YUN3008.3.reverse.fastq.gz
    ## YUN3008.1.3  8   /home/guest/scratch/atacama_1pct/demux/YUN3008.1.3_I1.fastq.gz  /home/guest/scratch/atacama_1pct/demux/YUN3008.1.3.forward.fastq.gz /home/guest/scratch/atacama_1pct/demux/YUN3008.1.3.reverse.fastq.gz
    ## YUN3153.1    4   /home/guest/scratch/atacama_1pct/demux/YUN3153.1_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/YUN3153.1.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/YUN3153.1.reverse.fastq.gz
    ## YUN3153.2    481 /home/guest/scratch/atacama_1pct/demux/YUN3153.2_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/YUN3153.2.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/YUN3153.2.reverse.fastq.gz
    ## YUN3153.3    627 /home/guest/scratch/atacama_1pct/demux/YUN3153.3_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/YUN3153.3.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/YUN3153.3.reverse.fastq.gz
    ## YUN3184.1    1   /home/guest/scratch/atacama_1pct/demux/YUN3184.1_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/YUN3184.1.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/YUN3184.1.reverse.fastq.gz
    ## YUN3184.2    3   /home/guest/scratch/atacama_1pct/demux/YUN3184.2_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/YUN3184.2.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/YUN3184.2.reverse.fastq.gz
    ## YUN3259.1.1  66  /home/guest/scratch/atacama_1pct/demux/YUN3259.1.1_I1.fastq.gz  /home/guest/scratch/atacama_1pct/demux/YUN3259.1.1.forward.fastq.gz /home/guest/scratch/atacama_1pct/demux/YUN3259.1.1.reverse.fastq.gz
    ## YUN3259.1.2  748 /home/guest/scratch/atacama_1pct/demux/YUN3259.1.2_I1.fastq.gz  /home/guest/scratch/atacama_1pct/demux/YUN3259.1.2.forward.fastq.gz /home/guest/scratch/atacama_1pct/demux/YUN3259.1.2.reverse.fastq.gz
    ## YUN3259.2    1086    /home/guest/scratch/atacama_1pct/demux/YUN3259.2_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/YUN3259.2.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/YUN3259.2.reverse.fastq.gz
    ## YUN3259.3    1177    /home/guest/scratch/atacama_1pct/demux/YUN3259.3_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/YUN3259.3.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/YUN3259.3.reverse.fastq.gz
    ## YUN3259.1.3  306 /home/guest/scratch/atacama_1pct/demux/YUN3259.1.3_I1.fastq.gz  /home/guest/scratch/atacama_1pct/demux/YUN3259.1.3.forward.fastq.gz /home/guest/scratch/atacama_1pct/demux/YUN3259.1.3.reverse.fastq.gz
    ## YUN3346.1    723 /home/guest/scratch/atacama_1pct/demux/YUN3346.1_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/YUN3346.1.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/YUN3346.1.reverse.fastq.gz
    ## YUN3346.2    195 /home/guest/scratch/atacama_1pct/demux/YUN3346.2_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/YUN3346.2.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/YUN3346.2.reverse.fastq.gz
    ## YUN3346.3    843 /home/guest/scratch/atacama_1pct/demux/YUN3346.3_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/YUN3346.3.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/YUN3346.3.reverse.fastq.gz
    ## YUN3428.1    1131    /home/guest/scratch/atacama_1pct/demux/YUN3428.1_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/YUN3428.1.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/YUN3428.1.reverse.fastq.gz
    ## YUN3428.2    1471    /home/guest/scratch/atacama_1pct/demux/YUN3428.2_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/YUN3428.2.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/YUN3428.2.reverse.fastq.gz
    ## YUN3428.3    1129    /home/guest/scratch/atacama_1pct/demux/YUN3428.3_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/YUN3428.3.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/YUN3428.3.reverse.fastq.gz
    ## YUN3533.1.1  1025    /home/guest/scratch/atacama_1pct/demux/YUN3533.1.1_I1.fastq.gz  /home/guest/scratch/atacama_1pct/demux/YUN3533.1.1.forward.fastq.gz /home/guest/scratch/atacama_1pct/demux/YUN3533.1.1.reverse.fastq.gz
    ## YUN3533.1.2  1007    /home/guest/scratch/atacama_1pct/demux/YUN3533.1.2_I1.fastq.gz  /home/guest/scratch/atacama_1pct/demux/YUN3533.1.2.forward.fastq.gz /home/guest/scratch/atacama_1pct/demux/YUN3533.1.2.reverse.fastq.gz
    ## YUN3533.2    1256    /home/guest/scratch/atacama_1pct/demux/YUN3533.2_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/YUN3533.2.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/YUN3533.2.reverse.fastq.gz
    ## YUN3533.3    1350    /home/guest/scratch/atacama_1pct/demux/YUN3533.3_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/YUN3533.3.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/YUN3533.3.reverse.fastq.gz
    ## YUN3533.1.3  837 /home/guest/scratch/atacama_1pct/demux/YUN3533.1.3_I1.fastq.gz  /home/guest/scratch/atacama_1pct/demux/YUN3533.1.3.forward.fastq.gz /home/guest/scratch/atacama_1pct/demux/YUN3533.1.3.reverse.fastq.gz
    ## YUN3856.1.1  1028    /home/guest/scratch/atacama_1pct/demux/YUN3856.1.1_I1.fastq.gz  /home/guest/scratch/atacama_1pct/demux/YUN3856.1.1.forward.fastq.gz /home/guest/scratch/atacama_1pct/demux/YUN3856.1.1.reverse.fastq.gz
    ## YUN3856.1.2  1066    /home/guest/scratch/atacama_1pct/demux/YUN3856.1.2_I1.fastq.gz  /home/guest/scratch/atacama_1pct/demux/YUN3856.1.2.forward.fastq.gz /home/guest/scratch/atacama_1pct/demux/YUN3856.1.2.reverse.fastq.gz
    ## YUN3856.2    1071    /home/guest/scratch/atacama_1pct/demux/YUN3856.2_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/YUN3856.2.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/YUN3856.2.reverse.fastq.gz
    ## YUN3856.3    1320    /home/guest/scratch/atacama_1pct/demux/YUN3856.3_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/YUN3856.3.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/YUN3856.3.reverse.fastq.gz
    ## YUN3856.1.3  724 /home/guest/scratch/atacama_1pct/demux/YUN3856.1.3_I1.fastq.gz  /home/guest/scratch/atacama_1pct/demux/YUN3856.1.3.forward.fastq.gz /home/guest/scratch/atacama_1pct/demux/YUN3856.1.3.reverse.fastq.gz
    ## unmatched    87416   /home/guest/scratch/atacama_1pct/demux/unmatched_I1.fastq.gz    /home/guest/scratch/atacama_1pct/demux/unmatched.forward.fastq.gz   /home/guest/scratch/atacama_1pct/demux/unmatched.reverse.fastq.gz
    ## total    135487

Session Info
============

Always print `sessionInfo` for reproducibility!

``` r
sessionInfo()
```

    ## R version 3.6.2 (2019-12-12)
    ## Platform: x86_64-pc-linux-gnu (64-bit)
    ## Running under: Ubuntu 18.04.3 LTS
    ## 
    ## Matrix products: default
    ## BLAS:   /usr/lib/x86_64-linux-gnu/blas/libblas.so.3.7.1
    ## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.7.1
    ## 
    ## locale:
    ##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C              
    ##  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=en_US.UTF-8    
    ##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8   
    ##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C                 
    ##  [9] LC_ADDRESS=C               LC_TELEPHONE=C            
    ## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C       
    ## 
    ## attached base packages:
    ## [1] stats4    parallel  stats     graphics  grDevices utils     datasets 
    ## [8] methods   base     
    ## 
    ## other attached packages:
    ## [1] Biostrings_2.54.0   XVector_0.26.0      IRanges_2.20.2     
    ## [4] S4Vectors_0.24.3    BiocGenerics_0.32.0 tibble_2.1.3       
    ## [7] dplyr_0.8.3         fs_1.3.1            readr_1.3.1        
    ## 
    ## loaded via a namespace (and not attached):
    ##  [1] Rcpp_1.0.3       knitr_1.27       magrittr_1.5     zlibbioc_1.32.0 
    ##  [5] hms_0.5.3        tidyselect_0.2.5 R6_2.4.1         rlang_0.4.2     
    ##  [9] stringr_1.4.0    tools_3.6.2      xfun_0.12        htmltools_0.4.0 
    ## [13] yaml_2.2.0       digest_0.6.23    assertthat_0.2.1 crayon_1.3.4    
    ## [17] purrr_0.3.3      vctrs_0.2.1      zeallot_0.1.0    glue_1.3.1      
    ## [21] evaluate_0.14    rmarkdown_2.1    stringi_1.4.5    compiler_3.6.2  
    ## [25] pillar_1.4.3     backports_1.1.5  pkgconfig_2.0.3
