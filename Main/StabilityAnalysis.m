
 clc
 clear all
 close all
 SetPath

 %{ 
This file solves the G-S economy with BGP preferences of the form
 psi.c^(1-sigma)/1-sigma+(1-psi)log[1-l] with following calibrations

1.] The ratio of productivities is 3.3 and the low productivity is
 normalized to 1
2.] psi is choosen to get a average FE of about 0.5
3.] pareto wts are such that the no-shock problem gives a tax rate of about
    20 percent
4.] Government expenditures are about 11 and 13 percent of the output
5.] beta =0.9
%}

% - XXXXXXX ANMOL - CURRENTLY IT USES A LEGACY METHOD FOR GETTING THE
% BASELINE PARAMETERS. NOW THAT WE HAVE A STEADY STATE CODE WE CAN USE THIS
% TO TARGET SOME AGREED MOMENTS IN OBSERVABLES 
SetParaStruc
theta_1=3.3; % theta high
theta_2=1;  % theta low
g_l_y=.11; % g low
g_h_y=.13; % g high
n1=1;  
n2=1;
tau=.2;
g_Y=mean([g_l_y g_h_y]);
AvfFETarget=.5;
z=fsolve(@(z) GetCalibrationFrischElasticity (z,AvfFETarget,theta_1,theta_2,tau,g_Y,n1,n2), [1 1 ]);
gamma=z(1);
Y=z(2);


% BASELINE GOVERNMENT EXPENDITURE LEVELS
g=g_Y*Y;

% BASELINE PSI
psi=1/(1+gamma);
% BASELINE DISCOUNT FACTOR

beta=.9;

% BASELINE PARETO WTS
alpha_1=0.69;
alpha_2=1-alpha_1;
Para.n1=n1;
Para.n2=n2;
alpha_1=alpha_1*Para.n1;
alpha_2=alpha_2*Para.n2;

% BASELINE PROBABILITY MATRIX
NewPh=.5;
Para.P=[1-NewPh NewPh;1-NewPh NewPh];

% POPULATE THE PARA STRUC WITH THE BASELINE VALUES
Para.beta=.9;
Para.alpha_1=alpha_1;
Para.alpha_2=alpha_2;
Para.psi=psi;
Para.g=[g_l_y g_h_y]*Y;
Para.theta_1=theta_1;
Para.theta_2=theta_2;
Para.btild_1=0;
Para.alpha_1=alpha_1;
Para.alpha_2=alpha_2;
Para.datapath=[rootDir sl 'Data/temp/'];
mkdir(Para.datapath)
casename='sigma';
Para.StoreFileName=['c' casename '.mat'];
CoeffFileName=[Para.datapath Para.StoreFileName];


gridSize=10;
alphaMin=.2;
alphaMax=.8;

theta1Min=2;
theta1Max=5;

%psiMin=.3;
%psiMax=.4;

sigmaMin=.5;
sigmaMax=2;

gammaMin=.5;
gammaMax=2;


gh_gl_min=1;
gh_gl_max=2;
gh_gl_grid=linspace(gh_gl_min,gh_gl_max,gridSize);

Para.gamma=2;
alphaGrid=linspace(alphaMin,alphaMax,gridSize);
theta1Grid=linspace(theta1Min,theta1Max,gridSize);
%psiGrid=linspace(psiMin,psiMax,gridSize);
sigmaGrid=linspace(sigmaMin,sigmaMax,gridSize);
gammaGrid=linspace(gammaMin,gammaMax,gridSize);
Para.U = @(c,l) UCRRA(c,l,Para);
%ParamGrid=cartprod(alphaGrid,theta1Grid,psiGrid);
ParamGrid=cartprod(alphaGrid,theta1Grid,sigmaGrid,gammaGrid,gh_gl_grid);
ParamGrid=gh_gl_grid;
for i=1:length(ParamGrid)
    tic
    %Para.alpha_1=ParamGrid(i,1);
    %Para.alpha_2=1-ParamGrid(i,1);
    %Para.theta_1=ParamGrid(i,2);
    %Para.psi=ParamGrid(i,3);
    Para.g(2)=Para.g(1)*gh_gl_grid(i);
    %Para.sigma=ParamGrid(i,3);
    %Para.gamma=ParamGrid(i,4);
    Para.U = @(c,l) UCRRA(c,l,Para);
    [ x,R,PolicyRule ] = findSteadyState( 0,3,Para);
    %[ A XSS, B, BS ] = LinearApproximation( Para);
    PolicyRules(i,:)=PolicyRule;
    X(i)=x;
    RR(i)=R;
    %StabTest(i,:)=eigs(BS-eye(4))';
    toc
end
