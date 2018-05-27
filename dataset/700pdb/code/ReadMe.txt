The following procedures were used when generating the dataset:
(1) Download list of proteins with 20% sequence similarities from SCOP database:
Result file: scopeseq-2.03-astral-scopedom-seqres-gd-sel-gs-bib-20-2.03.fa

(2) Take 100 proteins for each class:
Python code to parse the result file: parseastrallist.py
Matlab code to only take 100 proteins for each class: astral20subsetCreate.m

(3) Download the PDB for each 100 proteins
Python code: downloadastrallistsubset.py
