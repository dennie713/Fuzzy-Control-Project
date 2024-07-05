function c_crisp = fuzzy1 ( e , de , tmp)
 
%------------------------- fuzzification ------------------------
membership_E = fi(e) ;
pme = membership_E(1,1) ;
pse = membership_E(2,1) ;
zee = membership_E(3,1) ;
nse = membership_E(4,1) ;
nme = membership_E(5,1) ;

 
membership_DE = fi(de) ;
pmde = membership_E(1,1) ;
psde = membership_E(2,1) ;
zede = membership_E(3,1) ;
nsde = membership_E(4,1) ;
nmde = membership_E(5,1) ;

 
%--------------------- decision making logic --------------------
membership_C = dml(membership_E,membership_DE) ;
pmc = membership_C(1,1) ;
psc = membership_C(2,1) ;
zec = membership_C(3,1) ;
nsc = membership_C(4,1) ;
nmc = membership_C(5,1) ;

 
%------------------------ defuzzification -----------------------
c = [1 ;  1/2 ; 0 ; -1/2 ; -1] ;
c_max = tmp;
pT = pmc + psc + zec + nsc + nmc ;
c_crisp = c_max * ( pmc * c(1) + psc * c(2) + zec * c(3) + nsc * c(4) + nmc * c(5) ) / pT ;
