#!/usr/bin/Rscript

# Load the GWASpoly library
library (GWASpoly)

# Read the arguments from command line
args = commandArgs(trailingOnly = TRUE)
genotypeFile  = args [1]
phenotypeFile = args [2]

# Read input genotype and genotype (format: "numeric" or "ACGT")
message ("\n>>> Reading data...")
data1 = read.GWASpoly (ploidy = 4, delim=",", format = "ACGT", n.traits = 1, 
                      pheno.file = phenotypeFile, geno.file = genotypeFile)

# Populations structure by kinship
message ("\n>>> Calculating kinship...")
data2 <- set.K (data1, K=NULL)

# Used to include population structure covariates
params <- set.params (n.PC=10)

# GWAS execution
message ("\n>>> Running GWASpoly...")
data3 = GWASpoly(data2, models=c("additive"),traits=c("tuber_shape"),n.core=4)

# Set significative threshold
data4 = set.threshold (data3, method="Bonferroni",level=0.05, n.core=4)

# QTL Detection
message ("\n>>> Getting quantitative trait loci")
significativeQTLs = get.QTL (data4)
write.csv (significativeQTLs, "out-table-QTLs.csv", quote=F, row.names=F)

# QQ-plot Output  and Manhattan plot Output
message ("\n >>> Ploting results...")

qq.plot(data3,trait="tuber_shape",model="additive")
manhattan.plot (data4, "tuber_shape", model="additive")



