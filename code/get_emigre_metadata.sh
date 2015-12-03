# EMIRGE: reconstruction of full-length ribosomal genes from microbial community short read sequencing data.
# Miller CS, Baker BJ, Thomas BC, Singer SW, Banfield JF.
# Genome Biol. 2011;12(5):R44. doi: 10.1186/gb-2011-12-5-r44. Epub 2011 May 19.
# PMID: 21595876
# http://www.genomebiology.com/2011/12/5/R44

R -e "source('code/build_metadata.R'); build_metadata('data/raw/miller_2011_emigre.fasta', pub_date='2011-05-19', publication_doi='10.1186/gb-2011-12-5-r44', category='BI')"




# Short-read assembly of full-length 16S amplicons reveals bacterial diversity in subsurface sediments.
# Miller CS, Handley KM, Wrighton KC, Frischkorn KR, Thomas BC, Banfield JF.
# PLoS One. 2013;8(2):e56018. doi: 10.1371/journal.pone.0056018. Epub 2013 Feb 6.
# PMID: 23405248

R -e "source('code/build_metadata.R'); build_metadata('data/raw/miller_2013_emigre.fasta', pub_date='2013-02-06', publication_doi='10.1371/journal.pone.0056018', category='AQF')"



# Fermentation, hydrogen, and sulfur metabolism in multiple uncultivated bacterial phyla.
# Wrighton KC, Thomas BC, Sharon I, Miller CS, Castelle CJ, VerBerkmoes NC, Wilkins MJ, Hettich RL, Lipton MS, Williams KH, Long PE, Banfield JF.
# Science. 2012 Sep 28;337(6102):1661-5. Erratum in: Science. 2012 Nov 9;338(6108):742.
# PMID: 23019650

R -e "source('code/build_metadata.R'); build_metadata('data/raw/wrighton_2012_emigre.fasta', pub_date='2012-11-09', publication_doi='10.1126/science.1224041', category='AQF')"



# Fluctuations in species-level protein expression occur during element and nutrient cycling in the subsurface.
# Wilkins MJ, Wrighton KC, Nicora CD, Williams KH, McCue LA, Handley KM, Miller CS, Giloteaux L, Montgomery AP, Lovley DR, Banfield JF, Long PE, Lipton MS.
# PLoS One. 2013;8(3):e57819. doi: 10.1371/journal.pone.0057819. Epub 2013 Mar 5.
# PMID: 23472107

R -e "source('code/build_metadata.R'); build_metadata('data/raw/wilkins_2013_emigre.fasta', pub_date='2013-03-05', publication_doi='10.1371/journal.pone.0057819', category='AQF')"



# Microbes in the neonatal intensive care unit resemble those found in the gut of premature infants.
# Brooks B, Firek BA, Miller CS, Sharon I, Thomas BC, Baker R, Morowitz MJ, Banfield JF.
# Microbiome. 2014 Jan 28;2(1):1. doi: 10.1186/2049-2618-2-1.
# PMID: 24468033

R -e "source('code/build_metadata.R'); build_metadata('data/raw/brooks_2014_emigre.fasta', pub_date='2014-01-28', publication_doi='10.1186/2049-2618-2-1', category='ZV')"



# Isolation of a significant fraction of non-phototroph diversity from a desert Biological Soil Crust.
# Nunes da Rocha U, Cadillo-Quiroz H, Karaoz U, Rajeev L, Klitgord N, Dunn S, Truong V, Buenrostro M, Bowen BP, Garcia-Pichel F, Mukhopadhyay A, Northen TR, Brodie EL.
# Front Microbiol. 2015 Apr 14;6:277. doi: 10.3389/fmicb.2015.00277. eCollection 2015.
# PMID: 25926821

R -e "source('code/build_metadata.R'); build_metadata('data/raw/darocha_2015_emigre.fasta', pub_date='2015-04-14', publication_doi='10.3389/fmicb.2015.00277', category='SD')"



cat data/raw/*_*_emigre.metadata > data/raw/emigre.metadata
