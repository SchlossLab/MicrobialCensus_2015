---
title: "**The status of the microbial census: an update**"
bibliography: references.bib
output:
  pdf_document:
    includes:
      in_header: header.tex
csl: mbio.csl
fontsize: 11pt
geometry: margin=1.0in
---



\vspace{35mm}


Patrick D. Schloss^1$\dagger$^, Rene Girard^2^, Thomas Martin^2^, Joshua Edwards^2^, and J. Cameron Thrash^2$\dagger$^

\vspace{40mm}

$\dagger$ To whom correspondence should be addressed: pschloss@umich.edu and thrashc@lsu.edu

1\. Department of Microbiology and Immunology, University of Michigan, Ann Arbor, MI 48109

2\. Department of Biological Sciences, Louisiana State University, Baton Rouge, LA 70803


\newpage
\linenumbers


## Abstract

Abstract goes here.


## Importance


\newpage

## Introduction

The effort to quantify the number of different organisms in a system remains fundamental to understanding ecology. At the scale of microorganisms, small physical sizes, morphological ambiguity, and highly variable population sizes complicate this process immensely. Furthermore, creating standards for delimiting what makes one microbe "different” from another has proved contentious at best. In spite of these challenges, we continue to peel back the curtain on the microbial world with the aid of more and more informative, if still limited, technologies like cultivation, 16S rRNA gene surveys, and metagenomics.

Generating a comprehensive understanding of any system with a single gene may seem a fool’s errand, yet we have learned a considerable amount regarding the diversity, dynamics, and natural history of microorganisms using the venerable 16S rRNA gene. Indeed, continual community efforts to obtain 16S rRNA gene assessments of every environment possible have presented us with an ever-increasing estimate of total microbial diversity and the concomitant excitement of frontier science. While reliance on this gene subjects us to biases created by primer selection [REFS], differences in amplification strength [REFS] and fidelity [REFS], internal features which may disrupt traditional measurements [REFS], and potentially misleading classification due to infrequent horizontal gene transfer [REFS], the total data available from persistent collection of 16S rRNA gene sequences nevertheless dwarfs that of any other genetic marker. Thus, an attempt to quantify how much of the microbial world has been revealed inevitably starts there.

In 2004, Schloss and Handelsman analyzed 56,215 partial rRNA gene sequences available in the Ribosomal Database Project and concluded that "either current sampling methods are not adequate to identify 10<sup>7</sup> to 10<sup>9</sup> different species or these estimates are high (Schloss, 2004)." Since that time, the explosion of short-read high throughput sequencing technology has caused a dramatic increase in the number of sequences deposited in public databases. Currently there are over XXXXXX 16S rRNA gene sequences in SRA. Recent estimates based on this short read data place the total number of microbial species at around XXXXX.

However, the increase in sequencing volume has come at the cost of sequence length. The commonly used MiSeq-based sequencing technology amplifies the approximately 250 bp V4 hypervariable region of the 16S rRNA gene; other schemes have used different parts of the gene that are shorter than 500 bp. The decrease in length means a decrease in informative sites, making direct comparisons between short read sequencing and mostly or completely full-length sequences difficult. Youssef et al. (2009) demonstrated high variability between the number of OTUs that different hypervariable sites estimated compared to full-length 16S rRNA gene sequences, and also that sample location influenced this behavior. Thus, it remains unclear to what degree richness estimates from short read technology over or underestimate the numbers from full-length sequences.

Here we update the status of the microbial census with nearly or completely full-length 16S rRNA gene sequences. In the 12 years since the collection of data for Schloss and Handelsman’s analysis, the number of available sequences has risen over twenty-fold, despite the overwhelming contemporary focus by most researchers on short-read technologies. This update to the census allows us to evaluate the relative sampling thoroughness for different environments and clades, and make an argument for the continued need to collection full-length sequence data from many systems that have a long history of study.

* Lack of references

Issues we sought to solve...
* How have the number of full-length sequences changed over the past N years?
* How does this vary by environment?
* How has the coverage of the OTUs represented by these sequences changed over the last N years?
* How has the number of sequences per study changed over the past N years?
* How has Figure 1 changed over the past N years?


## Materials and Methods

***Sequence data curation.***
The July 19, 2015 release of the ARB-formatted SILVA small subunit (SSU) reference database (SSU Ref v.123) was downloaded from http://www.arb-silva.de/fileadmin/silva_databases/release_123/ARB_files/SSURef_123_SILVA_19_07_15_opt.arb.tgz [@REF]. This release is based on the EMBL-EBI/ENA Release 123, which was released in March 2015. The SILVA curators identify potential SSU sequences using keyword searches and sequence-based search using RNAmmer (http://www.arb-silva.de/documentation/release-123/). The SILVA curators then screened the 7,168,241 resulting sequences based on a minimum length criteria (<300 nt), number of ambiguous base calls (>2%), length of sequence homopolymers (>2%), presence of vector contamination (>2%), low alignment quality value (<75), and likelihood of being chimeric (Pintail value < 50). Of the remaining sequences, the bacterial reference set retained those bacterial sequences longer than 1,200 nt and the archaeal reference set retained those archaeal sequences longer than 900 nt. The aligned 1,515,024 bacterial and 59,240 archaeal sequences were exported from the database using ARB along with the complete set of metadata. Additional sequence data was included from single-cell genomes available on the Integrated Microbial Genomes (IMG) system [@REF], many of which were recently obtained via the GEBA-MDM effort in Rinke et al. [@REF]. "SCGC” was searched on the IMG database March 12, 2015 to download the bacterial (N=249) and archaeal (N=46) 16S rRNA gene sequences and their associated metadata. The IMG sequences were aligned against the respective SILVA-based reference using mothur [@REF]. The aligned bacterial and archaeal sequence sets from SILVA and IMG were pooled and processed in parallel in mothur. Using mothur, sequences were further screened to remove any sequence with more than 2 ambiguous base calls and trimmed to overlap the same alignment coordinates while maintaining a minimum sequence length of 1,200 and 900 nt for the bacterial and archeael datasets, respectively. The final datasets contained 1,412,682 bacterial and 53,619 archaeal 16S rRNA gene sequences. Sequences were assigned to operational taxonomic units (OTUs) with a 3% distance threshold using the average neighbor clustering algorithm.


***Metadata curation.***
The environmental origins of the 16S rRNA gene sequences were manually classified using seven broad "coarse” categories, and further refined to facilitate additional analyses with twenty-six more specific "fine” categories (Table 1). These were assigned based on manual curation of the `isolation_source` category within the ARB database associated with each of the sequences. There were 20,084 bacterial and 1,613 archaeal isolation_source terms that were manually assigned to the coarse and fine categories in Table 1. For source definitions that were identifiable by online searches, educated guesses were made or they were placed into the coarse "Other” category. There were 150,378 bacterial and 2,604 archaeal sequences where an `isolation_source` term was not collected. Complete tables containing the ARB-provided metadata, taxonomic information, OTU assignment, and our categorization are available at [@figshare???].


***Data analysis.***
Our analysis made use of ARB [OS X v.6.0, @Pruesse2007], mothur mothur [v.1.37.0; @Schloss2009], and R [v.3.2.2; @language2015]. Within R we utilized knitr [v.1.10.5; @xie2013dynamic] and openxlsx [v. 2.4.0; @Walker2015] packages. A reproducible version of this manuscript including data extraction and processing is available at https://www.github.com/SchlossLab/Schloss_Census2_XXXX_2015.


## Results and Discussion



***Caveats.***
Recent data suggests that a considerable diversity of microorganisms may be missing based on biases in existing 16S rRNA gene primers. This dataset does not include sequences from metagenomic assemblies but Brown et al. (2015) have used such assemblies to show evidence for introns in the 16S rRNA genes of organisms within the so-called "Candidate Phyla Radiation” (CPR- Saccharibacteria (TM7), Peregrinibacteria, Berkelbacteria (ACD58), WWE3 Microgenomates (OP11), Parcubacteria (OD1), et al.), that would preclude detection with standard cultivation-independent microbial surveys. Furthermore, many of these CPR organisms are very small and frequently pass through 0.2 µm filters (Luef, 2015). Thus, for many environments, the estimates within must be considered as lower bounds.

**Table 1. Habitat classifications**
