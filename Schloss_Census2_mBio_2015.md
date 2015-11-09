The status of the microbial census: an update
=============================================

Patrick D. Schloss<sup>1*</sup>, Rene Girard<sup>2</sup>, Thomas Martin<sup>2</sup>, Joshua Edwards<sup>2</sup>, J. Cameron Thrash<sup>2*</sup>

1.  Department of Microbiology and Immunology, University of Michigan, Ann Arbor, MI 48109, U.S.A.
2.  Department of Biological Sciences, Louisiana State University, Baton Rouge, LA 70803, U.S.A.

\* Correspondence: <pschloss@umich.edu>, <thrashc@lsu.edu>

Abstract
--------

Abstract goes here.

Introduction
------------

The effort to quantify the number of different organisms in a system remains fundamental to understanding ecology. At the scale of microorganisms, small physical sizes, morphological ambiguity, and highly variable population sizes complicate this process immensely. Furthermore, creating standards for delimiting what makes one microbe “different” from another has proved contentious at best. In spite of these challenges, we continue to peel back the curtain on the microbial world with the aid of more and more informative, if still limited, technologies like cultivation, 16S rRNA gene surveys, and metagenomics.

Generating a comprehensive understanding of any system with a single gene may seem a fool’s errand, yet we have learned a considerable amount regarding the diversity, dynamics, and natural history of microorganisms using the venerable 16S rRNA gene. Indeed, continual community efforts to obtain 16S rRNA gene assessments of every environment possible have presented us with an ever-increasing estimate of total microbial diversity and the concomitant excitement of frontier science. While reliance on this gene subjects us to biases created by primer selection*, differences in amplification strength* and fidelity*, internal features which may disrupt traditional measurements*, and potentially misleading classification due to infrequent horizontal gene transfer\*, the total data available from persistent collection of 16S rRNA gene sequences nevertheless dwarfs that of any other genetic marker. Thus, an attempt to quantify how much of the microbial world has been revealed inevitably starts there.

In 2004, the Status of the Microbial Census analyzed 56,215 partial rRNA gene sequences available in the Ribosomal Database Project and concluded that “either current sampling methods are not adequate to identify 107 to 109 different species or these estimates are high.” (Schloss, 2004) Since that time, the explosion of short-read high throughput sequencing technology has caused a dramatic increase in the number of sequences deposited in public databases. Currently there are over XXXXXX 16S rRNA gene sequences in SRA. Recent estimates based on this short read data place the total number of microbial species at around XXXXX.

However, the increase in sequencing volume has come at the cost of sequence length. The commonly used iTag sequencing technology amplifies an approximately 250 bp region of the 16S rRNA gene at the V4 hypervariable region, and other schemes have used different parts of the gene. The decrease in length means a decrease in informative sites, making direct comparisons between short read sequencing and mostly or completely full-length sequences difficult. Youssef et al. (2009) demonstrated high variability between the number of OTUs that different hypervariable sites estimated compared to full-length 16S rRNA gene sequences, and also that sample location influenced this behavior. Thus, it remains unclear to what degree richness estimates from short read technology over or underestimate the numbers from full-length sequences.

Here we update the status of the microbial census with nearly or completely full-length 16S rRNA gene sequences. In the 12 years since the collection of data for Schloss and Handelsman’s analysis, the number of available sequences has risen over twenty-fold, despite the overwhelming contemporary focus by most researchers on short-read technologies. This update to the census allows us to evaluate the relative sampling thoroughness for different environments and clades, and make an argument for the continued need to collection full-length sequence data from many systems that have a long history of study.

Materials and Methods
---------------------

Sequence data Primary sequences were downloaded from the ARB-SILVA database on XXXX, 2015 with the requirement that sequences were ≥ XXXX bp. This resulted in XXXXXXXX unique sequences. Additional sequence data was included from single-cell genomes available on IMG, many of which were recently obtained via the GEBA-MDM effort in Rinke et al. (2014). “SCGC” was searched on the IMG database 12 Mar 2015, manually separated into bacterial and archaeal SSU genes, and associated metadata was also downloaded.

Classification of organisms based on source metadata Organisms were classified based on seven broad “coarse” categories, and refined further to facilitate additional analyses with twenty-six more specific “fine” categories (Table 1). These were assigned based on manual curation of the metadata associated with sequences obtained from the ARB-SILVA and IMG databases. The original metadata table was edited through sorting the “Source” category alphabetically and filtering for unique terms. The resulting XXXXXX terms were then manually assigned to the coarse and fine categories in Table 1. For source definitions that were identifiable by online searches, educated guesses were made or they were placed into the coarse “Other” category.

OTU clustering with Mothur

Plots Rarefaction curves were completed in R using modifications to the script available in Supplementary Information.

Results and Discussion
----------------------

Caveats Recent data suggests that a considerable diversity of microorganisms may be missing based on biases in existing 16S rRNA gene primers. This dataset does not include sequences from metagenomic assemblies but Brown et al. (2015) have used such assemblies to show evidence for introns in the 16S rRNA genes of organisms within the so-called “Candidate Phyla Radiation” (CPR- Saccharibacteria (TM7), Peregrinibacteria, Berkelbacteria (ACD58), WWE3 Microgenomates (OP11), Parcubacteria (OD1), et al.), that would preclude detection with standard cultivation-independent microbial surveys. Furthermore, many of these CPR organisms are very small and frequently pass through 0.2 µm filters (Luef, 2015). Thus, for many environments, the estimates within must be considered as lower bounds.  Table 1. Habitat classifications
