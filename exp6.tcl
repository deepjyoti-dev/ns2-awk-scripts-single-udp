set ns [new Simulator]

set f [open exp6.tr w]

$ns trace-all $f

set nf [open 1exp6.nam w]

$ns namtrace-all $nf

 

proc finish {} {

global ns nf f

$ns flush-trace

close $nf

close $f

exec nam 1exp6.nam &
#awk for delay
exec awk -f delay.awk exp6.tr > Delay.tr &
exec awk -f thruput.awk exp6.tr > thruput.tr &

exit 0

}



#Create two nodes
set n0 [$ns node]
set n1 [$ns node]



#Create links between the nodes
$ns duplex-link $n0 $n1 2Mb 10ms DropTail

#Setup a UDP connection between nodes n0 and n1
set udp [new Agent/UDP]
$ns attach-agent $n0 $udp
set cbr [new Application/Traffic/CBR]
$cbr attach-agent $udp
$udp set class_ 1
$udp set segmentSize- 1500
set null0 [new Agent/Null]
$ns attach-agent $n1 $null0
$ns connect $udp $null0



#schedule events for the ftp  agents
$ns at 2.0 "$cbr start"
$ns at 8.0 "$cbr stop"

#Call the finish procedure after 5 seconds of simulation time
$ns at 10.0 "finish"


#Run the simulation
$ns run

































