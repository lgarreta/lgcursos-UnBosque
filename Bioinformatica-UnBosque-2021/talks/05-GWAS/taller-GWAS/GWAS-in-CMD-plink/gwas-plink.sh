geno="plink-genotype"
pheno="plink-phenotype.csv"


CMM="plink --file $geno --make-bed --out $geno-bin"
echo -e "\n>>> " $CMM "\n"
eval $CMM

CMM="plink --bfile $geno-bin  --linear --assoc --adjust --all-pheno --pheno $pheno --allow-no-sex --out $geno"
echo -e "\n>>> " $CMM "\n"
eval $CMM

