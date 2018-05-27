#!/usr/bin/python
# This script is to collect the list of the scop id (sid) of the <= 20% astral dataset
import os, sys, getopt, re;

def main(argv):
    f = open("scopeseq-2.03-astral-scopedom-seqres-gd-sel-gs-bib-20-2.03.fa","r");
    f2 = open("astral20.txt","w");
    for line in f:
        m = re.match('(^>)(d[a-z0-9_\.]{6}) ([a-z])\.([0-9]+)\.([0-9]+)\.([0-9]+) (\([^\s]+\))',line);
        if not(m is None):
            tmp = m.groups(0)[1] + ';' + m.groups(0)[2] + ';' + m.groups(0)[3] + ';' + m.groups(0)[4] + ';' + m.groups(0)[5] + ';' + m.groups(0)[6];
            f2.write("%s\n" % tmp);
    f.close();
    f2.close();

if __name__ == "__main__":
    main(sys.argv[1:])
    
