% clear data and figure
clc;
clear;
close all;
%
load .\data\parpareddata.mat
load .\data\economic_parameters.mat
%%
begincycle=1;
traincycle=4;
testcycle=2;
middlecycle=begincycle+traincycle-1;
endcycle=begincycle+traincycle+testcycle-1;
% endcycle+1
T_true_value=T_true{endcycle+1};
cost_value =Cost{endcycle+1};
% start
% train data
Demand_train = Sale(begincycle:middlecycle);
Q_train=Levelatt0(begincycle:middlecycle);
It_train=Level(begincycle:middlecycle);
% test data
Demand_test = Sale(middlecycle+1:endcycle);
Q_test=Levelatt0(middlecycle+1:endcycle);
It_test=Level(middlecycle+1:endcycle);
% train data and test data
Date_t0_train_test=Date_time_t0(begincycle:endcycle);
Date_index_train_test=Date_index_t0(begincycle:endcycle);
Demand_train_test=[Demand_train,Demand_test];
Q_train_test=[Q_train,Q_test];
It_train_test=[It_train,It_test];
It_Q_train_test=Level_t0(begincycle:endcycle);
%% estimazation
[theta,d] = estimation(Demand_train,Q_train,It_train);
% fit
It_Q_sim = fit(theta,d,Q_train_test,Date_index_train_test);
%% plot
finvertory=figure('unit','centimeters','position',[5,5,40,20],'PaperPosition',[5,5,40,20],'PaperSize',[40,20]);
for i=1:(traincycle+testcycle)
    plot(Date_t0_train_test{i},It_Q_train_test{i},'LineStyle','none','Marker','o','MarkerSize',8,'LineWidth',1.5,'Color',[0 0.4470 0.7410])
    hold on
    plot(Date_t0_train_test{i},It_Q_sim{i},'LineStyle','--','LineWidth',1.5,'Marker','^','MarkerSize',8,'Color',[0.8500 0.3250 0.0980])
    stem(Date_t0_train_test{i}(1),It_Q_train_test{i}(1),'LineStyle','--','LineWidth',1,'Color','black')
end
xlabel({'时间/日'},'FontSize',14);
ylabel(['库存水平'],'FontSize',14)
xlim([Date_t0_train_test{1}(1),Date_t0_train_test{traincycle+testcycle}(end)]);
set(gca,'FontName','Microsoft YaHei','FontSize',16);
legend(["真实库存水平","预测库存水平"],'Location','north');
% legend(["真实水平","拟合水平"],'location','northeast','FontSize',12,'NumColumns',1);
% Create doublearrow
annotation(finvertory,'doublearrow',[0.157442708333333 0.634354166666667],...
    [0.88 0.88]);
% Create doublearrow
annotation(finvertory,'doublearrow',[0.653536458333333 0.891661458333333],...
    [0.88 0.88]);
% Create line
annotation(finvertory,'line',[0.646 0.646],...
    [0.921104166666667 0.850666666666667]);
% Create textbox
annotation(finvertory,'textbox',...
    [0.661246901220444 0.819642857142856 0.0856510416666666 0.0457068452380953],...
    'String','测试集',...
    'LineStyle','none',...
    'HorizontalAlignment','center',...
    'FontSize',16,...
    'FontName','Microsoft YaHei',...
    'FitBoxToText','off');
% Create textbox
annotation(finvertory,'textbox',...
    [0.350034086575134 0.825 0.0856510416666666 0.0457068452380953],...
    'String','训练集',...
    'LineStyle','none',...
    'HorizontalAlignment','center',...
    'FontSize',16,...
    'FontName','Microsoft YaHei',...
    'FitBoxToText','off');
%%
[theta,d] = estimation(Demand_train_test,Q_train_test,It_train_test);
save('.\data\estimates1.mat','theta','d',"T_true_value","cost_value")
% save figure
savefig(gcf,'.\figure\case_fit.fig');
exportgraphics(gcf,'.\figure\case_fit.pdf')

