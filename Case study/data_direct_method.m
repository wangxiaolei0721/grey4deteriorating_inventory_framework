% clear data and figure
clc;
clear;
close all;
% 
load .\data\parpareddata.mat
%
i=5;
% start
date_time=Date_time{i};
date_index=Date_index_t0{i};
demand=Demand{i};
Q=Levelatt0{i};
It_Q=Level_t0{i};
It=It_Q(2:end);
%
l=length(date_time);
I1_cumsum=cumsum(It_Q(1:end-1,1));
I2_cumsum=cumsum(It_Q(2:end,1));
I_t_cum=1/2*I1_cumsum+1/2*I2_cumsum;  % accumulative series
% estimate parameter
B=-I_t_cum;
g_integral=cumsum(demand);
Y=It-Q+g_integral;
theta=(B'*B)\B'*Y;
d=mean(demand);
% save('parameter_estimates.mat','theta','d')
% time sponse function
k=[0:l]';
c=Q+d/theta;
I_t_sim=c*exp(-theta*k)-d/theta;
% plot figure
fig1=figure;
plot(date_index,It_Q,'LineStyle','none','Marker','o','MarkerSize',6,'LineWidth',1.5)
hold on
plot(date_index,I_t_sim,'LineStyle','--','LineWidth',1.5)
xlabel({'时间/日'},'FontSize',14);
ylabel(['库存水平'],'FontSize',14)
set(gca,'FontName','Microsoft YaHei','FontSize',12);
legend(["真实水平","拟合水平"],'location','northeast','FontSize',12,'NumColumns',1);
% save figure
savefig(fig1,'.\figure\case.fig');
% exportgraphics(fig1,'.\figure\chapter2_grey_direct_method.pdf')

