% clear data and figure
clc;
clear;
close all;
%
load .\data\parpareddata.mat
load .\data\economic_parameters.mat
%%
traincycle=4;
testcycle=2;
iter=length(Date_index_t0)-traincycle-testcycle;
theta_vector=zeros(iter,1);
d_vector=zeros(iter,1);
%
T_true_vector=zeros(iter,1);
cost_vector=zeros(iter,1);
for k=1:iter
    begincycle=k;
    middlecycle=begincycle+traincycle-1;
    endcycle=begincycle+traincycle+testcycle-1;
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
    % economic pars
    cost_vector(begincycle)=Cost{endcycle+1};
    % endcycle+1
    T_true_vector(begincycle)=T_true{endcycle+1};
    % first one
    Date_t0_vector(begincycle)=Date_time{endcycle+1}(1);
    %% estimazation
    [theta,d] = estimation(Demand_train,Q_train,It_train);
    % fit
    It_Q_sim = fit(theta,d,Q_train_test,Date_index_train_test);
    %% plot
    finvertory=figure('unit','centimeters','position',[5,5,40,20],'PaperPosition',[5,5,40,20],'PaperSize',[40,20]);
    for i=1:(traincycle+testcycle)
        plot(Date_t0_train_test{i},It_Q_train_test{i},'LineStyle','none','Marker','o','MarkerSize',8,'LineWidth',1.5)
        hold on
        plot(Date_t0_train_test{i},It_Q_sim{i},'LineStyle','--','LineWidth',1.5,'MarkerSize',8)
        stem(Date_t0_train_test{i}(1),It_Q_train_test{i}(1),'LineStyle','--','LineWidth',1,'Color','black')
    end
    xlabel({'时间/日'},'FontSize',14);
    ylabel(['库存水平'],'FontSize',14)
    xlim([Date_t0_train_test{1}(1),Date_t0_train_test{traincycle+testcycle}(end)]);
    set(gca,'FontName','Microsoft YaHei','FontSize',12);
    % legend(["真实水平","拟合水平"],'location','northeast','FontSize',12,'NumColumns',1);
    %% final step
    [theta,d] = estimation(Demand_train_test,Q_train_test,It_train_test);
    theta_vector(k)=theta;
    d_vector(k)=d;
end
%%
save('.\data\estimates.mat','theta_vector','d_vector',"T_true_vector","cost_vector","Date_t0_vector")

