mol new chain.xyz autobonds no waitfor all

# set atom name/type and radius for all atoms
set sel [atomselect top all]
$sel set radius 0.85
$sel set name A
$sel set type A
$sel set mass 1.0
$sel set charge 0.0

# set atom name/type and radius for all atoms
set sel [atomselect top {index 0}]
$sel set radius 0.95
$sel set name B
$sel set type B
$sel set mass 1.0
$sel set charge 0.0

# bonds are computed based on distance criterion
# bond if 0.6 * (r_A + r_B) > r_AB.
# with radius 0.85 the cutoff is 1.02
# the example system has particles 1.0 apart.
mol bondsrecalc top

# now recompute bond types. 
# by default a string label: <atom type 1>-<atom type 2>
# we have all atoms of type A, so there should be only 
# one bond type, A-A
topo retypebonds 
vmdcon -info "assigned [topo numbondtypes] bond types to [topo numbonds] bonds:"
vmdcon -info "bondtypes: [topo bondtypenames]"


# now derive angle definitions from bond topology.
# every two bonds that share an atom yield an angle.
topo guessangles
vmdcon -info "assigned [topo numangletypes] angle types to [topo numangles] angles:"
vmdcon -info "angletypes: [topo angletypenames]"

# now let VMD reanalyze the molecular structure
# this is needed to detect fragments/molecules
# after we have recomputed the bonds
mol reanalyze top

# now set box dimensions and write out the result as 
# a lammps data file.
pbc set {100.0 100.0 100.0 90.0 90.0 90.0}
topo writelammpsdata data.trial full
animate write pdb chain.pdb

# done. now exit vmd
quit
