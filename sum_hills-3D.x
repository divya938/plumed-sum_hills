# Check max along RG reaction and change the RG max

bin_width1=0.01
bin_width2=0.01
bin_width3=0.01
Temp=298.15

KT=`plumed kt --temp ${Temp} | awk '{print $11}'`

CV1_min=`awk 'BEGIN{min=999990.}{if($1!="#!" && $2<min)min=$2}END{print min}' ./COLVAR`
CV1_max=`awk 'BEGIN{max=-999990.}{if($1!="#!" && $2>max)max=$2}END{print max}' ./COLVAR`

CV2_min=`awk 'BEGIN{min=999990.}{if($1!="#!" && $3<min)min=$3}END{print min}' ./COLVAR`
CV2_max=`awk 'BEGIN{max=-999990.}{if($1!="#!" && $3>max)max=$3}END{print max}' ./COLVAR`


CV3_min=`awk 'BEGIN{min=999990.}{if($1!="#!" && $4<min)min=$4}END{print min}' ./COLVAR`
CV3_max=`awk 'BEGIN{max=-999990.}{if($1!="#!" && $4>max)max=$4}END{print max}' ./COLVAR`

bins1=`python -c "import math;  print (int(math.ceil((${CV1_max}-${CV1_min})/${bin_width1})))"`
bins2=`python -c "import math;  print (int(math.ceil((${CV2_max}-${CV2_min})/${bin_width2})))"`
bins3=`python -c "import math;  print (int(math.ceil((${CV3_max}-${CV3_min})/${bin_width3})))"`


plumed sum_hills --hills HILLS --kt ${KT} --outfile 3D-RG-Inter-Intra-C6.25ns --mintozero  --stride 15000 --min ${CV1_min},${CV2_min},${CV3_min} --max ${CV1_max},${CV2_max},${CV3_max} --bin  ${bins1},${bins2},${bins3}
