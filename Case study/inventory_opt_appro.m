% clear data and figure
clc;
clear;
close all;
%%
% load data
load .\data\estimates1.mat
% parameter
c=cost_value;
T_true=T_true_value;
h=0.27;
K=1200;
% optimazation
T_interval=[1 7];
% order cycle to be evaluated
cost_fd = @(T) cost_appro(d,theta,c,h,K,T);
% der 1
syms T;
cost_syms = cost_appro(d,theta,c,h,K,T);
cost_der=diff(cost_syms,T);
eq1 = cost_der == 0;
sol = vpasolve(eq1,T,T_interval);
T_opt  = double(sol);
cost_opt = cost_appro(d,theta,c,h,K,T_opt);
cost_true = cost_appro(d,theta,c,h,K,T_true);
%% der 2
cost_der2=diff(cost_der,T);
%% plot
figure('unit','centimeters','position',[5,5,30,10],'PaperPosition',[5,5,30,10],'PaperSize',[30,10])
tile=tiledlayout(1,3,'Padding','Compact');
nexttile
fplot(cost_fd,T_interval,'LineWidth',1.5)
hold on
plot(T_opt,cost_opt,'LineStyle','none','Marker','hexagram','MarkerFaceColor','none','MarkerEdgeColor','r','MarkerSize',8,'LineWidth',1.5)
plot(T_true,cost_true,'LineStyle','none','Marker','hexagram','MarkerFaceColor','none','MarkerEdgeColor','m','MarkerSize',8,'LineWidth',1.5)
xlabel({'订货周期/日'},'FontSize',14)
ylabel(['成本/元'],'FontSize',14)
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
set(gca,'FontName','Microsoft YaHei','FontSize',14)
%%
Q_opt=d/theta*(exp(theta*T_opt)-1);
Q_true=d/theta*(exp(theta*T_true)-1);
% save figure
savefig(gcf,'.\figure\case_opt_appro1.fig');
exportgraphics(gcf,'.\figure\case_opt_appro1.pdf')

