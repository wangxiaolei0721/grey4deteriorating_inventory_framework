% clear data and figure
clc;
clear;
close all;
% parameter
h=0.27;
K=1200;
%%
% load data
load .\data\estimates.mat
T_opt_vector=zeros(12,1);
Q_opt_vector=zeros(12,1);
Q_true_vector=zeros(12,1);
Totalcost_opt_vector=zeros(12,1);
Totalcost_true_vector=zeros(12,1);
for k = 1:12
    theta=theta_vector(k);
    d=d_vector(k);
    cost_value=cost_vector(k);
    c=cost_value;
    T_true_value=T_true_vector(k);
    % optimazation
    T_interval=[1 7];
    % order cycle to be evaluated
    cost_fd = @(T) cost(d,theta,c,h,K,T);
    % der 1
    syms T;
    cost_syms = cost(d,theta,c,h,K,T);
    cost_der=diff(cost_syms,T);
    eq1 = cost_der == 0;
    sol = vpasolve(eq1,T,T_interval);
    T_opt  = double(sol);
    T_opt_vector(k)=T_opt;
    cost_opt = cost(d,theta,c,h,K,T_opt);
    Totalcost_opt_vector(k)=cost_opt;
    cost_true = cost(d,theta,c,h,K,T_true_value);
    Totalcost_true_vector(k)=cost_true;
    %%
    Q_opt=d/theta*(exp(theta*T_opt)-1);
    Q_opt_vector(k)=Q_opt;
    Q_true=d/theta*(exp(theta*T_true_value)-1);
    Q_true_vector(k)=Q_true;
end
%
% plot
figure('unit','centimeters','position',[5,5,40,20],'PaperPosition',[5,5,40,20],'PaperSize',[40,20]);
categories= categorical(Date_t0_vector);
Totalcost=[Totalcost_true_vector,Totalcost_opt_vector];
bar(Totalcost)
ylim([0,2500])
% 添加标题和标签
set(gca, 'XTickLabel', categories); % 设置X轴标签为类别名称
legend('实际成本', '优化成本','FontSize',14); % 添加图例
ylabel(['成本'],'FontSize',14)
xlabel('日期','FontSize',14)
set(gca,'FontName','Microsoft YaHei','FontSize',16)
% save figure
savefig(gcf,'.\figure\case_opt.fig');
exportgraphics(gcf,'.\figure\case_opt.pdf')



