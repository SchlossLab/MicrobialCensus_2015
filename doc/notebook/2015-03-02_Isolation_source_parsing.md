# Workflow for parsing isolation source information in the census sequences

Downloaded the bacteria.good.tgz file from Pat’s dropbox folder.

Uploaded to SuperMikeII:
```
$ scp bacteria.good.tgz jcthrash@mike.hpc.lsu.edu:~/
```

Uncompressed:
```
$ tar -zxvf bacteria.good.tgz
```

Spent time exploring text file, looking for environmental information.
```
$ head bacteria.good.metadata
$ head bacteria.good.metadata | cut -f 1,18
$ head bacteria.good.metadata | cut -f 1,15
$ head bacteria.good.metadata | cut -f 1,20
```

Discovered columns didn’t match header. Example: entries under “journal” actually have the isolation source information.

Total lines in the table, including the header:
```
$ wc -l bacteria.good.metadata
1222203 bacteria.good.metadata
```

Total unique isolation source terms:
```
$ cat bacteria.good.metadata | cut -f 20 | sort | uniq | wc -l
12976
```

Total entries without a designated isolation source:
```
$ cat bacteria.good.metadata | cut -f 20 | grep -w NA | wc -l
77228
```

This is very good. It means that we will be able to incorporate 1222202 - 77228 = 1144974 sequences into parsing strategies that involve environmental source.

Honed in on our strategy for parsing the data:

1. Create two levels of re-classification- coarse and fine
	Example: Aquatic	Marine, Estuarine, Fresh, Unspecified
	Example: Host-associated	Mammalian, Fish, etc.

2. Append the list of unique isolation source terms with the course and fine terms. This will create a table that we can use with a script to append the master metadata file.
