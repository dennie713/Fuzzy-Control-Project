function membership = fi(u)
%Define the range of the fuzzy sets
up1 = 1/2; un1 = -1/2;
% Initialize the membership function
pmu = 0; psu = 0; zeu = 0;
nmu = 0; nsu = 0;
%% fuzzification
if     u >= 1, pmu = 1;
elseif u>=up1, pmu = (u-up1)/(1-up1);    psu = (1-u)/(1-up1);
elseif u>= 0 , psu = u/up1;              zeu = 1-u/up1;
elseif u>=un1, zeu = (un1-u)/un1;        nsu = u/un1;
elseif u>= -1, nsu = (1+u)/(1+un1);      nmu = (un1-u)/(1+un1);
else nmu = 1;
end
%%Assign outputvector
membership(:,1) = [pmu psu zeu nsu nmu ]';
end