BEGIN {

	start_time=0;
	finish_time=0;
	flag=0;
	flag1=0;
	f_size=0;
	throughput=0;
	latency=0;
	pdr=0;
	total_delay=0;
        rec=0;
        dep=0;
       enq=0;
       time1=0;
        total=0;
       deque=0;
        bh=0;
      }

{
	       
        event = $1 	
        time = $2 	
        node = $3	
	level = $4 	 
	pkt = $6 	
	traffic = $7 	 
        pktsize = $8	
	 start_time1[$11]
	finish_time1[$11]
	delay1[$11]
		  	
		
	

if (event == "r")
{

rec++

}	
else if (event == "d")
{
dep++

}
else if (event == "+")
{

enq++

}
else if (event == "-")

{
deque++

}
else{

bh++
}


if (event == "r" && level == 1)
{

f_size=f_size+pkt
if(flag == 0)
{
start_time=time
flag=1
}
finish_time=time
}


if (event == "r" || event == "d")
{
if(flag1 == 0)
{
start_time1[$11]=time
flag1=1
}
finish_time1[$11]=time
delay1[$11]=finish_time1[$11]-start_time1[$11]
total_delay=total_delay+delay1[$11]
}





}

END {
total = dep + rec + enq + deque;
latency=finish_time - start_time
throughput=(f_size * 8)/latency
pdr=(rec/(rec+dep))*100
packet_loss=((rec+dep)-rec)*100
average_delay=total_delay/(rec+dep)
printf ("\ntotal=%d\n",total);
printf ("\ndropd=%d\n",dep);
printf ("\nrecvied=%d\n",rec);
printf ("\n Enque =%d\n",enq);
printf ("\n deque =%d\n",deque);
printf ("\n Total delay = %f\n",total_delay);
printf ("\n Average delay = %f\n",average_delay);
printf ("\n packet loss ratio =%d%\n",packet_loss);
printf ("\n PDR =%.2f%\n",pdr);
printf ("\n Throughput =%f\n",throughput);
printf ("\n latency =%fms\n",latency);
printf ("\npacket size ($6)=%d\n",pkt);
printf ("\nTotal Time =%0.4fms\n",time);

printf ("\n size($8) = %d\n",pktsize);

}
