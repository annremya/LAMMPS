# load trajectory into vmd and run
set  sel [atomselect top all]
set outf [open "$step1a.dat" w]
set n [molinfo top get numframes]
for {set i 1} {$i <= $n} {incr i} {
	molinfo top set frame $i
	set radgyr [measure rgyr $sel]
	puts $outf "$radgyr"
}
close $outf
puts "Done."
