

# Getting the archaeal sequence data and metadata

## Get data out of ARB

This is redundant with what we saw for the bacterial data, but for completion...

> To create SSU Ref (ARB file), all sequences below 1,200 bases for Bacteria and
> Eukarya and below 900 bases for Archaea or an alignment identity below 70 or an
> alignment quality value below 50 have been removed from SSU Parc. All sequences
> with a Pintail value < 50 or an alignment quality value < 75 have been assigned
> to color group 1 in ARB (red). All Living Tree Project or  StrainInfo
> typestrains have been assigned to color group 2 in ARB (light blue). From
> http://www.arb-silva.de/documentation/release-119/




Within ARB, we will exclude color group 1, chloroplasts, and mitochondria.

To get good sequences...
* Go to search window
* Set Search_Fields to "ARB_color" and use "1"; click on the equal sign to make it not equal
* Hit Mark Listed, Unmark Rest button (N=1493493)
* The problem with the taxonomies is that the sequences don't all have taxonomies. Need to figure
    out which taxonomy to base the analysis on. Do the following searches...
    * ARB_color != 1 & tax_rdp == "*Archaea*" (N=40288)
    * ARB_color != 1 & tax_greengenes == "*Archaea*" (N=19795)
    * ARB_color != 1 & tax_slv == "*Archaea*" (N=17641)
    * ARB_color != 1 & tax_embl == "*Archaea*" (N=44574)
    * ARB_color != 1 & (tax_rdp | tax_greengenes | tax_embl | tax_slv) (N=46387 )


Let's stick with the archaeal sequences that have an RDP taxonomy and we will
analyze them in RDP space, but we can always go back to the taxonomy provided by
the other systems if we'd like. A quick spot checking suggests that the RDP
taxonomy information is actually richer than that of the EBML taxonomy
information.

* Return to Search and Query window
* Change search field to "ARB_color", enter "1", and click the equal sign to be not-equal
* Change the second search field to "tax_rdp" and set it to "*Archaea*"
* Hit "Search"
* Hit Mark Listed Unmark Rest (N=40,288)
* Click "Write to Fields of Listed", select the "remark" field, and enter "good archaea"
* Click "Write"
* In main ARB window go File->Export->Export to external format
* Select Compress -> "Vertical Gaps" and fasta_mothur.eft as the format
* Rename `noname.fasta` to `archaea.fasta`

Now we need the taxonomy information.
* Go Tree -> NDS
* Click "name", "acc", "tax_rdp". The "tax_rdp" field should have 250 characters
* Unclick everything else
* Click "Close"
* Go File->Export->Export fields
* Set the file name to "archaea.taxonomy" and Column output to "TAB separated"
* Click "SAVE"

Finally, let's save the database by doing File -> Quick Save Changes and then
quit out of ARB.


## Format taxonomy file

The next thing we need to do is to clean up the archaea.taxonomy.nds file
to make it into a proper, mothur compatible archaea.taxonomy file. First we
want to remove the names of any sub taxa (e.g. suborder). To do this we need
to get the RDP list of names and the taxonomic level they belong to...



Now we're read to do some R'ing to get the taxonomy file formatted properly...





## Get good sequences

Now we need to know the start/end position of the sequences so that we can
make sure the reads overlap the same alignment space.



```bash
mothur "#summary.seqs(fasta=archaea.fasta, processors=12)"
```

```
            Start    End	NBases	Ambigs	Polymer	NumSeqs
Minimum:	1        4058	900	    0    	4	1
2.5%-tile:	357      4692	905	    0    	5	1008
25%-tile:	365      4783	935	    0   	5	10073
Median: 	379      7409	1262	0   	5	20145
75%-tile:	456      7729	1349	0    	6	30217
97.5%-tile:	1746	 7984	1470	4   	7	39281
Maximum:	2321	 8711	2174	46     	32	40288
Mean:	    513.659	 6698.2	1185.3	0.3	    5.44244
# of Seqs:	40288
```


Notes...
* Will want to get rid of sequences with large number of Ns in them and the
ridiculously long homopolymrs - how large?




Now let's run these parameters using mothur.





## Single cell genomics data

Using 16S rRNA gene sequences from the single cell genomics projects we'd like
to see whether that type of data has had a meaningful impact on the trajectory
of the microbial census. The LSU team scraped these 251 sequences from a
database and have provided them to me as a fasta file. Some of them are quite
short and none of them are aligned. Let's go ahead and align them to the SILVA
alignment and then screen them to keep sequences that overlap with the SILVA
sequences.




## Pooling the data

Now we want to merge the SILVA and single cell genomics 16S rRNA gene sequence
collections. We'll also filter the sequences to overlap in the same alignment
space, unique them, and precluster them...



Now we're ready to cluster the sequences. We'll do it by the classic approach
without any cutoffs and see what we get. Let's start by splitting things at the
phylum level and cluster from there...




## Get metadata

We'd like to use some metadata from the database to characterize the changes in
the representation of sequences over time, by environment, methods, etc. The
fields housed within SILVA are available at their [website](http://www.arb-silva.de/fileadmin/arb_web_db/release_115/Fields_description/SILVA_description_of_fields_16_06_2013.htm)
and there is an [FAQ](http://www.arb-silva.de/documentation/faqs/) on their site
as well. There were a number of fields that I didn't think were relevant and
instead focused on 30 fields that I thought could help the cause. I marked these
fields in the NDS feature and extracted them to `archaea_metadata.nds`. We need to
tweak this file slightly in R to get it into a format that we can use.




Now we want to read in `archaea.bad.accnos` so that we can figure out which
sequences to cull from the metadata table.



We'd also like to get the metadata from the single cell data. We have an `xlsx` that the LSU group pulled together that we'll read in and concatenate to the end of `archaea.good.metadata`.


