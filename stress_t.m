function [D3]=stress_t(FNAM,L1,M1,Z1,C1,Tdisc1,damhmsl1,SC1,Xobs1,Yobs1)
            L=L1;
            M=M1;
            Z=Z1;
            C=C1;
            Tdisc=Tdisc1;
            DAMHMSL=damhmsl1;
            SC=SC1;           
            Xobs=Xobs1;
            Yobs=Yobs1;
%             Xdisc=Xdisc1;
%             Ydisc=Ydisc1;
[D] = import_data_File(FNAM);
N=D.V1(1,1); 
%L=D.V2(1,1); 
%M=D.V3(1,1); 
MM=D.V1(2,1); 
%Z=D.V2(2,1); 
%C=D.V3(2,1); 
C1=D.V2(2:2,1);
PR=0.25;
PK=D.V3(3:MM+2,1);
for i=1:N
    X0(i)=D.V2(MM+2+i);
    Y0(i)=D.V3(MM+2+i);
    XX1(i,1)=D.V4(MM+2+i);
    YY1(i,1)=D.V5(MM+2+i);
    PF(i)=D.V6(MM+2+i);
	X1(i,1)=XX1(i,1)+Xobs;
	Y1(i,1)=YY1(i,1)+Yobs;
end
%{
for I=1:N
            for j=2:L
                X1(I,j)=X1(I,j-1)+Xdisc;
            end
            for k=2:M
                Y1(I,k)=Y1(I,k-1)+Ydisc;
            end
end
%}
for i=1:MM
            P(i)=(PK(i)-DAMHMSL);
end
for i=1:MM
        for j=1:N
            PPP=PF(1)-P(i);
               PPI(i,j)=PF(j)-PPP;
                if(PPI(i,j)<0.0)  
                  PPI(i,j)=0.0;
                end
        end
end


for II=2:MM

for J=1:1 
for K=1:1
	sigax=0.0;
	sigay=0.0;
	sigaz=0.0;
	tayaxy=0.0;
	tayayz=0.0;
	tayazx=0.0;
for I=1:N 
	AYHR=0.0;
	X=(X1(I,J)*cos(AYHR))+(Y1(I,K)*sin(AYHR));
	Y=(Y1(I,K)*cos(AYHR))-(X1(I,J)*sin(AYHR));
	PPF=PPI(II,I);
% 	[sigx,sigy,sigz,tayxy,tayyz,tayzx]=PLS(X0(I),Y0(I),PPF,Z,X,Y);
     [sigx1,sigy1,sigz1,tayxy1,tayyz1,tayzx1]=add1(PPF,X0(I),Y0(I),X,Y,Z);
  
	sigax=sigax+sigx1;
    sigay=sigay+sigy1;
	sigaz=sigaz+sigz1;
	tayaxy=tayaxy+tayxy1;
	tayayz=tayayz+tayyz1;
	tayazx=tayazx+tayzx1;  
end
     

if (II==2&&J==1&&K==1)
	D3=[sigax sigay sigaz tayaxy tayayz tayazx];
else
    D3=[D3
        sigax sigay sigaz tayaxy tayayz tayazx];
   
  
end
end
end
end
writematrix(D3,'stress_result_t.dat');
end

function [sigx1,sigy1,sigz1,tayxy1,tayyz1,tayzx1]=add1(p,X1,Y1,X0,Y0,Z)
	
    AN=1-(2*0.25);
	PRE=p/(2*pi);
	X=X0;
	Y=Y0;
	R=sqrt((X^2)+(Y^2)+(Z^2));
	A=(3*(X^2)*Z)/(R^5);
	B=((Y^2)+(Z^2))/((R^3)*(Z+R));
	C=(Z/(R^3))+((X^2)/((R^2)*((Z+R)^2)));
	SIGX=PRE*(A+(AN*(B-C)));
	D=(3*(Y^2)*Z)/(R^5);
	E=((X^2)+(Z^2))/((R^3)*(Z+R));
	F=(Z/(R^3))+((Y^2)/((R^2)*((Z+R)^2)));
	SIGY=PRE*(D+(AN*(E-F)));
	SIGZ=PRE*(3*(Z^3))/(R^5);
	TAYYZ=PRE*(3*Y*(Z^2))/(R^5);
	TAYZX=PRE*(3*X*(Z^2))/(R^5);
	G=(3*X*Y*Z)/(R^5);
	H=(X*Y*(Z+2*R))/((R^3)*((Z+R)^2));
	TAYXY=PRE*(G-(AN*H));
    
         sigx1=SIGX*X1*Y1;
         sigy1=SIGY*X1*Y1;
         sigz1=SIGZ*X1*Y1;
         tayzx1=TAYZX*X1*Y1;      
         tayxy1=TAYXY*X1*Y1;  
         tayyz1=TAYYZ*X1*Y1;

end

function D = import_data_File(filename, dataLines)
if nargin < 2
    dataLines = [1, Inf];
end
opts = delimitedTextImportOptions("NumVariables", 5);
opts.DataLines = dataLines;
opts.Delimiter = ",";
opts.VariableNames = ["V1", "V2", "V3", "V4","V5","V6"];
opts.VariableTypes = ["double", "double", "double", "double","double","double"];
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
opts = setvaropts(opts, "V4", "TrimNonNumeric", true);
opts = setvaropts(opts, "V4", "ThousandsSeparator", ",");
opts = setvaropts(opts, "V5", "TrimNonNumeric", true);
opts = setvaropts(opts, "V5", "ThousandsSeparator", ",");
D = readtable(filename, opts);
end