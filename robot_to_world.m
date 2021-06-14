function [x,y,z] = robot_to_world(theta_1,theta_2,theta_3,theta_4,theta_5,theta_6, angle_unit)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
if angle_unit == 'D'
    c1 = cosd(theta_1);
    s1 = sind(theta_1);
    c2 = cosd(theta_2);
    s2 = sind(theta_2);
    c3 = cosd(theta_3);
    s3 = sind(theta_3);
    c4 = cosd(theta_4);
    s4 = sind(theta_4);
    c5 = cosd(theta_5);
    s5 = sind(theta_5);
    c6 = cosd(theta_6);
    s6 = sind(theta_6);
else
    c1 = cos(theta_1);
    s1 = sin(theta_1);
    c2 = cos(theta_2);
    s2 = sin(theta_2);
    c3 = cos(theta_3);
    s3 = sin(theta_3);
    c4 = cos(theta_4);
    s4 = sin(theta_4);
    c5 = cos(theta_5);
    s5 = sin(theta_5);
    c6 = cos(theta_6);
    s6 = sin(theta_6);
end
A_1 = [	c1  ,   0	,   s1	,   0   ;
        s1  ,   0   ,   -c1	,   0   ;
        0   ,   1   ,   0	,   159 ;
        0   ,	0   ,   0	,	1   ];
A_2 = [	c2	,   -s2	,	0	,   264 * c2	;
        s2	,	c2	,	0	,	264 * s2 	;
        0   ,   0	,	1   ,   0           ;
        0   ,   0   ,   0   ,	1           ];
A_3 = [ c3  ,   0	,   -s3	,   0   ;
        s3  ,   0	,   c3	,   0   ;
        0   ,   -1	,   0   ,   0   ;
        0	,   0	,   0	,   1   ];
A_4 = [ c4  ,   0   ,   s4  ,   0   ;
        s4  ,   0   ,   -c4 ,   0   ;
        0   ,   1   ,   0   ,   258 ;
        0   ,   0   ,   0   ,   1   ];
A_5 = [	c5  ,   0   ,   s5  ,   0   ;
        s5  ,   0   ,   -c5	,   0   ;
        0   ,   1   ,   0   ,   0   ;
        0   ,   0   ,   0   ,   1   ];
A_6 = [	c6	,   -s6	,	0	,   0	;
        s6	,	c6	,	0	,	0   ;
        0   ,   0   ,	1   ,   123 ;
        0   ,   0   ,   0   ,	1	];
T1 = A_1;
T2 = A_1 * A_2;
T3 = A_1 * A_2 * A_3;
T4 = A_1 * A_2 * A_3 * A_4;
T5 = A_1 * A_2 * A_3 * A_4 * A_5;
T = A_1 * A_2 * A_3 * A_4 * A_5 * A_6;
V = [   0   0   0   1   ]';
R1 = T1 * V;
R2 = T2 * V;
R3 = T3 * V;
R4 = T4 * V;
R5 = T5 * V;
R = T * V;
x = R(1);
y = R(2);
z = R(3);
plot3([0 R1(1)],[0 R1(2)],[0 R1(3)]);
hold on;
grid on;
plot3([R1(1) R2(1)],[R1(2) R2(2)],[R1(3) R2(3)]);
plot3([R2(1) R3(1)],[R2(2) R3(2)],[R2(3) R3(3)]);
plot3([R3(1) R4(1)],[R3(2) R4(2)],[R3(3) R4(3)]);
plot3([R4(1) R5(1)],[R4(2) R5(2)],[R4(3) R5(3)]);
plot3([R5(1) R(1)],[R5(2) R(2)],[R5(3) R(3)]);

% plot3(x,y,z,'*');
end

