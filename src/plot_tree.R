library(ggtree)

x <- treeio::read.newick("tree.nwk", node.label = "label")
x$edge


ggtree(x) + geom_tree() + theme_tree() + geom_tiplab() + geom_nodelab()
