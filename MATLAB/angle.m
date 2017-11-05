% The constant we need to know
% real constant
h = 1500; 

%x
width = 3000;

%y
length = 3000;

% software dimention
x_w = 100;
x_l = 0;

scale = width/x_w;

%output real time position 
x = 0;
y = 0;
real_time=[x,y];

%distance from real time position to center
center =[x_w/2,x_l/2];

center_to_real_time = [ x-x_w/2,  y-x_l/2 ]

scale_center_to_real_time = [ x-x_w/2,  y-x_l/2]* scale

tan_x_alpha = scale_center_to_real_time(1) / h

tan_y_alpha = scale_center_to_real_time(2) / h 

degree_x = atand(tan_x_alpha)
degree_y = atand(tan_y_alpha)


%l_center_to_real_time=norm(center_to_real_time)


%alpha_x = (x_w/2-x)/l_center_to_real_time

%alpha_y = (x_l/2-y)/l_center_to_real_time


%x_projection = l_center_to_real_time*alpha_x

%y_projection = l_center_to_real_time*alpha_y



























