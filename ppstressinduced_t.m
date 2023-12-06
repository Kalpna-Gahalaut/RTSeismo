function [pcc]=ppstressinduced_t(FNAM,L1,M1,Z1,C1,Tdisc1,damhmsl1,SC1,Xobs1,Yobs1)
            l=L1;
            m=M1;
            z=Z1;
            c=C1;
            Tdisc=Tdisc1;
            DAMHMSL=damhmsl1;
            SC=SC1;           
            Xobs=Xobs1;
            Yobs=Yobs1;
%             Xdisc=Xdisc1;
%             Ydisc=Ydisc1;

     	
	[D] = import_data_File(FNAM);

        rad=pi/180;
    	n=D.V1(1,1);
    	%l=D.V2(1,1); 
    	%m=D.V3(1,1); 
    	mm=D.V1(2,1); 
    	%z=D.V2(2,1); 
    	%c=D.V3(2,1); 
    	c1=D.V2(2:2,1);
	pk(:,1)=D.V3(3:mm+2,1);
	tm(:,1)=D.V2(3:mm+2,1);
	dat(:,1)=D.V1(3:mm+2,1);
    
	for i=1:n   
    		x(i,1)=D.V2(mm+2+i);
    		y(i,1)=D.V3(mm+2+i);
    		x01(i,1)=D.V4(mm+2+i);
    		y01(i,1)=D.V5(mm+2+i);
    		pf(i,1)=D.V6(mm+2+i);
            x0(i,1)=x01(i,1)+Xobs;
            y0(i,1)=y01(i,1)+Yobs;
    end
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
for i=1:mm
        
           p(i)=(pk(i)-DAMHMSL);
end

	%TDISC=1;
	TL(1)=0.0;	
    for i=2:mm

        TL(i)=TL(i-1)+Tdisc;
    end
for i=1:mm
	Tm(i)=TL(i)*c1;
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
			xx0=x0(1,J);				
			yy0=y0(1,K);				
	    		
                for I=mm:-1:2
                I
				if (~isequal(I,mm))				
	        		t=Tm(mm)-Tm(I);				
	        		[PI]=PLS(c,t,z,xx0,yy0,n,x01,y01,x,y);
                     
				ij=(mm-I)+1;				

 				pp(1:n,I)=PI(1:n,1)/(8*sqrt((c*t*pi)^3));
                
				dis(ij,1:n)=pp(1:n,I);				
				ppf(I,1:n)=ppi(I,1:n)-ppi(I-1,1:n);		
                end	
      
                %I
                end	
                %SC=0.7;
	    	for ii=2:mm	
             
			pc=0.0;				
                for ja=2:ii-1				
                        for ia=1:n				
	            			jj=(ii-ja)+1;				
	                		pa=dis(ja,ia)*ppf(jj,ia);
                         
	                		pc=pc+pa;				
                        end				
                end				
			%tt(ii,1)=tm(ii,1)/(10*86400);
%             pcc=zeros(ii,1);
			pcc(ii,1)=SC*pc*10
           
            end	
            
	    	end				
	end								
         pcc([1,1],:) = [];
        
            writematrix(pcc,'data6.dat');
            
            ppd=importdata('ppdiff_result_t.dat');
            data3=importdata('data3.dat');
            data6=importdata('data6.dat');
            pps=data3+data6;
            ppt=ppd+pps
            dd1=importdata('dateee.dat');
            dd2=[dd1,ppt,ppd,pps];
            pcc=(dd2);
           writematrix(dd2,'ppstressinduced_result_t.dat');
end
	
function [PI]=PLS(c,t,z,x1,y1,n,x01,y01,x,y)
     
	[PI]=add11(c,t,x1,y1,z,n,x01,y01,x,y);
end

function [PI]=add11(c,t,x0,y0,z,nr,x01,y01,x,y)

    [a1,b1]= flim(z,c,t);
    if (a1<0)
        a=0;
    else
        a=a1;
    end
    b=b1;
	n=10;
    h=(b-a)/n;
    [fa1]= af1(c,t,x0,y0,z,a,nr,x01,y01,x,y);
	[fb1]=af1(c,t,x0,y0,z,b,nr,x01,y01,x,y);
	for i=1:nr

		sum1(i,1)=fa1(i,1)+fb1(i,1);
		sum2(i,1)=0;
    end
	NN=n-1;
	for I=1:NN
        	z1=a+(I*h);
        	[f1]=af1(c,t,x0,y0,z,z1,nr,x01,y01,x,y);
        	for ii=1:nr
            		sum2(ii,1)=sum2(ii,1)+f1(ii,1);
        	end
    end       
	  for i=1:nr
          
		PI(i,1)=h*(sum1(i,1)+2*sum2(i,1))/2;
    end
    end

function [f1]=af1(c,t,x0,y0,z,z1,nr,x01,y01,x,y)  
if (~isequal(z1,0))	
[a1,b1]=flim(y0,c,t);	
a=a1;	
b=b1;	
N=10;	
H=(b-a)/N; 	
[fa2]=af2(c,t,x0,y0,z,z1,a,nr,x01,y01,x,y);	
[fb2]=af2(c,t,x0,y0,z,z1,b,nr,x01,y01,x,y);	
for i=1:nr	
	sum1(i,1)=fa2(i,1)+fb2(i,1);	
	sum2(i,1)=0.0;	
end    
N1=N-1;	
for I=1:N1	
	y1=a+I*H;	
	[f2]=af2(c,t,x0,y0,z,z1,y1,nr,x01,y01,x,y);	
	for  ii=1:nr	
		sum2(ii,1)=sum2(ii,1)+f2(ii,1);	
	end    
end           
for i=1:nr	

	f1(i,1)=H*(sum1(i,1)+2*sum2(i,1))/2;	
end    
else
    f1=zeros(nr,1);
end
end    

function [f2]=af2(c,t,x0,y0,z,z1,y1,nr,x01,y01,x,y)   
[a1,b1]= flim(x0,c,t);	
a=a1;	
b=b1;	
N=10;	
H=(b-a)/N;	
[fa3]= af3(c,t,x0,y0,z,z1,y1,a,nr,x01,y01,x,y);	
[fb3]= af3(c,t,x0,y0,z,z1,y1,b,nr,x01,y01,x,y);	
for i=1:nr	

	sum1(i,1)=fa3(i,1)+fb3(i,1);	
	sum2(i,1)=0.0;	
end    
N1=N-1;	
for I=1:N1	
	x1=a+(I*H);	
	[f3]=af3(c,t,x0,y0,z,z1,y1,x1,nr,x01,y01,x,y);	
   
	for ii=1:nr	
		sum2(ii,1)=sum2(ii,1)+f3(ii,1);	
	end    
end                  
for i=1:nr	

	f2(i,1)=H*(sum1(i,1)+2*sum2(i,1))/2;	
end    
end    

function [f3]=af3(c,t,x0,y0,z,z1,y1,x1,nr,x01,y01,x,y)  
 
 nrr=nr;    
 nrc=1; 
 xx=x;
 yy=y;
 rad=pi/180;	
 r1=sqrt((z-z1)^2+(y0-y1)^2+(x0-x1)^2);	
 r2=sqrt((z+z1)^2+(y0-y1)^2+(x0-x1)^2);    
 g1=exp(-(r1.^2)/(4*c*t));    
 g2=exp(-(r2.^2)/(4*c*t));    
 r=g1-g2;
for  i=1:nrr  

        xx0(i,1)=x01(i,1)+x1;    
        yy0(i,1)=y01(i,1)+y1;   
        THR=0.0;    
        x00=(xx0(i,1)*cos(THR))+(yy0(i,1)*sin(THR));   
        y00=(yy0(i,1)*cos(THR))-(xx0(i,1)*sin(THR));    
        x=xx(i,1);   
        y=yy(i,1);    
        [sigx, sigy, sigz]=AD(x,y,x00,y00,z1);
        
        f=(sigx+sigy+sigz)/3;
        %f3(i,1)=f*r; 
        f3(i,1)=f*r;
        
end    
end    
function [a1,b1]=flim(x,c,t)  


aa=sqrt(4*c*t*100);	
a1=x-aa;	
b1=x+aa;	
end    
function [sigx, sigy, sigz]=AD(x,y,x00,y00,Z)

	AN=1-(2*0.25);
	PRE=1/(2*pi);
	X=x00;
	Y=y00;
	R=sqrt((X^2)+(Y^2)+(Z^2));
	A=(3*(X^2)*Z)/R^5;
   
	B=((Y^2)+(Z^2))/((R^3)*(Z+R));
    
	C=(Z/(R^3))+((X^2)/((R^2)*((Z+R)^2)));
	SIGX=PRE*(A+(AN*(B-C)));
	D=(3*(Y^2)*Z)/R^5;
	E=((X^2)+(Z^2))/((R^3)*(Z+R));
	F=(Z/(R^3))+((Y^2)/((R^2)*((Z+R)^2)));
	SIGY=PRE*(D+(AN*(E-F)));
	SIGZ=PRE*(3*(Z^3))/R^5;
       sigx=SIGX*x*y;    
       sigy=SIGY*x*y;    
       sigz=SIGZ*x*y;    
end
function [FSIN]= fsin(X)
if (abs(X)<1)
    if (X<0)
        FSIN=-pi/2;
    else
        FSIN=pi/2;
    end
else
    FSIN=asin(X);
end
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
