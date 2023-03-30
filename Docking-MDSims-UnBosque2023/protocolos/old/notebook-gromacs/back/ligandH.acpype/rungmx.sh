
echo 0 | gmx editconf -f ligandH_GMX.gro -bt octahedron -d 1 -c -princ
gmx grompp -f em.mdp -c out.gro -p ligandH_GMX.top -o em.tpr -v
gmx mdrun -ntmpi 1 -v -deffnm em
gmx grompp -f md.mdp -c em.gro -p ligandH_GMX.top -o md.tpr -r em.gro
gmx mdrun -ntmpi 1 -v -deffnm md
