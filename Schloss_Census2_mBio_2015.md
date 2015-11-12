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


\newpage

## Importance

Importance goes here.



\newpage

## Introduction
In 1983, the full-length 16S rRNA gene sequence of *Escherichia coli* (accession J01695) was deposited into NCBI's GenBank making it the first of more than 10 million 16S rRNA gene sequences to be deposited into the database [@Brosius1978]. GenBank accessions represent nearly one-third of all sequences deposited in the database making it the best-represented gene. As Sanger sequencing has given way to to-called "next generation sequencing" technologies, hundreds of millions of 16S rRNA gene sequences have been deposited into the NCBI's Sequence Read Archive. The expansion in sequencing throughput and increased access to sequencing technology has allowed for more environments to be sequenced at a deeper coverage resulting in the identification of novel taxa. The ability to obtain sequence data from microorganisms without cultivation has radically altered our perspective of their role in nearly every environment from deep ocean sediment cores (e.g. accession AY436526) to the International Space Station (e.g. accession DQ497748). The effort to quantify the number of different organisms in a system remains fundamental to understanding ecology [@reference]. At the scale of microorganisms, small physical sizes, morphological ambiguity, and highly variable population sizes complicate this process. Furthermore, creating standards for delimiting what makes one microbe "different” from another has been contentious [@reference]. In spite of these challenges, we continue to peel back the curtain on the microbial world with the aid of more and more informative, if still limited, technologies like cultivation, 16S rRNA gene surveys, and metagenomics.

The increase in sequencing volume has come at the cost of sequence length. The commonly used MiSeq-based sequencing platform from Illumina is widely used to sequence the approximately 250 bp V4 hypervariable region of the 16S rRNA gene; other schemes have used different parts of the gene that are generally shorter than 500 bp. Perhaps most disconcerting about this development is the sense that the increased read depth is being gained using short read platforms rather than the full-length sequences. Because these short reads are used for classification to existing taxa, we are missing the opportunity to propose novel candidate taxa and vastly underappreciating the biodiversity of microbial life. We likely lack the references necessary to adequately classify the novel biodiversity we are sampling when we generate 100-times the sequence data from a community than we did using full-length sequencing.

Previously, Schloss and Handelsman [-@Schloss2004] assigned the then available 56,215 partial rRNA gene sequences to operational taxonomic units (OTUs) that were available in the Ribosomal Database Project and concluded that the sampling methods of the time were insufficient to identify the previously estimated 10^7^ to 10^9^ different species [@Dykhuizen1998, @Curtis2002]. That census called for a broader and deeper characterization of all environments. Refreshingly, this challenge was largely met. There have been major investments in studying the Earth's microbiome using 16S rRNA gene sequencing through initiatives such as the Human Microbiome Project [@reference], the Earth Microbiome Project [@reference], and the International Census of Marine Microorganisms. But most important, the original census was performed on the cusp of radical developments in sequencing technologies. That advancement has largely moved the bulk of sequencing throughput from large sequencing centers to individual investigators and leveraged their diversity to expand the representation of organisms and environments represented in public databases.

Here we update the status of the microbial census with nearly or completely full-length 16S rRNA gene sequences. In the 13 years since the collection of data for Schloss and Handelsman’s analysis, the number of full-length sequences has grown exponentially, despite the overwhelming contemporary focus by most researchers on short-read technologies. This update to the census allows us to evaluate the relative sampling thoroughness for different environments and clades, and make an argument for the continued need to collection full-length sequence data from many systems that have a long history of study. Although there has been a robust growth in the number of full-length sequences deposited to GenBank since its creation in 1983, the rate of growth has stalled over the past 5 years and the deposits have been dominated by a handful of research groups studying a limited number of environments. As researchers consider coalescing into a Unified Microbiome Initiative [@Alivisatos2015], it will be important to balance the need for mechanism-based studies with the need to generate full-length reference sequences from a diversity of environments.


## Materials and Methods

***Sequence data curation.***
The July 19, 2015 release of the ARB-formatted SILVA small subunit (SSU) reference database (SSU Ref v.123) was downloaded from http://www.arb-silva.de/fileadmin/silva_databases/release_123/ARB_files/SSURef_123_SILVA_19_07_15_opt.arb.tgz [@REF]. This release is based on the EMBL-EBI/ENA Release 123, which was released in March 2015. The SILVA curators identify potential SSU sequences using keyword searches and sequence-based search using RNAmmer (http://www.arb-silva.de/documentation/release-123/). The SILVA curators then screened the 7,168,241 resulting sequences based on a minimum length criteria (<300 nt), number of ambiguous base calls (>2%), length of sequence homopolymers (>2%), presence of vector contamination (>2%), low alignment quality value (<75), and likelihood of being chimeric (Pintail value < 50). Of the remaining sequences, the bacterial reference set retained those bacterial sequences longer than 1,200 nt and the archaeal reference set retained those archaeal sequences longer than 900 nt. The aligned 1,515,024 bacterial and 59,240 archaeal sequences were exported from the database using ARB along with the complete set of metadata. Additional sequence data was included from single-cell genomes available on the Integrated Microbial Genomes (IMG) system [@REF], many of which were recently obtained via the GEBA-MDM effort in Rinke et al. [@REF]. "SCGC” was searched on the IMG database March 12, 2015 to download the bacterial (N=249) and archaeal (N=46) 16S rRNA gene sequences and their associated metadata. The IMG sequences were aligned against the respective SILVA-based reference using mothur [@REF]. The aligned bacterial and archaeal sequence sets from SILVA and IMG were pooled and processed in parallel in mothur. Using mothur, sequences were further screened to remove any sequence with more than 2 ambiguous base calls and trimmed to overlap the same alignment coordinates while maintaining a minimum sequence length of 1,200 and 900 nt for the bacterial and archeael datasets, respectively. The final datasets contained 1,412,681 bacterial and 53,618 archaeal 16S rRNA gene sequences. Sequences were assigned to operational taxonomic units (OTUs) with a 3% distance threshold using the average neighbor clustering algorithm.


***Metadata curation.***
The environmental origins of the 16S rRNA gene sequences were manually classified using seven broad "coarse” categories, and further refined to facilitate additional analyses with twenty-six more specific "fine” categories (Table 1). These were assigned based on manual curation of the `isolation_source` category within the ARB database associated with each of the sequences. There were 20,084 bacterial and 1,613 archaeal isolation_source terms that were manually assigned to the coarse and fine categories in Table 1. For source definitions that were identifiable by online searches, educated guesses were made or they were placed into the coarse "Other” category. There were 150,378 bacterial and 2,604 archaeal sequences where an `isolation_source` term was not collected. Complete tables containing the ARB-provided metadata, taxonomic information, OTU assignment, and our categorization are available at [@figshare].


***Data analysis.***
Our analysis made use of ARB (OS X v.6.0) [@Pruesse2007], mothur (v.1.37.0) [@Schloss2009], and R (v.3.2.2) [@language2015]. Within R we utilized knitr (v.1.10.5) [@xie2013dynamic] and openxlsx (v. 2.4.0) [@Walker2015] packages. A reproducible version of this manuscript including data extraction and processing is available at https://www.github.com/SchlossLab/Schloss_Census2_mBio_2015.


## Results and Discussion

Issues we sought to solve...

* How have the number of full-length sequences changed over the past N years?
* How does this vary by environment?
* How has the coverage of the OTUs represented by these sequences changed over the last N years?
* How has the number of sequences per study changed over the past N years?
* How has Figure 1 changed over the past N years?


***Caveats.***
Recent data suggests that a considerable diversity of microorganisms may be missing based on biases in existing 16S rRNA gene primers. This dataset does not include sequences from metagenomic assemblies but Brown et al. (2015) have used such assemblies to show evidence for introns in the 16S rRNA genes of organisms within the so-called "Candidate Phyla Radiation” (CPR- Saccharibacteria (TM7), Peregrinibacteria, Berkelbacteria (ACD58), WWE3 Microgenomates (OP11), Parcubacteria (OD1), et al.), that would preclude detection with standard cultivation-independent microbial surveys. Furthermore, many of these CPR organisms are very small and frequently pass through 0.2 µm filters (Luef, 2015). Thus, for many environments, the estimates within must be considered as lower bounds.

Generating a comprehensive understanding of any system with a single gene may seem a fool’s errand, yet we have learned a considerable amount regarding the diversity, dynamics, and natural history of microorganisms using the venerable 16S rRNA gene. Indeed, continual community efforts to obtain 16S rRNA gene assessments of every environment possible have presented us with an ever-increasing estimate of total microbial diversity and the concomitant excitement of frontier science. While reliance on this gene subjects us to biases created by primer selection [REFS], differences in amplification strength [REFS] and fidelity [REFS], internal features which may disrupt traditional measurements [REFS], and potentially misleading classification due to infrequent horizontal gene transfer [REFS], the total data available from persistent collection of 16S rRNA gene sequences nevertheless dwarfs that of any other genetic marker. Thus, an attempt to quantify how much of the microbial world has been revealed inevitably starts there.



## Conclusions

Future for PacBio in generating full-length sequences

The first 16S sequence was published in 1978, not deposited until 1983. A bit of an allegory for our time.



\newpage
\singlespacing

**Table 1. Habitat classifications**


\begin{tabular}{l|l|c|c|c}
\hline
Coarse & Fine & Abbreviation & Bacterial & Archaeal\\
\hline
Aerosol &  & AE & 3444 & 2\\
\hline
Aquatic & Brackish & AQB & 1272 & 1368\\
\hline
 & Brackish sediment & AQBS & 387 & 525\\
\hline
 & Freshwater & AQF & 21445 & 1540\\
\hline
 & Freshwater sediment & AQFS & 23965 & 1324\\
\hline
 & Hydrothermal vent & AQH & 10650 & 3807\\
\hline
 & Ice & AQI & 2022 & 42\\
\hline
 & Marine & AQM & 130529 & 11007\\
\hline
 & Marine sediment & AQMS & 27586 & 14049\\
\hline
 & Other & AQO & 8214 & 772\\
\hline
Built & Digesters & BD & 32551 & 4488\\
\hline
 & Food-associated & BF & 11721 & 117\\
\hline
 & Industrial/mining & BI & 16209 & 1254\\
\hline
 & Other & BO & 8018 & 444\\
\hline
 & Pollution associated & BP & 38224 & 716\\
\hline
Plant associated & Other & PO & 9529 & 22\\
\hline
 & Root & PR & 19059 & 200\\
\hline
 & Surface & PS & 4819 & 0\\
\hline
Soil & Agriculture & SA & 9944 & 146\\
\hline
 & Desert & SD & 3040 & 245\\
\hline
 & Other & SO & 58936 & 2091\\
\hline
 & Permafrost & SP & 1884 & 39\\
\hline
Zoological & Arthropod & ZA & 12835 & 87\\
\hline
 & Non-arthropod invertebrate & ZN & 7392 & 67\\
\hline
 & Other & ZO & 10714 & 54\\
\hline
 & Vertebrate & ZV & 768601 & 5389\\
\hline
Other &  & OT & 19219 & 882\\
\hline
No isolation\_source &  &  & 150472 & 2941\\
\hline
Total &  &  & 1412681 & 53618\\
\hline
\end{tabular}

\newpage
\doublespacing


## References
