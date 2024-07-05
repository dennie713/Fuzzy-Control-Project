function membership_C = dml(membership_E,membership_DE)
for i = 1:5
    for j = 1:5
        Table(i,j) = min([membership_E(i,1) membership_DE(j,1)]);
    end
end
%PB = [Table(1,1) Table(1,2) Table(2,1) ];
PM = [Table(1,1) Table(1,2) Table(1,3) Table(2,1) Table(2,2) Table(3,1) ];
PS = [Table(1,4) Table(2,3) Table(3,2) Table(4,1) ];
ZE = [Table(1,5) Table(2,4) Table(3,3) Table(4,2) Table(5,1) ];
NS = [Table(2,5) Table(3,4) Table(4,3) Table(5,2) ];
NM = [Table(3,5) Table(4,4) Table(4,5) Table(5,3) Table(5,4) Table(5,5) ];
%NB = [Table(4,5) Table(5,4) Table(5,5) ];
membership_C(1,1) = max(PM);
membership_C(2,1) = max(PS);
membership_C(3,1) = max(ZE);
membership_C(4,1) = max(NS);
membership_C(5,1) = max(NM);
% membership_C(6,1) = max(NM);
% membership_C(7,1) = max(NB);
end