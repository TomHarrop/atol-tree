#!/usr/bin/env python3

from pathlib import Path
from ete4 import NCBITaxa, PhyloTree

taxid_list_file = Path("data", "taxids.txt")

# cache the taxonomy
ncbi = NCBITaxa()

# only needed once
# ncbi.update_taxonomy_database()


with open(taxid_list_file, "rt") as f:
    taxid_list = sorted(set(x.strip() for x in f.readlines()))

tree = ncbi.get_topology(taxid_list, intermediate_nodes=False)
print(tree.to_str(props=["sci_name"]))

for node in tree.traverse():
    node.name = node.get_prop("sci_name")

tree.write("tree.nwk")