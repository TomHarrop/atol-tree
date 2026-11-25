#!/usr/bin/env Rscript

library(ggtree)

# Plot config
textwidth <- 382
phi <- 0.5 * (sqrt(5) + 1)
mm_width <- grid::convertUnit(grid::unit(textwidth, "pt"), "mm", valueOnly = TRUE)
mm_height <- mm_width / phi

slide_width <- 254
slide_height <- 142.9

font_family <- "Atkinson Hyperlegible"
font_size <- 8

x <- treeio::read.newick("tree.nwk", node.label = "label")
# x$edge.length <- 1
x$node.label <- gsub("[^[:alpha:]]", "", x$node.label)
x$node.label[nchar(x$node.label) == 0] <- NA
x$tip.label <- gsub("'", "", x$tip.label, fixed = TRUE)

clade_offset <- 3
cp <- viridisLite::viridis(7)

p <- ggtree(x) +
  geom_tree() +
  ggplot2::theme_void(base_family = "Lato", base_size = font_size) +
  geom_tiplab(fontface = 3, family = font_family, size = 3) +
  geom_cladelabel(node = 72, label = "Bony fish", color = cp[[1]], offset = clade_offset, align = TRUE) +
  geom_cladelabel(node = 67, label = "Birds", color = cp[[2]], offset = clade_offset, align = TRUE) +
  geom_cladelabel(node = 66, label = "Reptiles", color = cp[[3]], offset = clade_offset, align = TRUE) +
  geom_cladelabel(node = 71, label = "Amphibians", color = cp[[4]], offset = clade_offset, align = TRUE) +
  geom_cladelabel(node = 56, label = "Insects", color = cp[[5]], offset = clade_offset, align = TRUE) +
  geom_cladelabel(node = 54, label = "Molluscs", color = cp[[6]], offset = clade_offset, align = TRUE) +
  geom_cladelabel(node = 84, label = "Plants", color = cp[[7]], offset = clade_offset, align = TRUE)


# p + xlim(0, 30) + geom_text(aes(label = node))

ggsave("tree.png",
  p + xlim(0, 15),
  width = slide_width,
  height = slide_height,
  units = "mm",
  device = cairo_pdf
)

