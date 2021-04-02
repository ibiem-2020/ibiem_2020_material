CyVerse
=======

CyVerse Discovery Environment
-----------------------------

-   NSF funded computing Environment
-   <a href="https://de.cyverse.org/de/" class="uri">https://de.cyverse.org/de/</a>

RStudio in CyVerse: Startup
---------------------------

1.  Go to
    <a href="https://de.cyverse.org/de/" class="uri">https://de.cyverse.org/de/</a>
2.  Click on **Apps**
3.  Search for “rstudio”
4.  Find **Rocker RStudio Verse 3.6.3**, click on the three dots and
    select **Quick Launch**
5.  In the dialog box that pops up, click on **Rocker RStudio Verse
    3.6.3** then the **triangle**
6.  In the “Analysis” dialog that pops up, click on **Launch Analysis**
7.  Click on the **Analyses** button in the top left corner
8.  In the Analyses window that pops up, click on the square with a
    diagonal arrow. This should open a new tab or window in your web
    browser with the RStudio session.

RStudio in CyVerse: Shutdown
----------------------------

1.  Click on the **File** menu *within RStudio* and select **Quit
    Session**
2.  Close the RStudio tab
3.  In Cyverse Discovery Environment go to the Analyses window
4.  Find “Rocker\_RStudio\_Verse\_3.6.3\_analysis1”, click on the three
    dots and select **Complete and Save Outputs**. Now status should
    change to **Completed**.
5.  Click on the three dots and select **Delete**

Notes
-----

-   IBIEM App for CyVerse Discovery Environment is a work in progress

IBIEM Environment in Singularity
================================

Singularity on a Server (demo)
------------------------------

1.  [Singularity](https://sylabs.io/docs/) must be installed!
2.  ssh to server
3.  Start tmux session: `tmux new -s ibiem`
4.  Start IBIEM image in singularity:
    `singularity exec docker://ibiem/docker_rstudio_ibiem2020 port_and_password`
5.  Copy the URL provided for “RStudio URL” and paste it in your
    webbrowser.
6.  Use the “RStudio Username:” and “RStudio Password:” for **Sign in to
    RStudio** in your webbrowser
7.  

Singularity on SLURM cluster
----------------------------

1.  [Singularity](https://sylabs.io/docs/) must be installed!
2.  ssh to cluster login node: “ssh
    <a href="mailto:USERNAME@LOGIN_HOSTNAME" class="email">USERNAME@LOGIN_HOSTNAME</a>”,
    for example: `ssh josh@dcc-login-03.oit.duke.edu`
3.  Start tmux session: `tmux new -s ibiem`
4.  Start IBIEM image in singularity:
    `srun singularity exec docker://ibiem/docker_rstudio_ibiem2020 port_and_password`

Make note of the information printed

    RStudio URL:            http://COMPUTE_HOSTNAME:PORT/

    RStudio Username:       USERNAME
    RStudio Password:       PASSWORD

Singularity on SLURM cluster
----------------------------

### Port forwarding

1.  On *local computer* ssh to login node
    `ssh -L PORT:COMPUTE_HOSTNAME:PORT USERNAME@LOGIN_HOSTNAME`
    -   for example, if the URL printed above was
        “<a href="http://dcc-core-313.rc.duke.edu:8780/" class="uri">http://dcc-core-313.rc.duke.edu:8780/</a>”,
        the ssh command would be

    <!-- -->

        ssh -L 8780:dcc-core-313.rc.duke.edu:8780 josh@dcc-login-03.oit.duke.edu

2.  Open
    “<a href="http://localhost:8780/" class="uri">http://localhost:8780/</a>”
    in your webbrowser
3.  To login to RStudio, use the USERNAME and PASSWORD that were printed
    when singularity started

Singularity on SLURM cluster: Shutdown
--------------------------------------

1.  Click on the **File** menu *within RStudio* and select **Quit
    Session**
2.  In the tmux session where singularity was started, do control-C
    **twice** so shutdown the IBIEM container

Singularity on SLURM cluster: Details
-------------------------------------

### Partition and Account

To run the container on a specific container and account, use the
`-A ACCOUNT -p PARTITION` for whatever partitions you have high-priority
access to, for example:
`srun -A chsi -p chsi singularity exec docker://ibiem/docker_rstudio_ibiem2020 port_and_password`

Singularity on SLURM cluster: Details
-------------------------------------

### Memory and CPUs

-   You might want to request more memory or more CPUs for your
    container. This is a balancing act.
    -   More CPUs allow you to run tasks faster if they support
        paralelel processing
    -   You need to request at least as much memory as you will need,
        otherwise SLURM will kill your container
    -   But, if you request more resources than are currently available
        you will have to wait for your container to start

`srun --mem=10G --cpus-per-task=5 singularity exec docker://ibiem/docker_rstudio_ibiem2020 port_and_password`
