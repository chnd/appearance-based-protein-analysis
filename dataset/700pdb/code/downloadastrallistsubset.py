#!/usr/bin/python
# This script is to download the pdf files based on the list of the scop id (sid) of the <= 40% astral dataset
import os, sys, getopt, re, urllib2;

def main(argv):
    onlyNotDownloaded = 1;
    f = open("astral20subsetClass.txt","r");
    for line in f:
        m = re.match('(d[a-z0-9_]{6})',line);
        if not(m is None):
            sid = m.groups(0)[0];
            if (onlyNotDownloaded == 1):
                filename="./astral20subset/" + sid + ".pdb";
                if (os.path.exists(filename)):
                    print("Skipped: "+sid);
                    continue;
            url = 'http://scop.berkeley.edu/astral/pdbstyle/ver=2.03&id=' + sid +'&output=html';
            u = urllib2.urlopen(url);
            fo = open("./astral20subset/" + sid + ".pdb","w");
            for uline in u:
                if (uline.strip() == ''):
                    continue;
                else:
                    m = re.match('<pre>|</pre>',uline);
                    if (m is None):
                        fo.write(uline);
            fo.close();
            u.close();
            print("Downloaded: "+ sid);
    f.close();

if __name__ == "__main__":
    main(sys.argv[1:])
    
