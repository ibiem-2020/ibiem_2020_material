This project contains code for teaching a basic 16S rRNA amplicon analysis pipeline. Do the following to run this analysis.

> Ideally this file would be named README.md and be in the top directory of the git repository

# Computing Environment
To replicate this analysis, a Docker container can be downloaded from [Docker Hub](https://hub.docker.com/r/ibiem/docker_rstudio_ibiem2020) using the command `docker pull ibiem/docker_rstudio_ibiem2020:2020_v004` (using Docker) or `singularity pull docker://ibiem/docker_rstudio_ibiem2020:2020_v004` (using Singularity).

# Code
## Git Repository
Clone the [course git repository](https://github.com/ibiem-2020/ibiem_2020_material) (this repository) using: `git clone https://github.com/ibiem-2020/ibiem_2020_material.git`.

## Run 
Run the Rmarkdown `content/lessons/run_everything_clean.Rmd` (in the Docker image described above) to automatically download the data, taxonomic references, and run the full analysis pipeling. Detailed instructions for doing this manually are give below.


# Run By Hand

### Data
The data used in this analysis is a subset (one percent of the total data) of a publically available 16S rRNA dataset generated from soil samples collected in the Atacama Desert. This dataset was orginally published in:

Significant Impacts of Increasing Aridity on the Arid Soil Microbiome. Julia W. Neilson, Katy Califf, Cesar Cardona, Audrey Copeland, Will van Treuren, Karen L. Josephson, Rob Knight, Jack A. Gilbert, Jay Quade, J. Gregory Caporaso, and Raina M. Maier. mSystems May 2017, 2 (3) e00195-16; DOI: 10.1128/mSystems.00195-16.

The metadata and FASTQs can be downloaded using the following URLs:

1. https://data.qiime2.org/2018.11/tutorials/atacama-soils/sample_metadata.tsv 
2. https://data.qiime2.org/2018.11/tutorials/atacama-soils/1p/forward.fastq.gz 
3. https://data.qiime2.org/2018.11/tutorials/atacama-soils/1p/reverse.fastq.gz 
4. https://data.qiime2.org/2018.11/tutorials/atacama-soils/1p/barcodes.fastq.gz

### Taxonomy References
To replicate the analysis, first download the version of the Silva v132 16S rRNA database formatted for DADA2 `assignTaxonomy` from the following URLs:

1. https://zenodo.org/record/1172783/files/silva_nr_v132_train_set.fa.gz
2. https://zenodo.org/record/1172783/files/silva_species_assignment_v132.fa.gz


### Rmarkdown Documents
Finally run (in the Docker image described above) the Rmarkdown documents listed below (all are in the `content/lessons` subdirectory of the git repository). The Rmarkdown documents must be run in the order listed:

1. demultiplex_with_fastq_multx.Rmd
2. dada2_tutorial_1_6.Rmd
3. alpha_diversity.Rmd
4. absolute_abundance_plots.Rmd
5. relative_abundance.Rmd



