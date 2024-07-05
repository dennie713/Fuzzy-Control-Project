clc ; clear ; close all ;
%--------- user adjustable parameter 
A = 3 ;% select mode
dt = 0.01 ; tf = 10 ;
%------------------------------
if A == 1
    x0 = [ 1 0 0.0564 0 ] ; %max =  1.5
elseif A == 2
    x0 = [ 2 0 0.1129 0 ] ; %max =  1.5
elseif A == 3
    x0 = [ 3 0 0.1698 0 ] ; %max =  1.5
end


T = 0 : dt : tf ;
u2 = 0 ; %torque
iter = tf / dt ;

%------------------------ tracking contour-------------------------
i = 0;
 for t1 = 0 : dt: tf
     i = i+1;
     yd(i) = ( A * cos( pi*t1 / 5 ) );
 end
 yd = yd';
%------------------------ fuzzy control -------------------------
t = (0:dt:dt)' ;
for i = 1 : iter
    G = 9.81 ;
    B = rand * ( 0.8 - 0.6 ) + 0.6 ;
    
    dx=@(t,x) [ x(2) ; B * ( x(1) * x(4)^2 - G * sin(x(3)) ) ; x(4) ; u2 ];
    [tt,x]=ode45(dx,t,x0) ;
    [xr,xc]=size(x) ;
 
    x0 = x(xr,:) ;
 
    Y(i,1) = x(xr,1) ;
    e1 = Y(i) - yd(i); 
    if i == 1
        e12 = Y(1) - yd(1);
    else
        e12 = Y(i-1) - yd(i-1);
   end
    de1 = (e1-e12)/dt;
    u1(i,1) = fuzzy1 (e1,de1,1.5) ;
    
    
    Theta(i,1) = x(xr,3) ;
    e2 = u1(i,1) - Theta(i,1);
    if i == 1
        e22 = u1(i,1) - Theta(i,1);
    else
        e22 = u1(i-1,1) - Theta(i-1,1);
   end
    de2 = (e2-e22)/dt;
    u2 = fuzzy1 (e2,de2,20) ;
    
    U(i,1) = u2;
   
    
end

for i = 1:iter
    error(i) = Y(i) - yd(i);
end 

figure(1)
t1 = dt:dt:tf;
t2 = 0:dt:tf;
plot(t1,Y);
hold on;
plot(t2,yd);
title('tracking')
ylabel('y(t)')
xlabel('time')
legend('y','y desire');

figure(2)
plot(t1,error);
title('tracking error')
ylabel('error')
xlabel('time')
figure(3)
plot(t1,U);
title('Torque')
ylabel('u(t)')
xlabel('time')

