fileEntireDataSet = importdata('FS_Timeseries_results.dat');
fileEntireDataSet1 = importdata('Waterlevel.dat');
dataFirstColumn = fileEntireDataSet(:,1); 
dataSecondColumn = fileEntireDataSet(:,3); 
dataThirdColumn = fileEntireDataSet(:,4); 
dataFifthColumn = fileEntireDataSet(:,5); 
dataSixthColumn = fileEntireDataSet(:,6); 
dataSeventhColumn = fileEntireDataSet(:,7);
dataFirstColumn1=fileEntireDataSet1(:,2);
dataSecondColumn1=fileEntireDataSet1(:,3);
figure()
plot(dataFirstColumn,dataSecondColumn,'LineWidth',1.13,'color','green');
xlabel('Time');
ylabel('kPa');
ylim(gca,[-40,0])
%set(gca,'Ytick',(-40:-10:0));
hold on
plot(dataFirstColumn,dataThirdColumn,'LineWidth',1.13,'color','[0.6350, 0.0780, 0.1840]');
xlabel('Time');
ylabel('kPa');
ylim(gca,[-40,0])
%set(gca,'Ytick',(0:-10:-40));
legend('Sp', 'S', 'Location', 'SouthEast');



figure()
plot(dataFirstColumn,dataFifthColumn,'LineWidth',1.13);
hold on
plot(dataFirstColumn,dataSixthColumn,'LineWidth',1.13,'color','[0.6350, 0.0780, 0.1840]');
hold on
plot(dataFirstColumn,dataSeventhColumn,'LineWidth',1.13);
xlabel('Time');
ylabel('kPa');
hold on
yyaxis right
plot(dataFirstColumn1,dataSecondColumn1,'LineWidth',1.13);
ylabel('Water Level (m)','rotation',-90,'VerticalAlignment','bottom');


legend('τ', 'σ','p','WL', 'Location', 'NorthWest','NumColumns',2);

