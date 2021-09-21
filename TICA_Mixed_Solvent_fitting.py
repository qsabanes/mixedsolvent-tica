#!/usr/bin/python    

import os
import mdtraj
files = [i for i in os.listdir("A_WORKING_DIRECTORY") if i.endswith("xtc")]
pdb = mdtraj.load_pdb('PATH_TO_YOUR_REFERENCE_STRUCTURE')
for file in files:
	traj = mdtraj.load(file, top=pdb)
	traj.superpose(pdb)
	traj_fit_temp = file
	traj.save(file)

