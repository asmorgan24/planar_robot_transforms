# Planar Robot Transformation Solver


<p align="center">
	<img src="/examples/robot_sav2.png" width="40%">
  <img src="/examples/robot_sav3.png" width="40%">
</p>
A (simple) robot kinematic solver for planar transformations and Jacobians of serial-link mechanisms (can easily be expanded to spatial representations if desired).  
<br/>  
<br/>
This repository is generally guided for those seeking to learn more about elementary serial-link kinematics and are looking for a simple simulation. This package assumes you are solving transformations for a robot with a single base link (unconstrained serial linkage). While running, this script with calculate the individual transformations from one linkage to another, in addition to the representation of the whole robot.  

## Usage
Run ```robotTransform.m``` in Matlab and define number of robot joints, link lengths of the robot, and joint configuration: 

```
NUM_JOINTS = 5;
link_vals = [3,4,2.5,1.1,1.4];
theta_vals = [pi/3,pi/4,-pi/4,pi/2,pi/4];  
```

## Output
The script will generate the symbolic transformation from the world to the end effector (T_O_E), the symbolic Jacobian of the mechanisms from the world to the end effector (Jacobian), the numeric version of T_O_E according to user inputs, the numberic version of the Jacobian according to user inputs, and the associated robot configuration as a PNG file. One can also find the individual transformations per frame in the ```T``` variable. 
