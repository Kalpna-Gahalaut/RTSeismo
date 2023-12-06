function [pp]=plct_Test(FNAM,L1,M1,Z1,C1,Tdisc1,damhmsl1,SC1,Xobs1,Yobs1)
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
    	n=D.V1(1,1); 
    	%l=D.V2(1,1);
        l=L;
    	%m=D.V3(1,1); 
        m=M;
    	mm=D.V1(2,1); 
        %z=D.V2(2,1); 
        z=Z;
        c=C;
        %c=D.V3(2,1); 
    	c1=D.V2(2:2,1);
        %SC=0.7;
        
        pk(:,1)=D.V3(3:mm+2,1);
	    tm(:,1)=D.V2(3:mm+2,1);
	    dat(:,1)=D.V2(3:mm+2,1);
    	x(1:n,1)=D.V2(mm+2+1:mm+2+n,1);	
    	y(1:n,1)=D.V3(mm+2+1:mm+2+n,1);
    	x01(1:n,1)=D.V4(mm+2+1:mm+2+n,1);	
    	y01(1:n,1)=D.V5(mm+2+1:mm+2+n,1);	
    	pf(1:n,1)=D.V6(mm+2+1:mm+2+n,1);
        %Xobs=-5420;
       %Yobs=-2738;

        x0(1:n,1)=x01(1:n,1)+Xobs;        
        y0(1:n,1)=y01(1:n,1)+Yobs; 
        %{
        for i=1:n
            for j=2:l
                x0(i,j)=x0(i,j-1)+Xdisc;
                
            end
            for k=2:m
                y0(i,k)=y0(i,k-1)+Ydisc;
            end
        end
        %}
       % p(1:mm,1)=pk(1:mm,1)
       
         for i=1:mm	
        p(i)=(pk(i)-DAMHMSL);
         end
    for i=1:mm	      
		for j=1:n		
			ppp=pf(1)-p(i);		
			ppi(i,j)=pf(j)-ppp;		
	    		if (ppi(i,j)<0)	      
	        		ppi(i,j)=0;	      
	    		end	      
	   	end	      
    end   
	for  J=1:1
	for K=1:1
	for II=2:mm
	sigax=0.0;
	sigay=0.0;
	sigaz=0.0;
	for I=1:n
	THR=0.0;
	xx=(x0(I,J)*cos(THR))+(y0(I,K)*sin(THR));
	yy=(y0(I,K)*cos(THR))-(x0(I,J)*sin(THR));
	ppf=ppi(II,I)-ppi(II-1,I);
	%CALL PLS(X(I),Y(I),Ppf,Z,XX,YY,SIGx,sigy,sigz)
    [sigx,sigy,sigz]=PLS(x(I,1),y(I,1),ppf,z,xx,yy);
	sigax=sigax+sigx;
	sigay=sigay+sigy;
	sigaz=sigaz+sigz;
    end
	sig=(sigax+sigay+sigaz)/3;
     %format shortG
	pp(II,1)=SC*sig*10;
 	%tt(II,1)=tm(II,1)/30;
    end
    end
    end
       pp(1,:) = [];
       dat(1,:) = [];
      writematrix(pp,'data3.dat');
      writematrix(dat,'dateee.dat'); 
end
function  [sigx,sigy,sigz]=PLS(X1,Y1,p,Z,X01,Y01)
    x=X1;
 	y=Y1;
 	x0=X01;
 	y0=Y01;
 [sigxr,sigyr,sigzr]=ADD(p,x0,y0,Z);
          sigx=sigxr*x*y;
          sigy=sigyr*x*y;
          sigz=sigzr*x*y;
end

function [SIGX,SIGY,SIGZ]=ADD(p,x0,y0,Z)
	AN=1-(2*0.25);
	PRE=p/(2*pi);
	X=x0;
	Y=y0;
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