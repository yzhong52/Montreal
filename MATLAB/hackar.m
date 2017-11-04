% Vx Vy are the component of initial Velocities 
Vx0 = 1;
Vy0 = 1;

%fixed Ion position
Ion_position_x0 = 10;
Ion_position_y0 = 10;
%Initio electron position;
e_position_x0 = 0;
e_position_y0 = 0;

%force F = k*q1*q2/r^2
q1 = 1;
q2 = 1;
k =1;
%electron mass
m = 1;

%constant delta t
t = 1/30;

x_axis = [1,0];
y_axis = [0,1];

% start calculation ---------------------------------------------
V0 = 5;
Initial_alpha = pi/4
V0x = V0*cos(Initial_alpha )
V0y = V0*sin(Initial_alpha)

%Velocity_initial = [Vx0,Vy0];

%cosalpha_V_x =  Velocity_initial*Vx'/norm(Velocity_initial)/norm(Vx)
%cosalpha_V_y = Velocity_initial*Vy'/norm(Velocity_initial)/norm(Vy)

r0_Vector = [Ion_position_x0,Ion_position_y0] - [e_position_x0,e_position_y0];
r0 = norm(r0_Vector)

cosalpha_r_x_0 =  r0_Vector*Vx'/norm(r0_Vector)/norm(Vx)
cosalpha_r_y_0 = r0_Vector*Vy'/norm(r0_Vector)/norm(Vy)

F0 = k*q1*q2/r0^2
F0x = F0*cosalpha_r_x_0
F0y = F0*cosalpha_r_y_0

a0x = F0x/m
a0y = F0y/m
    % first moVement
x1 = e_position_x0 + V0x*t + 0.5*a0x*t.^2 
y1 = e_position_y0 + V0x*t + 0.5*a0y*t.^2

%--------second point;
%updats of Velocity
V1x = V0x + a0x*t;
V1y = V0y + a0y*t;

r1_Vector = [Ion_position_x0,Ion_position_y0] - [x1,y1];
r1 = norm(r1_Vector);
cosalpha_r_x_1 =  r1_Vector*Vx'/norm(r0_Vector)/norm(Vx)
cosalpha_r_y_1 = r1_Vector*Vy'/norm(r0_Vector)/norm(Vy)

F1 = k*q1*q2/r1^2
F1x = F1*cosalpha_r_x_1
F1y = F1*cosalpha_r_y_1

a1x = F1x/m
a1y = F1y/m

    % second moVement
x2 = x1 + V1x*t + 0.5*a1x*t.^2 
y2 = y1 + V1y*t + 0.5*a1y*t.^2

%--------third point ---

plot(x1,y1,'o',x2,y2,'o')




