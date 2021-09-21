#Second of the mdpocket analysis for the Cosolvent-TICA workflow
#This script should be run in a folder were the data from the previous script was generated
#Furthermore, the user has to decide how does we want to divide the data between states relying on the k-means plot produced in the R script
# Based on that, we will join together the clusters obtained in previous script. In gromacs we will do the following.
# gmx trjcat -cat -f cluster1.xtc cluster2.xtc cluster 3.xtc -o state1.xtc
# If you name the output as "state.xtc" then the script will read how many states were created and run mdpocket based on that


#Quico Sabanes Zariquiey
#francesc.sabanes@kuleuven.be

COUNT=$(ls state* | wc -l)
for i in $(seq 1 $COUNT)
do
mkdir S$i
mv state$i.xtc S$i/
cd S$i
echo "Analyzing state$i"
mdpocket --trajectory_file *.xtc --trajectory_format xtc -f ../../protein1.pdb -S
cd ..
done
rm cluster*
echo "------Analysis complete-------"
echo "------Analysis complete-------"
rm mdpocket_step2.sh