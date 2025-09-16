% clear data and figure
clc;
clear;
close all;
% parameter
c=5;
h=0.1;
K=300;
%%
% load data
load direct_method_estimates.mat
% optimazation
T_interval=[1 10];
% order cycle to be evaluated
cost_fd = @(T) cost(d,theta,c,h,K,T);
% der 1
syms T;
cost_syms = cost(d,theta,c,h,K,T);
cost_der=diff(cost_syms,T);
eq1 = cost_der == 0;
sol = vpasolve(eq1,T,T_interval);
T_opt  = double(sol);
cost_opt = cost(d,theta,c,h,K,T_opt);
%% der 2
cost_der2=diff(cost_der,T);
%% plot
figure('unit','centimeters','position',[5,5,30,10],'PaperPosition',[5,5,30,10],'PaperSize',[30,10])
tile=tiledlayout(1,3,'Padding','Compact');
nexttile
fplot(cost_fd,T_interval,'LineWidth',1.5)
hold on
plot(T_opt,cost_opt,'LineStyle','none','Marker','hexagram','MarkerFaceColor','none','MarkerEdgeColor','r','MarkerSize',8)
xlabel({'订货周期/日'},'FontSize',14)
ylabel(['成本/单位货币'],'FontSize',14)
% title({'(a) 成本'},'FontSize',16)
set(gca,'FontName','Microsoft YaHei','FontSize',14)
nexttile
fplot(cost_der,T_interval,'LineWidth',1.5)
xlabel({'订货周期/日'},'FontSize',14)
ylabel(['成本的一阶导数'],'FontSize',14)
% title({'(a) 成本的一阶导数'},'FontSize',16)
set(gca,'FontName','Microsoft YaHei','FontSize',14)
nexttile
fplot(cost_der2,T_interval,'LineWidth',1.5)
xlabel({'订货周期/日'},'FontSize',14)
ylabel(['成本的二阶导数'],'FontSize',14)
% title({'(a) 成本的二阶导数'},'FontSize',16)
set(gca,'FontName','Microsoft YaHei','FontSize',12)
%%
Q_opt=d/theta*(exp(theta*T_opt)-1);
% save figure
savefig(gcf,'.\figure\grey_direct_opt.fig');
exportgraphics(gcf,'.\figure\grey_direct_opt.pdf')

