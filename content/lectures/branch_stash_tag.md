Branching
=========

Branching
---------

“Branching means you diverge from the main line of development and
continue to do work without messing with that main line” - [Pro
Git](https://git-scm.com/book/en/v2/Git-Branching-Branches-in-a-Nutshell)

Branching, Take 2
-----------------

Git allows and encourages you to have multiple local branches that can
be entirely independent of each other.

-   **Frictionless Context Switching:** Create a branch to try out an
    idea, commit a few times, switch back to where you branched from,
    apply a patch, switch back to where you are experimenting, and merge
    it in.
-   **Feature Based Workflow:** Create new branches for each new feature
    you’re working on so you can seamlessly switch back and forth
    between them, then delete each branch when that feature gets merged
    into your main line.
-   **Disposable Experimentation:** Create a branch to experiment in,
    realize it’s not going to work, and just delete it - abandoning the
    work—with nobody else ever seeing it (even if you’ve pushed other
    branches in the meantime).

[git-scm.com](https://git-scm.com/about/branching-and-merging)

A Branching Example
-------------------

<script async src="//jsfiddle.net/jagstanley/uhcst0bd/embed/result/"></script>
Branches in the Wild
--------------------

-   In Rstudio: **History** Tab in Commit Window
-   In Github: [Project -&gt; Insights -&gt;
    Network](https://github.com/ibiem-2020/ibiem_2020_material/network)

Local vs Remote Branches
------------------------

“Notably, when you push to a remote repository, you do not have to push
all of your branches. You can choose to share just one of your branches,
a few of them, or all of them.”
[git-scm.com](https://git-scm.com/about/branching-and-merging)

Branching Hands-on
------------------

[Basic Branching and
Merging](https://git-scm.com/book/en/v2/Git-Branching-Basic-Branching-and-Merging)

Stashing
========

Stashing
--------

“Often, when you’ve been working on part of your project, things are in
a messy state and you want to switch branches for a bit to work on
something else. The problem is, you don’t want to do a commit of
half-done work just so you can get back to this point later. The answer
to this issue is the git stash command.” - [Pro
Git](https://git-scm.com/book/en/v2/Git-Tools-Stashing-and-Cleaning)

Stashing Hands-on
-----------------

[Stashing](https://git-scm.com/book/en/v2/Git-Tools-Stashing-and-Cleaning)

Tagging
=======

Tagging
-------

“Git has the ability to tag specific points in a repository’s history as
being important. Typically, people use this functionality to mark
release points (v1.0, v2.0 and so on).” - [Pro
Git](https://git-scm.com/book/en/v2/Git-Basics-Tagging)

Tags in the Wild
----------------

-   In Rstudio: **History** Tab in Commit Window
-   In Github: [Project -&gt; Code -&gt;
    tags](https://github.com/knights-lab/SHOGUN/tags)
-   In GitLab: [Project -&gt; Project Overview -&gt;
    Tags](https://gitlab.oit.duke.edu/ibiem2020/docker_rstudio_ibiem2020/-/tags)

Tagging Hands-on
----------------

[Tagging](https://git-scm.com/book/en/v2/Git-Basics-Tagging)
