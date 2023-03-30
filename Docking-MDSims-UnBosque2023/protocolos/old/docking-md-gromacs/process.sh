grep JZ4 3HTB_clean.pdb > jz4.pdb
grep -v JZ4 3HTB_clean.pdb > protein.pdb

# Write the topology for the T4 lysozyme with pdb2gmx:
gmx pdb2gmx -f 3HTB_clean.pdb -o 3HTB_processed.gro
