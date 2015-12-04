wget http://mothur.org/w/images/1/15/Silva.seed_v123.tgz -O data/references/Silva.seed_v123.tgz
tar xvzf data/references/Silva.seed_v123.tgz silva.seed_v123.tax
mv silva.seed_v123.tax data/references/
rm data/references/Silva.seed_v123.tgz

grep "Bacteria;" data/references/silva.seed_v123.tax | cut -f 1 > data/references/silva.seed_v123.bacteria.accnos

mothur "#get.seqs(fasta=data/mothur/bacteria.fasta, accnos=data/references/silva.seed_v123.bacteria.accnos, outputdir=data/references)"

mv data/references/bacteria.pick.fasta data/references/bacteria.seed.fasta

#grep "Archaea;" data/references/silva.seed_v123.tax | cut -f 1 > data/references/silva.seed_v123.archaea.accnos
#
#mothur "#get.seqs(fasta=data/mothur/archaea.fasta, accnos=data/references/silva.seed_v123.archaea.accnos, outputdir=data/references)"
#
#align the archaeal sequences against data/mothur/archaea.fasta
