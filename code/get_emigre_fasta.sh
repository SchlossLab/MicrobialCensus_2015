# EMIRGE: reconstruction of full-length ribosomal genes from microbial community short read sequencing data.
# Miller CS, Baker BJ, Thomas BC, Singer SW, Banfield JF.
# Genome Biol. 2011;12(5):R44. doi: 10.1186/gb-2011-12-5-r44. Epub 2011 May 19.
# PMID: 21595876
# http://www.genomebiology.com/2011/12/5/R44

wget http://www.genomebiology.com/content/supplementary/gb-2011-12-5-r44-s3.fasta -O data/raw/miller_2011_emigre.fasta



# Short-read assembly of full-length 16S amplicons reveals bacterial diversity in subsurface sediments.
# Miller CS, Handley KM, Wrighton KC, Frischkorn KR, Thomas BC, Banfield JF.
# PLoS One. 2013;8(2):e56018. doi: 10.1371/journal.pone.0056018. Epub 2013 Feb 6.
# PMID: 23405248

wget http://banfieldlab.berkeley.edu/EMIRGE/data/paper2/EMIRGE_reconstructed_16S.fasta.gz -O data/raw/miller_2013_emigre.fasta.gz
gunzip data/raw/miller_2013_emigre.fasta.gz



# Fermentation, hydrogen, and sulfur metabolism in multiple uncultivated bacterial phyla.
# Wrighton KC, Thomas BC, Sharon I, Miller CS, Castelle CJ, VerBerkmoes NC, Wilkins MJ, Hettich RL, Lipton MS, Williams KH, Long PE, Banfield JF.
# Science. 2012 Sep 28;337(6102):1661-5. Erratum in: Science. 2012 Nov 9;338(6108):742.
# PMID: 23019650

wget http://www.sciencemag.org/content/suppl/2012/09/26/337.6102.1661.DC1/1224041_SupplmentalDownload.zip
unzip 1224041_SupplmentalDownload.zip FASTA_files/16S_EMIRGE_CloneSilva108db_p0.005.fasta
mv FASTA_files/16S_EMIRGE_CloneSilva108db_p0.005.fasta data/raw/wrighton_2012_emigre.fasta
rm -rf FASTA_files 1224041_SupplmentalDownload.zip



# Fluctuations in species-level protein expression occur during element and nutrient cycling in the subsurface.
# Wilkins MJ, Wrighton KC, Nicora CD, Williams KH, McCue LA, Handley KM, Miller CS, Giloteaux L, Montgomery AP, Lovley DR, Banfield JF, Long PE, Lipton MS.
# PLoS One. 2013;8(3):e57819. doi: 10.1371/journal.pone.0057819. Epub 2013 Mar 5.
# PMID: 23472107

wget "http://journals.plos.org/plosone/article/asset?unique&id=info:doi/10.1371/journal.pone.0057819.s003" -O data/raw/wilkins_2013.docx
pandoc -s data/raw/wilkins_2013.docx -t markdown -o data/raw/wilkins_2013.md
R -e "write(gsub('[\\\\\]', '', scan(file='data/raw/wilkins_2013.md', what='', sep='\\\n', quiet=T))[-1], 'data/raw/wilkins_2013_emigre.fasta')"
rm data/raw/wilkins_2013.docx data/raw/wilkins_2013.md



# Microbes in the neonatal intensive care unit resemble those found in the gut of premature infants.
# Brooks B, Firek BA, Miller CS, Sharon I, Thomas BC, Baker R, Morowitz MJ, Banfield JF.
# Microbiome. 2014 Jan 28;2(1):1. doi: 10.1186/2049-2618-2-1.
# PMID: 24468033

wget http://ggkbase.berkeley.edu/project_files/2
wget http://ggkbase.berkeley.edu/project_files/3
wget http://ggkbase.berkeley.edu/project_files/4
wget http://ggkbase.berkeley.edu/project_files/5
cat 2 3 4 5 > data/raw/brooks_2014_emigre.fasta
rm 2 3 4 5



# Isolation of a significant fraction of non-phototroph diversity from a desert Biological Soil Crust.
# Nunes da Rocha U, Cadillo-Quiroz H, Karaoz U, Rajeev L, Klitgord N, Dunn S, Truong V, Buenrostro M, Bowen BP, Garcia-Pichel F, Mukhopadhyay A, Northen TR, Brodie EL.
# Front Microbiol. 2015 Apr 14;6:277. doi: 10.3389/fmicb.2015.00277. eCollection 2015.
# PMID: 25926821

wget http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4396413/bin/DataSheet1.ZIP
unzip DataSheet1.ZIP 'Supplementary Material BSC_EMIRGE_outputs/BSC_Metagenome_SSUrRNA_EMIRGEoutput.fasta'
mv "Supplementary Material BSC_EMIRGE_outputs/BSC_Metagenome_SSUrRNA_EMIRGEoutput.fasta" data/raw/darocha_2015_emigre.fasta
rm -rf "Supplementary Material BSC_EMIRGE_outputs" DataSheet1.ZIP



cat data/raw/*_*_emigre.fasta > data/raw/emigre.fasta
