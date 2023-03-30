#!/usr/bin/python3

import sys

def get_line(txt):
    file = open('topol.top', encoding='utf8')
    for line_num, value in enumerate(file, 1): 
        if txt in value:                       
            return line_num


        
if len(sys.argv) < 2:
    print('ERROR: put lig name without extension')

elif len(sys.argv) > 2:
    print('ERROR: put only lig name without extension')

else:
    
    lig = sys.argv[1]

    # LG:
    #x = str('#include "./charmm36-mar2019.ff/forcefield.itp"')
    x = str('#include "amber96.ff/forcefield.itp"')
    y = str('; Include Position restraint file')
    z = str('Protein_chain_A     1')

    file = open('topol.top', 'r+', encoding='utf8')
    line = file.readlines()
    line.insert(get_line(x),f'\n; Include ligand parameters\n#include "{lig}.prm"\n')
    file.seek(0)
    file.writelines(line)

    file = open('topol.top', 'r+', encoding='utf8')
    line = file.readlines()
    line.insert(get_line(y)+ 4,f'; Include ligand topology\n#include "{lig}.itp"\n\n')
    file.seek(0)
    file.writelines(line)

    file = open('topol.top', 'r+', encoding='utf8')
    line = file.readlines()
    line.insert(get_line(z),f'\n{lig}                 1')
    file.seek(0)
    file.writelines(line)
