function [p1]= FS_t(Th1,ALAM1,Shi1,Xmu1)
TH=str2double(Th1);
ALAM=str2double(ALAM1)
shi=str2double(Shi1);
xmu=str2double(Xmu1);
filename = 'stress_result_t.dat';
[D]=load(filename);
[T]=importdata('Inp-Res-WL.dat');
L3=T(2,1)-1;

for i=1:L3
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
%     if(ts==0)
%        if(ts==0&&td>0)  
% 	      phi=pi/2;
%        end
%     end
%        if(ts<0) 
%             phi=pi+phi;
%         end
%     if(ts==0&td<0)
%             phi=-pi/2;
%     end
    th=shir-phi;
	snf=sn*10
	tauf=(tau.*cos(th))*10;


   filename = 'ppstressinduced_result_t.dat';
   [D1]=load(filename);
    date=D1(:,1);
     ppt=D1(:,2);
      ppd=D1(:,3);
       pps=D1(:,4);
    
     
     for j=1:L3 
  
        %xmu=.4;
     
        st=tauf-(xmu*snf);
        stppt=st+(xmu*(ppt));
        stppd=st+(xmu*(ppd));
%date,stppt,stppd,st,tauf,sn,ppt,ppd,pps
    
     end
    [p1]=[date stppt stppd st tauf snf ppt ppd pps]
    writematrix(p1,'FS_Timeseries_results.dat');
  end


       
