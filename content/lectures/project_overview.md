Projects
========

Project Groups
--------------

-   **Project 1 - Microbiome adaptation to plastics**
    -   Brianna, Derrick, Amani, Katherine M.
-   **Project 2 - Personal microbiomes and chemical exposome**
    -   Katherine D., Elissa, Yingzhu, Pat
-   **Project 3 - The mycobiome of the pig lung**
    -   Naveen, Beverly, Zeni
-   **Project 4 – 16S amplicon vs shallow shotgun sequencing**
    -   Vidya, Eva, Mizpha, Justice
-   **Project 5 – Biofouling of solar panels**
    -   Sam, Sarah, Aaron, Jessica

Project Organization
====================

Class, Group, and Individual
----------------------------

> -   Class: `/data`
> -   Group: `/sharedspace/OurProject`
> -   Individual: `/home/guest`

Name that Location
------------------

-   Code?
-   Taxonomic Reference (e.g. Silva)?
-   Raw Data (e.g. FASTQs)?
-   Intermediate Files (e.g. Filtered FASTQs)?
-   Final Results (e.g. RDS of phyloseq object)?
-   Metadata?

Code
----

-   Git Repo in Home directory
-   Remote repository on Github
    -   All project members are collaborators

Taxonomic Reference (e.g. Silva)?
---------------------------------

-   Class: everyone needs these
-   `/data/references`

Raw Data (e.g. FASTQs)?
-----------------------

-   Working Copy
    -   Group Directory
    -   Read Only
-   Archive
    -   New Data: Duke Data Service
    -   Published Data: SRA

Intermediate Files (e.g. Filtered FASTQs)?
------------------------------------------

-   Individual
-   `/home/guest/scratch/atacama_1pct`

Final Results (e.g. RDS of phyloseq object)?
--------------------------------------------

-   Individual: `/home/guest/scratch/atacama_1pct`
-   Group: `/sharedspace/platypus_poop`

Metadata?
---------

-   Data: `/data/projects/platypus_poop`
-   Group: `/sharedspace/platypus_poop`

Managing Space
==============

Space: Availabile
-----------------

``` bash
df -h
```

    ## Filesystem      Size  Used Avail Use% Mounted on
    ## none            197G   44G  144G  24% /
    ## tmpfs            64M     0   64M   0% /dev
    ## tmpfs            28G     0   28G   0% /sys/fs/cgroup
    ## shm              64M     0   64M   0% /dev/shm
    ## /dev/sde1      1008G  461G  496G  49% /home/guest
    ## /dev/sdd1        50G   42G  5.4G  89% /tmp
    ## /dev/sdc        197G   44G  144G  24% /etc/hosts
    ## tmpfs            28G     0   28G   0% /proc/acpi
    ## tmpfs            28G     0   28G   0% /proc/scsi
    ## tmpfs            28G     0   28G   0% /sys/firmware

Space: Usage
------------

``` bash
du -h --max-depth 1 /home/guest
```

    ## 28K  /home/guest/.config
    ## 562M /home/guest/repos
    ## 28K  /home/guest/.ssh
    ## 24M  /home/guest/.rstudio
    ## 12K  /home/guest/R
    ## 4.6G /home/guest/scratch
    ## 256K /home/guest/.texlive2017
    ## 140K /home/guest/.cache
    ## 5.1G /home/guest

Space: Usage (continued)
------------------------

``` bash
du --max-depth 1 /home/guest | sort -nr
```

    ## 5319828  /home/guest
    ## 4719944  /home/guest/scratch
    ## 575456   /home/guest/repos
    ## 23928    /home/guest/.rstudio
    ## 256  /home/guest/.texlive2017
    ## 140  /home/guest/.cache
    ## 28   /home/guest/.ssh
    ## 28   /home/guest/.config
    ## 12   /home/guest/R

Project Timeline
================

Milestones
----------

-   February 19: Group Presentations on Project Background
-   March 12: Group Presentations on Project Progress
-   April 9: Poster/Figure Critique
-   April 23: Final Presentations

Collaboration
=============

Collaborating with Git
----------------------

-   [Collaborating with
    Git](https://github.com/ibiem-2020/ibiem_2020_material/blob/master/content/lessons/bootcamp/040_git_overview.md#collaborating)

Git for Teams
-------------

-   [Team
    Conflicts](https://github.com/ibiem-2020/ibiem_2020_material/blob/master/content/lessons/bootcamp/040_git_overview.md#team-conflicts)
-   [Branching](https://git-scm.com/book/en/v2/Git-Branching-Basic-Branching-and-Merging)
-   [Stashing](https://git-scm.com/book/en/v2/Git-Tools-Stashing-and-Cleaning)
-   [Tagging](https://git-scm.com/book/en/v2/Git-Basics-Tagging)
