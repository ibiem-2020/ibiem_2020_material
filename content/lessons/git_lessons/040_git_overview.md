-   [Why Version Control](#why-version-control)
    -   [Why Git](#why-git)
-   [Using Git in RStudio](#using-git-in-rstudio)
    -   [Basic Setup in RStudio](#basic-setup-in-rstudio)
    -   [Intro to Git in RStudio](#intro-to-git-in-rstudio)
        -   [Create a Project with Version
            Control](#create-a-project-with-version-control)
        -   [Tracking Changes](#tracking-changes)
        -   [Reverting Changes](#reverting-changes)
        -   [Ignoring Things](#ignoring-things)
-   [Remote Git Repository](#remote-git-repository)
    -   [Why a Remote Repository](#why-a-remote-repository)
    -   [Setup SSH Key](#setup-ssh-key)
        -   [Create Key in RStudio](#create-key-in-rstudio)
    -   [Remotes in GitHub](#remotes-in-github)
    -   [Collaborating](#collaborating)
        -   [Cloning someone else’s repo](#cloning-someone-elses-repo)
        -   [Modifying someone else’s
            repo](#modifying-someone-elses-repo)
-   [References](#references)

Why Version Control
===================

-   [R and version control for the solo data
    analyst](https://stackoverflow.com/questions/2712421/r-and-version-control-for-the-solo-data-analyst)

Why Git
-------

-   Popular
-   Powerful
-   Distributed
-   Free
-   Open Source

Using Git in RStudio
====================

RStudio provides a nice GUI for using git, which can reduce the learning
curve for git.

Basic Setup in RStudio
----------------------

1.  Go to Global Options (from the Tools menu)
2.  Click Git/SVN
3.  Click Enable version control interface for RStudio projects

Intro to Git in RStudio
-----------------------

### Create a Project with Version Control

1.  Select the “New Project” command from the Project menu
2.  Select the “New Directory” option in the “Create Project” dialog box
3.  Select “Empty Project” for “Project Type”
4.  In the “Create New Project” dialog do the following:
    -   Directory name: “planets”
    -   Create project as subdirectory of: “\~”
    -   Be sure there is a check in the box for “Create a git
        repository”
    -   Click “Create Project”
5.  Switch to the “Git” tab in the upper right pane.
6.  Check the “Staged” boxes next to .gitignore and planets.Rproj, then
    click “Commit”
7.  In the **Commit message** box, type “First commit!”
8.  Oops, we have gotten our first git message - it wants to know your
    name and email because this is incorporated in the commit history!
9.  Copy the following text from the error message and paste it into a
    new text file:

<!-- -->

    git config --global user.email "you@example.com"
    git config --global user.name "Your Name"

1.  Replace
    “<a href="mailto:you@example.com" class="email">you@example.com</a>”
    and “Your Name” with your information, then copy the revised text.
2.  Open the RStudio Terminal (under the **Tools** menu)
3.  Paste the revised text at the command prompt, then hit the
    **return** key on your keyboard
4.  You can confirm that you successful configured your name and email
    with this command: `git config --list`
5.  Now go back to the **Review Changes** dialog and close the **Git
    Commit** message.
6.  Click **Commit** again, then close the **Git Commit** and **Review
    Changes** dialog boxes.

### Tracking Changes

#### Adding a New File

1.  Make a new text file in the **planets** project.
2.  Add some text: “Cold and dry, but everything is my favorite color”
3.  Save as `mars.txt`.
4.  Notice that `mars.txt` is now in the Git pane. The two question
    marks under **Status** mean that git doesn’t know anything about
    this file (and is not responsible for it)
5.  Click the checkbox under **Staged** to add the file to the repo,
    notice that **Status** changes to “A” (for “added”).
6.  Now click **Commit** to open the **Review Changes** dialog, put in
    the commit message “Start notes on Mars as a base”, commit the file,
    and close the dialog boxes.
7.  To see our project history, click on the clock icon in the Git pane.

#### Making changes

1.  Add a second line to `mars.txt`: “The two moons may be a problem for
    Wolfman” and save.
2.  Notice that `mars.txt` pops up again in the **Git** pane with an
    **M** for “modified”.
3.  Click on the **Diff** button to open the **Review Changes** dialog.
    It shows us the line we added highlighted in green, and shows us the
    unchanged previous line in gray.
4.  To commit these changes to git, add the commit message “Add concerns
    about effects of Mars’ moons on Wolfman”, click **Commit**. Notice
    the error message from git:

<!-- -->

    Changes not staged for commit:
        modified:   mars.txt

    no changes added to commit

Git messages are usually very informative! Git is telling us that we
can’t commit because we didn’t *add* anything to the commit! We forgot
to click the **Staged** button.

So, now click on the **Staged** checkbox, be sure our commit message is
still there, click **Commit**, check the message from git, then close
the dialogs.

#### Staging

Git insists that we add files to the set we want to commit before
actually committing anything. This allows us to commit our changes in
stages and capture changes in logical portions rather than only large
batches. For example, suppose we’re adding a few citations to our
supervisor’s work to our thesis. We might want to commit those
additions, and the corresponding addition to the bibliography, but not
commit the work we’re doing on the conclusion (which we haven’t finished
yet).

To allow for this, Git has a special staging area where it keeps track
of things that have been added to the current changeset but not yet
committed.

> ##### Staging Area
>
> If you think of Git as taking snapshots of changes over the life of a
> project, git add specifies what will go in a snapshot (putting things
> in the staging area), and git commit then actually takes the snapshot,
> and makes a permanent record of it (as a commit). If you don’t have
> anything staged when you type git commit, Git will prompt you to use
> git commit -a or git commit –all, which is kind of like gathering
> everyone for the picture! However, it’s almost always better to
> explicitly add things to the staging area, because you might commit
> changes you forgot you made. (Going back to snapshots, you might get
> the extra with incomplete makeup walking on the stage for the snapshot
> because you used -a!) Try to stage things manually, or you might find
> yourself searching for “git undo commit” more than you would like!

Let’s examine this process more carefully . . .

1.  Add a third line to `mars.txt`: “But the Mummy will appreciate the
    lack of humidity” and save.
2.  Open the **Review Changes** dialog.
3.  Notice that the **Show: Unstaged** button is checked. We can toggle
    between viewing staged changes and unstaged changes by clicking on
    the buttons next to **Show: Staged** and **Show: Unstaged**. Right
    now no changes are staged.
4.  Click on the **Staged** button next to `mars.txt` to stage the
    changes. Notice that **Show: Staged** is automatically selected, but
    we can flip back to **Show: Unstaged** to see that there are no
    longer any unstaged changes.
5.  Add the commit message “Discuss concerns about Mars’ climate for
    Mummy”, click **Commit**, check the message from git, then close the
    dialogs.
6.  Now we can check the history and see the changes made at each commit
    and the commit message.

#### Challenge: Choosing a Commit Message

Which of the following commit messages would be most appropriate for the
last commit made to mars.txt?

1.  “Changes”
2.  “Added line ‘But the Mummy will appreciate the lack of humidity’ to
    mars.txt”
3.  “Discuss effects of Mars’ climate on the Mummy”

### Reverting Changes

“If I could turn back time . . .” – Cher

One of the key benefits of using version control is the ability to do
something not usually possible in life - going back in time. Lot’s of
software has **Undo**, but when version control is used well, it is like
an infinite super-duper undo with a safety net.

#### Basic Reversion

1.  Add a forth line to `mars.txt`: “An ill-considered change” and save.
2.  Open the **Review Changes** dialog.
3.  If we want to get rid of this change, we can click the **Revert**
    button, then click **Yes** . . . voila!

#### Revert Some Changes, but not All

1.  Add a these two lines `mars.txt`:

<!-- -->

    No wind
    A little bit dusty

1.  Open the **Review Changes** dialog.
2.  Oops, it turns out that there **is** wind on mars, so we need to
    revert line 4, but commit line 5!
3.  Click on “No wind” to select it, then click **Discard line**.
4.  Now click on **Stage All** to add the remaining line, add a commit
    message and commit

#### Going Further Back

Git is super powerful! It will let you do all sorts of things. For
example, you can revert some or all files back to any previous commit .
. . but you cannot access all of git’s features with the RStudio
interface. To do fancier things you have to use the command line
interface. Within RStudio you can do this using the **Terminal** under
the **Tools** menu. The Software Carpentry module [Version Control with
Git](http://swcarpentry.github.io/git-novice/) covers this, and google
will help you figure out how to do just about anything with git.

### Ignoring Things

What if we have files that we do not want Git to track for us, like
backup files created by our editor or intermediate files created during
data analysis. Let’s create a few dummy files! Make new text files with
the following names (you can leave them empty):

    a.dat
    b.dat
    c.dat
    results/a.out
    results/b.out

Putting these files under version control would be a waste of disk
space. What’s worse, having them all listed could distract us from
changes that actually matter, so let’s tell Git to ignore them.

RStudio makes this pretty easy to do:

1.  Click on the `a.dat` file in the git pane to select it.
2.  Click on the gear in the git pane (it might say “More” next to it),
    and select **Ignore**. This will open a **Git ignore** dialog box
    with a list of files that git is ignoring, with `a.dat` added to the
    list (the others were automatically added by RStudio when we made
    this project).
3.  Click on **save** to accept the addition of `a.dat` to the
    list. &gt; Notice that `a.dat` has now disappeared from the git
    pane, but `.gitignore` has just appeared as modified. `.gitignore`
    is the file where we specify what git should ignore - that **Git
    ignore** dialog box was actually a mini text editor, and by adding
    `a.dat` we changed the file (you may remember that the first thing
    we did after creating the **planets** project was to commit
    `.gitignore` to the repo).

4.  What about the other `.dat` files? Select `b.dat` in the git pane
    then open the **Git ignore** dialog. Now replace “a.dat” and “b.dat”
    with “*.dat", this will tell git to ignore *any\* file that ends
    in”.dat"
5.  Let’s also add `results` directory, but it is a good idea to add it
    as “results/”, the forward slash at the end means that we are
    specifically refering to a directory (and its contents)
6.  Now lets stage and commit our changes to `.gitignore` &gt; Sometimes
    you will want to include `.gitignore` in the repo, and sometimes you
    won’t. In cases where you don’t want to include it in the repo, you
    will want to add “.gitignore” to the list of files to ignore in
    `.gitignore`, which is very meta!

Now let’s work through the challenges at the end of [Version Control
with Git: 6. Ignoring
Things](https://swcarpentry.github.io/git-novice/06-ignore/index.html)

Remote Git Repository
=====================

Why a Remote Repository
-----------------------

-   Collaborate
-   Remote backup
-   Share/Publish

Setup SSH Key
-------------

### Create Key in RStudio

1.  Go to Global Options (from the Tools menu)
2.  Click Git/SVN
3.  Click **Create RSA Key**
4.  Enter a passphrase (Optional)
5.  Click **Create**
6.  Click **View public key**
7.  Select and copy all the text in the box
8.  Follow these instructions to [Add an SSH key to your GitHub
    account](https://help.github.com/articles/adding-a-new-ssh-key-to-your-github-account/),
    starting with step \#2.

Remotes in GitHub
-----------------

1.  Follow [Version Control with Git: 7. Remotes in
    GitHub](http://swcarpentry.github.io/git-novice/07-github/) through
    where it says “The next step is to connect the two repositories. We
    do this by making the GitHub repository a remote for the local
    repository. The home page of the repository on GitHub includes the
    string we need to identify it:”
2.  In Github, under “Quick setup — if you’ve done this kind of thing
    before”, click on “SSH”
3.  Below that, copy the text in the section **. . . or push an existing
    repository from the command line** by clicking on the “copy to
    clipboard” button on the right side.
4.  In RStudio, open the Terminal (in the **Tools** menu)
5.  Paste the command you copied from Github. It should look like this
    (except your github username should be there instead of
    “GITHUB\_USER\_NAME”):

<!-- -->

    git remote add origin git@github.com:GITHUB_USER_NAME/planets.git
    git push -u origin master

If you entered a passphrase when you generated your SSH key, you will be
prompted to enter it. &gt; The “git remote . . .” command associates
your local repo with the repo you just made on Github. The “git push . .
.” command pushes everything from your local repo to the Github repo.
Now the Github repo should be a perfect copy of your local repo.

1.  Let’s check that these two commands worked . . . go to your Github
    account in your webbrower and click on “planets” near the top. You
    should see the three files that we commited to our local repo:
    `.gitignore`, `mars.txt`, and `planets.Rproj`
2.  Let’s add another line to `mars.txt` in RStudio: “Rhymes with cars”.
    Then stage and commit it.
3.  Notice that near the top of the **Review Changes** dialog it now
    says “Your branch is ahead of ‘origin/master’ by 1 commit.”. This is
    because we have commited local changes, but haven’t updated our
    remote repo (on Github). Let’s sync the remote repo by clicking the
    **Push** button. Check on Github for the changes!

Do the following challenges from the bottom of [Version Control with
Git: 7. Remotes in
GitHub](http://swcarpentry.github.io/git-novice/07-github/):

-   GitHub GUI
-   Push vs. Commit

Collaborating
-------------

### Cloning someone else’s repo

For the next step, get into pairs. One person will be the “Owner” and
the other will be the “Collaborator”. The goal is that the Collaborator
add changes into the Owner’s repository. We will switch roles at the
end, so both persons will play Owner and Collaborator.

#### Github Setup

1.  The Owner needs to give the Collaborator access. The owner needs to
    find their repository on GitHub, click the settings button on the
    right, then select Collaborators, and enter your partner’s username.
    ![Github Collaborator
    Settings](http://swcarpentry.github.io/git-novice/fig/github-add-collaborators.png)
2.  To accept access to the Owner’s repo, the Collaborator needs to go
    to
    <a href="https://github.com/notifications" class="uri">https://github.com/notifications</a>.
    Once there she can accept access to the Owner’s repo. If nothing
    shows up there, the collaborator should check their email to see if
    they received an email notification.

#### Cloning the Repository

Next, the Collaborator needs to download a copy of the Owner’s
repository to her machine. This is called “cloning a repo”. The
Collaborator will clone the repo in RStudio by starting a new project.

1.  To get the URL for the Owner’s repository, the Collaborator should
    go to the Owner’s repository on Github and click the green *Clone or
    download* button. In the dialog box that pops up, be sure it says
    “Clone with SSH”, then copy the Repository URL (it should be
    `git@github.com:OWNER_GITHUB_USERNAME/planet.git`, but with the
    Owner’s Github username instead of “OWNER\_GITHUB\_USERNAME”)
2.  In RStudio select the New Project command from the Project menu.
3.  Choose to create a new project from Version Control
4.  Choose Git
5.  Fill in the *Repository URL*: that you just copied from Github
6.  For *Project directory name* put `planet_shared`
7.  Leave *Create project as subdirectory of* as “\~”
8.  Click Create Project.

### Modifying someone else’s repo

Now the Collaborator (i.e. not the owner) can now make a change in the
clone of the Owner’s repository, exactly the same way as we’ve been
doing before . . .

1.  Make a new text file and put in the text “It is so a planet!” and
    save as `pluto.txt`
2.  Stage `pluto.txt`, and commit it with the message “Add notes about
    Pluto”
3.  Push the change to the Owner’s repository on GitHub by clicking the
    **Push** button &gt; Note that we didn’t have to create a remote
    called origin: Git uses this name by default when we clone a
    repository. (This is why origin was a sensible choice earlier when
    we were setting up remotes by hand.)

4.  Take a look to the Owner’s repository on its GitHub website now
    (maybe you need to refresh your browser.) You should be able to see
    the new commit made by the Collaborator.
5.  To download the Collaborator’s changes from GitHub, the Owner should
    clicking the **Pull** button in their own RStudio. Now the three
    repositories (Owner’s local, Collaborator’s local, and Owner’s on
    GitHub) are back in sync.
6.  Switch roles, whoever was Owner first time around should repeat this
    as Collaborator, and vice versa.

#### &gt; A Basic Collaborative Workflow

> In practice, it is good to be sure that you have an updated version of
> the repository you are collaborating on, so you should git pull before
> making our changes. The basic collaborative workflow would be:
>
> 1.  update your local repo with git pull origin master
> 2.  make your changes and stage them
> 3.  commit your changes
> 4.  upload the changes to GitHub with git push

> It is better to make many commits with smaller changes rather than of
> one commit with massive changes: small commits are easier to read and
> review.

#### Challenges

##### Review Changes

The Owner push commits to the repository without giving any information
to the Collaborator. How can the Collaborator find out what has changed
with Rstudio? And on GitHub?

##### Comment Changes in GitHub

The Collaborator has some questions about one line change made by the
Owner and has some suggestions to propose.

With GitHub, it is possible to comment the diff of a commit. Over the
line of code to comment, a blue comment icon appears to open a comment
window.

The Collaborator posts its comments and suggestions using GitHub
interface.

##### Version History, Backup, and Version Control

Some backup software can keep a history of the versions of your files.
They also allows you to recover specific versions. How is this
functionality different from version control? What are some of the
benifits of using version control, Git and GitHub?

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
