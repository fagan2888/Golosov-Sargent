%function [mode, ImpCons, ImpConsJac, user] = ImplementabilityCons(mode, ncnln, n, ldcj, needc, z, x,s_,Para,ImpConsJac, nstate, user)
function [ImpCons,eq,ImpConsJac,eqGrad] = ImplementabilityCons(z, x,s_,Para)
g=Para.g;
psi=Para.psi;
pi=Para.pi;
beta=Para.beta;
sSize=Para.sSize;
eq=[];
eqGrad=[];
n=z(1:sSize);
xprime=z(sSize+1:end);
c=n-g;
R=1./(beta*(c).*sum(pi(s_,:).*(1./c)));  
u_c=1./c;
Euc=sum(pi(s_,:).*u_c);
ImpCons=x.*R+(1-psi)*(n./(1-n))-psi-xprime;
for s=1:sSize
    not_s=2/s;
OwnIc(s)= (x/(beta*c(s)^2*Euc))*( pi(s_,s)/(c(s)*Euc)-1);
OtherIC(s)=(pi(s_,s)*x/beta)*(1/(c(not_s)))*(1/c(s)^2)*(1/Euc^2);
end
ImpConsJac(:,1)=[(1-psi)./(1-n(1))^2+OwnIc(1) ;OtherIC(2); -1; 0];
ImpConsJac(:,2)=[OtherIC(1) ;(1-psi)./(1-n(2))^2+OwnIc(2) ; 0; -1];
ImpConsJac=ImpConsJac;
ImpCons=ImpCons;  
end