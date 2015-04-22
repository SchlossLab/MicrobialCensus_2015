# I copied the first column of the spreadsheet into a file called `source_categories.txt`
# First, I went through and counted the number of times each word was used and ranked
# them in decreasing order of abundance

original_words <- tolower(scan(file="source_categories.txt", quiet=T, what=""))
original_words_freq <- table(original_words)
head(sort(original_words_freq, decreasing=T), n=100)

# From this we can see a lot of useless words like of, from, etc. But also there are
# categories that have useful words like soil, water, sediment, etc. Let's read the
# categories back in but doing it one line at a time this time instead of one word at
# a time:

categories <- tolower(scan(file="source_categories.txt", quiet=T, what="", sep="\n"))

# let's look at some of the categories that contain words like "soil"

categories[grepl("soil", categories)]

# From this we see categories like: "0-20 cm bulk soil, duennwald forest". What I would
# propose is using the grepl R function to quickly sift through these categories that 
# contain high frequency words.
#
# go through and reassign any categories that contain high frequency words to 
# the categories categories names. here are a few that I used to get going...

categories[grepl("soil", categories, ignore.case=T)] <- "soil"
categories[grepl("rhizosphere", categories, ignore.case=T)] <- "soil"

categories[grepl("sediment", categories, ignore.case=T)] <- "sediment"

categories[grepl("wastewater", categories, ignore.case=T)] <- "wastewater"
categories[grepl("sludge", categories, ignore.case=T)] <- "wastewater"
categories[grepl("sludge", categories, ignore.case=T)] <- "wastewater"

categories[grepl("sea", categories, ignore.case=T)] <- "marine"
categories[grepl("marine", categories, ignore.case=T)] <- "marine"

categories[grepl("culture", categories, ignore.case=T)] <- "laboratory"
categories[grepl("reactor", categories, ignore.case=T)] <- "laboratory"
categories[grepl("anaerobic", categories, ignore.case=T)] <- "laboratory"

categories[grepl("lake", categories, ignore.case=T)] <- "freshwater"
categories[grepl("river", categories, ignore.case=T)] <- "freshwater"

categories[grepl("feces", categories, ignore.case=T)] <- "host-associated"
categories[grepl("patient", categories, ignore.case=T)] <- "host-associated"
categories[grepl("diet", categories, ignore.case=T)] <- "host-associated"
categories[grepl("fish", categories, ignore.case=T)] <- "host-associated"
categories[grepl("tract", categories, ignore.case=T)] <- "host-associated"

# at any time we can see how many unique categories names we have using the length
# and unique functions...

length(unique(categories))

# so after the above commands we can see that we now have 7002 unique categories, 
# which is a reduction of about 6000 fields

# at anytime you can get an update of the high frequency words by running the
# following commands:

categories_words <- unlist(strsplit(split=" ", categories))
categories_words_table <- table(categories_words)
head(sort(categories_words_table, decreasing=T), n=100)

# what we'll see are our categories rising to the top of this list. If you want 
# more than the top 100, just change the `n=100` to whatever you want in the 
# `head` command above. based on this list, the next thing I would look at would
# be to assign `skin` to the `host-associated` bin.

# i suspect you will reach a point where it isn't so obvious what categories
# something belongs to. you can get the full categories description by doing this:

categories[grepl("field", categories)]

# with this specific example, it seems most appropriate that anything with a field
# label should go in the soil categories categories.

# something important to note is that the order in which you do things is important
# since a categories will get changed in the order you change them.