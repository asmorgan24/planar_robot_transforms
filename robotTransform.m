clc
clear all
close all

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Declare variables of your mechanism, either symbolic or numerical
% Symbolic example >> syms l1 l2 ...
%                     syms theta1 theta2 ...
% Numeric example >> l1 = 2, l2 =3, ...
%
% Then place each of them in their corresponding vectors in the
% order they are connected to each other
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Change these three lines -----------
NUM_JOINTS = 3;
link_vals = [3,4,2.5,1.1];
theta_vals = [pi/3,pi/4,-pi/4];  
% -------------------------------

length_vars = sym('l',[1,NUM_JOINTS]);  
theta_vars = sym('q', [1,NUM_JOINTS]); 
symb_vars = [length_vars, theta_vars];
assert (length(length_vars) == length(theta_vars))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculate the transformations from the base link at the origin (O) 
% up to the end effector (E) to develop the transform from O to E (T_O_E)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
T = {}; %homogenous transformations per frame
T_O_ = {}; %compounded transformation from origin to associated frame
for i=1:1:length(theta_vars)
    T{i} = transformation(length_vars(i),theta_vars(i));
    if i ==1
        T_O_{1} = T{i};
    else
        T_O_{i} = T_O_{i-1}*T{i};
    end
end

T_O_E = simplify(T_O_{length(T_O_)}) %Transformation from origin to eef

    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculate the symbolic Jacobian of the mechanism wrt the eef
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Jacobian = [];
for i=1:1:length(T)
    tmp = diff(T_O_E,theta_vars(i));
    Jacobian=[Jacobian,[tmp(1,3);tmp(2,3)]];
end

Jacobian = simplify(Jacobian) %Robot Jacobian



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Finally, plug in the values for each and see the eef pose
% and Jacobian, then plot
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


in_vals = [link_vals, theta_vals];
assert(length(symb_vars)==length(in_vals))

T_O_E_eval = double(subs(T_O_E, symb_vars, in_vals))
Jacobian_eval = double(subs(Jacobian, symb_vars, in_vals))

draw_robot(symb_vars, in_vals, T_O_)
save_fig('examples/robot_sav',300)




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Helper function, defining the homogeneous transformation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function T = transformation(a,theta)
T = [cos(theta), -sin(theta), a*cos(theta);
     sin(theta),  cos(theta), a*sin(theta);
     0,             0,         1];
end


