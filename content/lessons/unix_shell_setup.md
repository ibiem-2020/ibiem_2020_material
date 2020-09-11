Run the following in a *bash* chunk or the RStudio terminal to download
the files we need for the Unix Shell lessons

``` bash
cd ~
wget --no-clobber http://swcarpentry.github.io/shell-novice/data/data-shell.zip
unzip -o data-shell.zip
```

    ## --2020-09-11 02:45:51--  http://swcarpentry.github.io/shell-novice/data/data-shell.zip
    ## Resolving swcarpentry.github.io (swcarpentry.github.io)... 185.199.108.153, 185.199.109.153, 185.199.110.153, ...
    ## Connecting to swcarpentry.github.io (swcarpentry.github.io)|185.199.108.153|:80... connected.
    ## HTTP request sent, awaiting response... 200 OK
    ## Length: 580102 (567K) [application/zip]
    ## Saving to: ‘data-shell.zip’
    ## 
    ##      0K .......... .......... .......... .......... ..........  8% 29.7M 0s
    ##     50K .......... .......... .......... .......... .......... 17% 46.4M 0s
    ##    100K .......... .......... .......... .......... .......... 26% 34.7M 0s
    ##    150K .......... .......... .......... .......... .......... 35% 38.5M 0s
    ##    200K .......... .......... .......... .......... .......... 44% 37.0M 0s
    ##    250K .......... .......... .......... .......... .......... 52% 33.7M 0s
    ##    300K .......... .......... .......... .......... .......... 61% 67.1M 0s
    ##    350K .......... .......... .......... .......... .......... 70% 56.6M 0s
    ##    400K .......... .......... .......... .......... .......... 79% 57.0M 0s
    ##    450K .......... .......... .......... .......... .......... 88% 54.0M 0s
    ##    500K .......... .......... .......... .......... .......... 97% 62.4M 0s
    ##    550K .......... ......                                     100%  226M=0.01s
    ## 
    ## 2020-09-11 02:45:51 (44.8 MB/s) - ‘data-shell.zip’ saved [580102/580102]
    ## 
    ## Archive:  data-shell.zip
    ##    creating: data-shell/
    ##   inflating: data-shell/pizza.cfg    
    ##   inflating: data-shell/.bash_profile  
    ##    creating: data-shell/molecules/
    ##   inflating: data-shell/molecules/ethane.pdb  
    ##   inflating: data-shell/molecules/cubane.pdb  
    ##   inflating: data-shell/molecules/propane.pdb  
    ##   inflating: data-shell/molecules/pentane.pdb  
    ##   inflating: data-shell/molecules/methane.pdb  
    ##   inflating: data-shell/molecules/octane.pdb  
    ##    creating: data-shell/north-pacific-gyre/
    ##    creating: data-shell/north-pacific-gyre/2012-07-03/
    ##   inflating: data-shell/north-pacific-gyre/2012-07-03/NENE01736A.txt  
    ##   inflating: data-shell/north-pacific-gyre/2012-07-03/NENE02040A.txt  
    ##   inflating: data-shell/north-pacific-gyre/2012-07-03/NENE01751B.txt  
    ##   inflating: data-shell/north-pacific-gyre/2012-07-03/NENE02040B.txt  
    ##   inflating: data-shell/north-pacific-gyre/2012-07-03/NENE01843B.txt  
    ##   inflating: data-shell/north-pacific-gyre/2012-07-03/NENE01978B.txt  
    ##   inflating: data-shell/north-pacific-gyre/2012-07-03/NENE02040Z.txt  
    ##   inflating: data-shell/north-pacific-gyre/2012-07-03/NENE01729B.txt  
    ##   inflating: data-shell/north-pacific-gyre/2012-07-03/NENE01729A.txt  
    ##   inflating: data-shell/north-pacific-gyre/2012-07-03/NENE01812A.txt  
    ##   inflating: data-shell/north-pacific-gyre/2012-07-03/goostats  
    ##   inflating: data-shell/north-pacific-gyre/2012-07-03/NENE01978A.txt  
    ##   inflating: data-shell/north-pacific-gyre/2012-07-03/NENE01751A.txt  
    ##   inflating: data-shell/north-pacific-gyre/2012-07-03/goodiff  
    ##   inflating: data-shell/north-pacific-gyre/2012-07-03/NENE02043B.txt  
    ##   inflating: data-shell/north-pacific-gyre/2012-07-03/NENE02043A.txt  
    ##   inflating: data-shell/north-pacific-gyre/2012-07-03/NENE02018B.txt  
    ##   inflating: data-shell/north-pacific-gyre/2012-07-03/NENE01971Z.txt  
    ##   inflating: data-shell/north-pacific-gyre/2012-07-03/NENE01843A.txt  
    ##   inflating: data-shell/notes.txt    
    ##    creating: data-shell/data/
    ##   inflating: data-shell/data/salmon.txt  
    ##   inflating: data-shell/data/amino-acids.txt  
    ##   inflating: data-shell/data/sunspot.txt  
    ##   inflating: data-shell/data/animals.txt  
    ##    creating: data-shell/data/pdb/
    ##   inflating: data-shell/data/pdb/nerol.pdb  
    ##   inflating: data-shell/data/pdb/methanol.pdb  
    ##   inflating: data-shell/data/pdb/ethane.pdb  
    ##   inflating: data-shell/data/pdb/strychnine.pdb  
    ##   inflating: data-shell/data/pdb/cubane.pdb  
    ##   inflating: data-shell/data/pdb/benzaldehyde.pdb  
    ##   inflating: data-shell/data/pdb/camphene.pdb  
    ##   inflating: data-shell/data/pdb/propane.pdb  
    ##   inflating: data-shell/data/pdb/heme.pdb  
    ##   inflating: data-shell/data/pdb/cyclobutane.pdb  
    ##   inflating: data-shell/data/pdb/lactic-acid.pdb  
    ##   inflating: data-shell/data/pdb/mustard.pdb  
    ##   inflating: data-shell/data/pdb/tyrian-purple.pdb  
    ##   inflating: data-shell/data/pdb/testosterone.pdb  
    ##   inflating: data-shell/data/pdb/pentane.pdb  
    ##   inflating: data-shell/data/pdb/lsd.pdb  
    ##   inflating: data-shell/data/pdb/maltose.pdb  
    ##   inflating: data-shell/data/pdb/lactose.pdb  
    ##   inflating: data-shell/data/pdb/lanoxin.pdb  
    ##   inflating: data-shell/data/pdb/pyridoxal.pdb  
    ##   inflating: data-shell/data/pdb/piperine.pdb  
    ##   inflating: data-shell/data/pdb/thiamine.pdb  
    ##   inflating: data-shell/data/pdb/styrene.pdb  
    ##   inflating: data-shell/data/pdb/menthol.pdb  
    ##   inflating: data-shell/data/pdb/glycol.pdb  
    ##   inflating: data-shell/data/pdb/quinine.pdb  
    ##   inflating: data-shell/data/pdb/ethanol.pdb  
    ##   inflating: data-shell/data/pdb/sucrose.pdb  
    ##   inflating: data-shell/data/pdb/ascorbic-acid.pdb  
    ##   inflating: data-shell/data/pdb/methane.pdb  
    ##   inflating: data-shell/data/pdb/cyclopropane.pdb  
    ##   inflating: data-shell/data/pdb/cinnamaldehyde.pdb  
    ##   inflating: data-shell/data/pdb/morphine.pdb  
    ##   inflating: data-shell/data/pdb/norethindrone.pdb  
    ##   inflating: data-shell/data/pdb/vitamin-a.pdb  
    ##   inflating: data-shell/data/pdb/citronellal.pdb  
    ##   inflating: data-shell/data/pdb/cholesterol.pdb  
    ##   inflating: data-shell/data/pdb/aldrin.pdb  
    ##   inflating: data-shell/data/pdb/vanillin.pdb  
    ##   inflating: data-shell/data/pdb/ethylcyclohexane.pdb  
    ##   inflating: data-shell/data/pdb/tuberin.pdb  
    ##   inflating: data-shell/data/pdb/mint.pdb  
    ##   inflating: data-shell/data/pdb/cyclohexanol.pdb  
    ##   inflating: data-shell/data/pdb/codeine.pdb  
    ##   inflating: data-shell/data/pdb/octane.pdb  
    ##   inflating: data-shell/data/pdb/tnt.pdb  
    ##   inflating: data-shell/data/pdb/ammonia.pdb  
    ##   inflating: data-shell/data/pdb/vinyl-chloride.pdb  
    ##   inflating: data-shell/data/planets.txt  
    ##   inflating: data-shell/data/morse.txt  
    ##    creating: data-shell/data/animal-counts/
    ##   inflating: data-shell/data/animal-counts/animals.txt  
    ##    creating: data-shell/data/elements/
    ##   inflating: data-shell/data/elements/Sb.xml  
    ##   inflating: data-shell/data/elements/Eu.xml  
    ##   inflating: data-shell/data/elements/As.xml  
    ##   inflating: data-shell/data/elements/Br.xml  
    ##   inflating: data-shell/data/elements/F.xml  
    ##   inflating: data-shell/data/elements/Lr.xml  
    ##   inflating: data-shell/data/elements/Y.xml  
    ##   inflating: data-shell/data/elements/Sn.xml  
    ##   inflating: data-shell/data/elements/Kr.xml  
    ##   inflating: data-shell/data/elements/Ho.xml  
    ##   inflating: data-shell/data/elements/Sm.xml  
    ##   inflating: data-shell/data/elements/Fr.xml  
    ##   inflating: data-shell/data/elements/Fe.xml  
    ##   inflating: data-shell/data/elements/Tb.xml  
    ##   inflating: data-shell/data/elements/Pb.xml  
    ##   inflating: data-shell/data/elements/Bk.xml  
    ##   inflating: data-shell/data/elements/Np.xml  
    ##   inflating: data-shell/data/elements/Ni.xml  
    ##   inflating: data-shell/data/elements/Rb.xml  
    ##   inflating: data-shell/data/elements/Rh.xml  
    ##   inflating: data-shell/data/elements/Zn.xml  
    ##   inflating: data-shell/data/elements/Sc.xml  
    ##   inflating: data-shell/data/elements/Mn.xml  
    ##   inflating: data-shell/data/elements/Fm.xml  
    ##   inflating: data-shell/data/elements/Am.xml  
    ##   inflating: data-shell/data/elements/Au.xml  
    ##   inflating: data-shell/data/elements/C.xml  
    ##   inflating: data-shell/data/elements/Ca.xml  
    ##   inflating: data-shell/data/elements/Ne.xml  
    ##   inflating: data-shell/data/elements/Hg.xml  
    ##   inflating: data-shell/data/elements/Ra.xml  
    ##   inflating: data-shell/data/elements/Cl.xml  
    ##   inflating: data-shell/data/elements/Li.xml  
    ##   inflating: data-shell/data/elements/Tm.xml  
    ##   inflating: data-shell/data/elements/Be.xml  
    ##   inflating: data-shell/data/elements/Pr.xml  
    ##   inflating: data-shell/data/elements/He.xml  
    ##   inflating: data-shell/data/elements/Es.xml  
    ##   inflating: data-shell/data/elements/Cf.xml  
    ##   inflating: data-shell/data/elements/Pd.xml  
    ##   inflating: data-shell/data/elements/Se.xml  
    ##   inflating: data-shell/data/elements/H.xml  
    ##   inflating: data-shell/data/elements/Nd.xml  
    ##   inflating: data-shell/data/elements/S.xml  
    ##   inflating: data-shell/data/elements/Cu.xml  
    ##   inflating: data-shell/data/elements/Pt.xml  
    ##   inflating: data-shell/data/elements/La.xml  
    ##   inflating: data-shell/data/elements/Lu.xml  
    ##   inflating: data-shell/data/elements/Ce.xml  
    ##   inflating: data-shell/data/elements/Ta.xml  
    ##   inflating: data-shell/data/elements/Po.xml  
    ##   inflating: data-shell/data/elements/Al.xml  
    ##   inflating: data-shell/data/elements/Ar.xml  
    ##   inflating: data-shell/data/elements/Pm.xml  
    ##   inflating: data-shell/data/elements/Bi.xml  
    ##   inflating: data-shell/data/elements/Tl.xml  
    ##   inflating: data-shell/data/elements/U.xml  
    ##   inflating: data-shell/data/elements/Cd.xml  
    ##   inflating: data-shell/data/elements/Zr.xml  
    ##   inflating: data-shell/data/elements/At.xml  
    ##   inflating: data-shell/data/elements/Xe.xml  
    ##   inflating: data-shell/data/elements/Rn.xml  
    ##   inflating: data-shell/data/elements/Gd.xml  
    ##   inflating: data-shell/data/elements/In.xml  
    ##   inflating: data-shell/data/elements/Ag.xml  
    ##   inflating: data-shell/data/elements/K.xml  
    ##   inflating: data-shell/data/elements/W.xml  
    ##   inflating: data-shell/data/elements/Cs.xml  
    ##   inflating: data-shell/data/elements/N.xml  
    ##   inflating: data-shell/data/elements/Mg.xml  
    ##   inflating: data-shell/data/elements/Tc.xml  
    ##   inflating: data-shell/data/elements/Pu.xml  
    ##   inflating: data-shell/data/elements/Co.xml  
    ##   inflating: data-shell/data/elements/Os.xml  
    ##   inflating: data-shell/data/elements/Ac.xml  
    ##   inflating: data-shell/data/elements/Cm.xml  
    ##   inflating: data-shell/data/elements/Na.xml  
    ##   inflating: data-shell/data/elements/Yb.xml  
    ##   inflating: data-shell/data/elements/Sr.xml  
    ##   inflating: data-shell/data/elements/Ru.xml  
    ##   inflating: data-shell/data/elements/Te.xml  
    ##   inflating: data-shell/data/elements/Ti.xml  
    ##   inflating: data-shell/data/elements/Dy.xml  
    ##   inflating: data-shell/data/elements/Md.xml  
    ##   inflating: data-shell/data/elements/Ge.xml  
    ##   inflating: data-shell/data/elements/Cr.xml  
    ##   inflating: data-shell/data/elements/Ga.xml  
    ##   inflating: data-shell/data/elements/Er.xml  
    ##   inflating: data-shell/data/elements/Hf.xml  
    ##   inflating: data-shell/data/elements/Re.xml  
    ##   inflating: data-shell/data/elements/O.xml  
    ##   inflating: data-shell/data/elements/B.xml  
    ##   inflating: data-shell/data/elements/Mo.xml  
    ##   inflating: data-shell/data/elements/Si.xml  
    ##   inflating: data-shell/data/elements/I.xml  
    ##   inflating: data-shell/data/elements/Pa.xml  
    ##   inflating: data-shell/data/elements/Ir.xml  
    ##   inflating: data-shell/data/elements/No.xml  
    ##   inflating: data-shell/data/elements/Ba.xml  
    ##   inflating: data-shell/data/elements/P.xml  
    ##   inflating: data-shell/data/elements/Nb.xml  
    ##   inflating: data-shell/data/elements/Th.xml  
    ##   inflating: data-shell/data/elements/V.xml  
    ##    creating: data-shell/writing/
    ##   inflating: data-shell/writing/haiku.txt  
    ##    creating: data-shell/writing/tools/
    ##  extracting: data-shell/writing/tools/stats  
    ##   inflating: data-shell/writing/tools/format  
    ##    creating: data-shell/writing/tools/old/
    ##  extracting: data-shell/writing/tools/old/oldtool  
    ##    creating: data-shell/writing/data/
    ##   inflating: data-shell/writing/data/two.txt  
    ##   inflating: data-shell/writing/data/one.txt  
    ##   inflating: data-shell/writing/data/LittleWomen.txt  
    ##    creating: data-shell/writing/thesis/
    ##  extracting: data-shell/writing/thesis/empty-draft.md  
    ##   inflating: data-shell/solar.pdf    
    ##    creating: data-shell/creatures/
    ##   inflating: data-shell/creatures/unicorn.dat  
    ##   inflating: data-shell/creatures/basilisk.dat  
    ##   inflating: data-shell/creatures/minotaur.dat
