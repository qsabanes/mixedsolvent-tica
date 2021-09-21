#First step of the mdpocket analysis for the Cosolvent-TICA workflow
#This script should be run in a folder were all the snaps from the input trajectory have been extracted
#An example to run with gromacs would be the following:
# gmx trjconv -f traj.xtc -s protein.pdb -sep -o protein.pdb


#Quico Sabanes Zariquiey
#francesc.sabanes@kuleuven.be



# You will be working with the cluster*txt files generated in the R script. If you do not have them in the working folder, please do.
echo "Join snapshots into cluster/microstate trajs"
mkdir mdpocket
COUNT=$(ls cluster* | wc -l) #Count all the files with the name cluster
DIFF=$((COUNT-2)) #Since the previous script generates two other files named "cluster", substract two to obtain the correspondent number of clusters for the analysis
echo "The number of clusters is: $DIFF"
for i in $(seq 1 $DIFF)
	do
	#cluster.txt
	cat `cat cluster_$i.txt` > cluster$i.pdb 
	echo "1" > 1.txt
	gmx trjconv -f cluster$i.pdb -s protein1.pdb -o mdpocket/cluster$i.xtc -skip 10 < 1.txt #Join frames of every cluster to form a trajectory


	rm cluster$i.pdb
	done
rm cluster*
cp mdpocket_step2.sh mdpocket/ #copy next step of the script in the corresponding folder
cd mdpocket
echo "Proceed with second step, trjcat clusters into states"