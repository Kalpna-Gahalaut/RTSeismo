function [p]= FS_p(Th1,ALAM1,Shi1,Xmu1,Olat1,Olon1,Olatd1,Olond1)
global Xobs1;
global Yobs1;
global L1;
global M1;

TH=str2double(Th1);
ALAM=str2double(ALAM1);
shi=str2double(Shi1);
xmu=str2double(Xmu1);
filename = 'stress_result_p.dat';
[D]=load(filename);
% [T]=importdata('Inp-Res-WL.dat');
% L2=T(1,2)
% M2=T(1,3)
% L2=L11
% M2=M11
% Xobs1=Xobs11;
% Yobs1=Yobs11;
   for i=1:L1*M1
          SIGX=D(:,1);
           SIGY=D(:,2);
          SIGZ=D(:,3); 
          TAYXY=D(:,4); 
          TAYYZ=D(:,5); 
          TAYZX=D(:,6);
          RAD=pi/180;
          THR=TH*RAD;
        ALAMR=ALAM*RAD;
        ALN=sin(THR)*cos(ALAMR);
        AMN=sin(THR)*sin(ALAMR);
        ANN=-cos(THR);
        ALD=cos(THR)*cos(ALAMR);
        AMD=cos(THR)*sin(ALAMR);
        AND=sin(THR);
        ALS=sin(ALAMR);
        AMS=-cos(ALAMR);
        ANS=0;
        AS=(ALN^2)*SIGX+(AMN^2)*SIGY+(ANN^2)*SIGZ;
        AT=2*AMN*ANN*TAYYZ;
        AU=2*ANN*ALN*TAYZX;
        AV=2*ALN*AMN*TAYXY; 
        sn=(AS+AT+AU+AV);
        CS=ALN*ALD*SIGX+AMN*AMD*SIGY+ANN*AND*SIGZ;
        CT=(AMN*AND+AMD*ANN)*TAYYZ;
        CU=(ANN*ALD+AND*ALN)*TAYZX;
        CV=(ALN*AMD+ALD*AMN)*TAYXY;
        td=(CS+CT+CU+CV);
        BS=ALN*ALS*SIGX+AMN*AMS*SIGY+ANN*ANS*SIGZ;
        BT=(AMN*ANS+AMS*ANN)*TAYYZ;
        BU=(ANN*ALS+ANS*ALN)*TAYZX;
        BV=(ALN*AMS+ALS*AMN)*TAYXY;  
        ts=(BS+BT+BU+BV);
   end
         
        shir=shi*RAD;
        tau=sqrt((td.^2)+(ts.^2));
	    ts=-ts;
        phi=atan(td./ts);
        idx = (ts<0);
       phi(idx) = phi(idx) + pi
        
             idx1=(ts==0&td>0);
     	      phi(idx1)=pi/2;

            idx2=(ts==0&td<0);
                 phi(idx2)=-pi/2;
              
                     
                      th=shir-phi;
                      snf=sn*10;
                       tauf=(tau.*cos(th))*10;
     
  for j=1:L1
      for k=1:M1
   filename = 'ppdiffusion_result_p.dat';
   [D1]=load(filename);
    pp=D1(:,1);
   olat=str2double(Olat1);
   olon=str2double(Olon1);
   olatd=str2double(Olatd1);
   olond=str2double(Olond1);
   %xmu=Xmu1;
   st=tauf-(xmu*snf);
   stpp=st+(xmu*(pp));
       	aj=j-1;
        ak=k-1;
        Xobs2=-(Xobs1/1000);
        Yobs2=-(Yobs1/1000);
       aj=((aj-Xobs2)/olatd)+olat;
       ak=((ak-Yobs2)/olond)+olon;
       if (j==1&&k==1)
	        D3=[ak aj];
       else
             D3=[D3
                 ak aj];
       end
       end
   end     
   p=[D3 stpp st tauf snf pp];
   writematrix(p,'FS_Planview_results.dat');
 

end
  