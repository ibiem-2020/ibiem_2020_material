Team Conflicts
==============

1.  Form teams of 4 people, and choose numbers for each team member, 1
    through 4. Going forward only one member at a time touches their
    computer.
2.  Member 1:
    1.  Create a new repository on Github named “team\_conflict”. Check
        the box for “Add a README file”
    2.  Add your other team members as Collaborators.
    3.  Clone the “team\_conflict” repo from GitHub using the “New
        Project” command in RStudio.
    4.  Add the text “Will our team crack under conflict” to the
        `README.md` file and save it.
    5.  Stage and commit your changes to `README.md`
    6.  Push your changes.
3.  Member 2:
    1.  Clone the “team\_conflict” repo from GitHub using the “New
        Project” command in RStudio.
    2.  Open a new R Markdown file in the “team\_conflict” repo, this
        will be populated with the standard R Markdown template text.  
    3.  Save this R Markdown as `team_stats.Rmd`
    4.  Stage and commit your changes to `team_stats.Rmd`
    5.  Push changes to the remote repo.
4.  Member 3:
    1.  Clone the “team\_conflict” repo from GitHub using the “New
        Project” command in RStudio.
    2.  Add a new R code chuck to “team\_stats.Rmd” with this code:
        `plot(rnorm(10),rnorm(10))`
    3.  Save your changes to `team_stats.Rmd`, then stage and commit
        these changes.
    4.  Push changes to the remote repo
5.  Member 4:
    1.  Clone the “team\_conflict” repo from GitHub using the “New
        Project” command in RStudio.
    2.  Add a new R code chuck to `team_stats.Rmd` with this code:
        `plot(1:10,10:1)`
    3.  Save your changes to `team_stats.Rmd`, then stage and commit
        these changes.
    4.  Push changes to the remote repo
6.  Each team member should now pull the repo before continuing with the
    next steps
7.  Member 1:
    1.  Change the Title in `team_stats.Rmd` to something more
        interesting, for example come up with a team name.
    2.  Save your changes to `team_stats.Rmd`, then stage and commit
        these changes.
8.  Member 2:
    1.  Change the Title again
    2.  Save, commit, push.
    3.  You should get an error. Read the error!
    4.  Pull.
    5.  Locate the merge conflict in the R Markdown file (it should be
        on top, but you can also search for the word HEAD)
    6.  Resolve the merge conflict by choosing the correct/preferred
        change.
    7.  Commit with a message “Resolving merge conflict”, and push.
9.  Member 3:
    1.  Add a comment to the first code chunk.
    2.  Save, commit, push.
    3.  You should get an error.
    4.  Pull.
    5.  No merge conflicts should occur.
    6.  Now push.
10. Member 4:
    1.  Change the comment in the first code chunk.
    2.  Save, commit, push.
    3.  You should get an error. Read the error!
    4.  Pull.
    5.  Locate the merge conflict in the R Markdown file.
    6.  Resolve the merge conflict by choosing the correct/preferred
        label.
    7.  Commit with a message “Resolving merge conflict”, and push.

References
==========

The bulk of this set of lessons is a translation from Unix command line
to RStudio GUI of the The Software Carpentry module [Version Control
with Git](http://swcarpentry.github.io/git-novice/), specifically:

-   [Create a Project with Version
    Control](#create-a-project-with-version-control) is based on
    [Version Control with Git: 3. Creating a
    Repository](http://swcarpentry.github.io/git-novice/03-create/)
-   [Tracking Changes](#tracking-changes) is based on: [Version Control
    with Git: 4. Tracking
    Changes](http://swcarpentry.github.io/git-novice/04-changes/)
-   [Reverting Changes](#reverting-changes) is loosely based on:
    [Version Control with Git: 5. Exploring
    History](http://swcarpentry.github.io/git-novice/05-history/)
-   [Ignoring Things](#ignoring-things) is based on [Version Control
    with Git: 6. Ignoring
    Things](http://swcarpentry.github.io/git-novice/06-ignore/)
-   [Remotes in GitHub](#remotes-in-github) is based on [Version Control
    with Git: 7. Remotes in
    GitHub](http://swcarpentry.github.io/git-novice/07-github/)
-   [Collaborating](#collaborating) is based on [Version Control with
    Git: 8.
    Collaborating](http://swcarpentry.github.io/git-novice/08-collab/)
    and [Version Control with Git and
    SVN](https://support.rstudio.com/hc/en-us/articles/200532077-Version-Control-with-Git-and-SVN)
-   [Conflicts](#conflicts) is based on [Version Control with Git: 8.
    Conflicts](http://swcarpentry.github.io/git-novice/09-conflict/)

[Collaborating](#collaborating) is also based on [Version Control with
Git and
SVN](https://support.rstudio.com/hc/en-us/articles/200532077-Version-Control-with-Git-and-SVN).

The [Team Conflicts](#team-conflicts) section is based on [We’ll git
there, slowly but
surely](https://github.com/mine-cetinkaya-rundel/github-class-sigcse-2018).
