function [PP]=ppdiffusion_t(FNAM,L1,M1,Z1,C1,Tdisc1,damhmsl1,SC1,Xobs1,Yobs1)
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

	rad=pi/180;
    [D] = import_data_File(FNAM);
    N=D.V1(1,1); 
    %L=D.V2(1,1); 
    %M=D.V3(1,1); 
    MM=D.V1(2,1); 
    %Z=D.V2(2,1); 
    %C=D.V3(2,1); 
    C1=D.V2(2:2,1);
PR=0.25;
PK(:,1)=D.V3(3:MM+2,1);
Tm(:,1)=D.V2(3:MM+2,1);
date(:,1)=D.V1(3:MM+2,1);
%Xobs=-5420;
%Yobs=-2738;
for i=1:N
    X1(i)=D.V2(MM+2+i);
    Y1(i)=D.V3(MM+2+i);
    XX0(i,1)=D.V4(MM+2+i);
    YY0(i,1)=D.V5(MM+2+i);
    PF(i)=D.V6(MM+2+i);
	X01(i,1)=XX0(i,1)+Xobs;
	Y01(i,1)=YY0(i,1)+Yobs;
end
%{
for i=1:N
            for j=2:L
                X01(i,j)=X01(i,j-1)+Xdisc;
            end
            for k=2:M
                Y01(i,k)=Y01(i,k-1)+Ydisc;
            end
end
%}
for i=1:MM
            P(i)=(PK(i)-DAMHMSL);
end
	TDISC=Tdisc;
	TL(1)=0.0;
for i=2:MM
        TL(i)=TL(i-1)+TDISC;
end
for i=1:MM
	Tm(i)=TL(i)*C1;
end
for i=1:MM 
	for j=1:N 
	PP=PF(1)-P(i);
	PI(i,j)=PF(j)-PP;
	if (PI(i,j)<0) 
        PI(i,j)=0.0; 
    end
    end
end
for j=1:1
    for k=1:1
      
	    for II=2:MM
            SIMA=0.0;
             for i=1:N
                  for jj=1:MM
                     P1(jj)=PI(jj,i);
                  end
                ayhr=0.0;
	            X00=(X01(i,j)*cos(ayhr))+(Y01(i,k)*sin(ayhr));
	            Y00=(Y01(i,k)*cos(ayhr))-(X01(i,j)*sin(ayhr));
	            X0=X00;
	            Y0=Y00;
	            X=X1(i);
	            Y=Y1(i);
                Td1=TDISC*C1;
	            SIMP= ERFC1(X,Y,X0,Y0,Z,C,C1,P1,Td1,Tm,II,MM);
	            SIMA=SIMA+SIMP;
             end        
                SIM=(Z*SIMA)/(8*(((pi*C)^1.5)));
                %TT(II,1)=Tm(II,1)/(30*86400.);
                 PP(II,1)=SIM*10;
        end 
      
end
end
PP(1,:) = [];
writematrix(PP,'ppdiffusion_result_t.dat'); 
end

function SIMP=ERFC1(X,Y,X0,Y0,Z,C,C1,P,Td1,Tm,K,MM)
         T=Tm(K);
        SUM=0.0;
        KK=K-1;
     for L=1:KK   
        T1=Tm(L);
        PP=P(L);
        if (~isequal(PP,0))
	         SUM1=f3(X0,Y0,Z,C,C1,PP,T,T1)*Td1;
	         SUM=SUM+SUM1;
        end
       SIMP=X*Y*SUM;
     end
end

function [F3]=f3(X0,Y0,Z,C,C1,PP,T,T1)
  
    SUM=exp(-((X0)^2+(Y0)^2 +Z^2)/(4.*C*(T-T1)));
	G1=PP*SUM;
	G2=((T-T1)^2.5);
	F3=G1/G2;
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

