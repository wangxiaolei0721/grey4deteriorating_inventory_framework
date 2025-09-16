% clear data and figure
clc;
clear;
close all;
% load data
load data.mat
Q=800; % initial inventory
t=[0:7]';
i_t_data=i_t_data';
l=length(i_t_data);
i_t_cum=[Q;Q+cumsum(i_t_data)];  % accumulative series
z1=(i_t_cum(2:end)+i_t_cum(1:end-1))/2; % neighbor mean series
% plot original and cumulative series
fig=figure('unit','centimeters','position',[10,10,30,10],'PaperPosition',[10,10,30,10],'PaperSize',[30,10]);
tile=tiledlayout(1,2,'Padding','Compact');
nexttile
plot(t(2:end),i_t_data,'LineStyle','--','Marker','o','MarkerSize',8,'LineWidth',1.5)
xlabel({'时间/日'},'FontSize',14);
ylabel(['库存变化量'],'FontSize',14)
% title({' (a) 库存变化量的观测数据'},'FontSize',16);
set(gca,'FontName','Microsoft YaHei','FontSize',14,'Xlim',[0.5,7.5]);
nexttile
plot(t(2:end),i_t_cum(2:end),'LineStyle','--','Marker','o','MarkerSize',8,'LineWidth',1.5,'Color',[217, 83, 25]/255);
xlabel({'时间/日'},'FontSize',14);
ylabel(['库存水平'],'FontSize',14)
% title({' (b) 库存水平'},'FontSize',16);
set(gca,'FontName','Microsoft YaHei','FontSize',12,'Xlim',[0.5,7.5]);
savefig(gcf,'.\figure\grey_traditional_method_cum.fig');
exportgraphics(gcf,'.\figure\grey_traditional_method_cum.pdf')
% estimate parameter
B=[z1,ones(l,1)];
Y=i_t_data;
p=(B'*B)\B'*Y;
theta=-p(1);
d=-p(2);
save('traditional_method_estimates.mat','theta','d')
% time sponse function
k=[0:l]';
c=Q+d/theta;
I_t_sim=c*exp(-theta*k)-d/theta;
% plot fitted curve
fig1=figure('unit','centimeters','position',[10,10,15,10],'PaperPosition',[10,10,15,10],'PaperSize',[15,10]);
plot(t,i_t_cum,'LineStyle','none','Marker','o','MarkerSize',8,'LineWidth',1.5)
hold on
plot(t,I_t_sim,'LineStyle','--','LineWidth',1.5,'Marker','^','MarkerSize',8)
xlabel({'时间/日'},'FontSize',14);
ylabel(['库存水平'],'FontSize',14)
set(gca,'FontName','Microsoft YaHei','FontSize',14,'Xlim',[-0.5,7.5],'Ylim',[0,850]);
legend(["真实水平","拟合水平"],'location','northeast','FontSize',12,'NumColumns',1);
% save figure
savefig(fig1,'.\figure\grey_traditional_method.fig');
exportgraphics(fig1,'.\figure\grey_traditional_method.pdf')

