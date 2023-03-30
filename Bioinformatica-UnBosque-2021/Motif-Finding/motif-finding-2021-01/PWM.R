
## Load sequences as strings
sequences1 = c (
  "GAGGTAAAC",
  "TCCGTAAGT",
  "CAGGTTGGA",
  "ACAGTCAGT",
  "TAGGTCATT",
  "TAGGTACTG",
  "ATGGTAACT",
  "CAGGTATAC",
  "TGTGTGAGT",
  "AAGGTAAGT")

sequences2 = c(
  "CCCATTGTTCTC",
  "TTTCTGGTTCTC",
  "TCAATTGTTTAG",
  "CTCATTGTTGTC",
  "TCCATTGTTCTC",
  "CCTATTGTTCTC",
  "TCCATTGTTCGT",
  "CCAATTGTTTTG")
N = length (sequences)
sequences = sequences2
M = nchar (sequences [1])
cat ("NxM: ", N, M)

## Convert string sequences to matrix of bases
seqMatrix = matrix (unlist (strsplit (sequences, split="")),nrow=N,byrow = T)
print (seqMatrix)

###################################################
## Calcula la matrix de frecuencias (PFM)
###################################################
freqMatrix = NULL
for (j in 1:M) {
  nA = length(which (seqMatrix[,j]=="A"))
  nC = length(which (seqMatrix[,j]=="C"))
  nG = length(which (seqMatrix[,j]=="G"))
  nT = length(which (seqMatrix[,j]=="T"))
  nCol = c (nA, nC, nG, nT)
  freqMatrix = cbind (freqMatrix, nCol)
}
rownames (freqMatrix) = c ("A", "C", "G", "T")
colnames (freqMatrix) = paste0 ("p", 1:M)
freqMatrix = freqMatrix + 1
freqMatrix

########################################################
# Calcula la matrix de posición de probabilidades (PPM) 
########################################################
probMatrix = round (freqMatrix/(N+4), 2)
probMatrix
#########################################################
## Matrix de pesos ponderada por posicicón (PWM)
##########################################################
#bA=bC=bG=bT = 1/4
bA = bT = 0.32
bG = bC = 0.18

wA = log2 (probMatrix ["A",]/bA)
wC = log2 (probMatrix ["C",]/bC)
wG = log2 (probMatrix ["G",]/bG)
wT = log2 (probMatrix ["T",]/bT)
PWM = rbind (wA, wC, wG, wT)
PWM = round (PWM, 2)
print (PWM)

##########################################################
##########################################################

##########################################################
## Calculate the probability of a sequence S = "GAGGTAAAC"
##########################################################
S = "CCAATTGTTTTG"
seqS = unlist (strsplit (S,"",))
seqS
probabilidad = 1
for (j in 1:M) {
  jBase = seqS[j]
  probBase = probMatrix [jBase,j]
  probabilidad = probabilidad * probBase
}
print (probMatrix)
cat (seqS)
cat (probabilidad)

##########################################################
## Add pseudocounts to probability Matrix
##########################################################
pseudoMatrix = probMatrix + 1
pseudoMatrix

S = "GAGGTAAAC"
seqS = unlist (strsplit (S,"",))
seqS
probabilidad = 1
for (j in 1:M) {
  jBase = seqS[j]
  probBase = pseudoMatrix [jBase,j]
  probabilidad = probabilidad * probBase
}
print (pseudoMatrix)
cat (seqS)
cat (probabilidad)

#

