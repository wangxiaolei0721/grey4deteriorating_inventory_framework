% clear data and figure
clc;
clear;
close all;
% 
load data.mat
Q=800;
% start
t=[0:7]';
I_t_data=I_t_data';
I_t_data_Q=[Q;I_t_data];
l=length(I_t_data);
I1_cumsum=cumsum(I_t_data_Q(1:end-1,1));
I2_cumsum=cumsum(I_t_data_Q(2:end,1));
I_t_cum=1/2*I1_cumsum+1/2*I2_cumsum;  % accumulative series
% estimate parameter
time0=t(2:end);
% B=[I_t_cum(2:end,1),time0,ones(l-1,1)];
B=[I_t_cum,time0];
Y=I_t_data-Q;
p=pinv(B'*B)*B'*Y;
theta=-p(1);
d=-p(2);
save('direct_method_estimates.mat','theta','d')
% time sponse function
c=Q+d/theta;
I_t_sim=c*exp(-theta*t)-d/theta;
% plot figure
fig1=figure('unit','centimeters','position',[10,10,15,10],'PaperPosition',[10,10,15,10],'PaperSize',[15,10]);
plot(t,I_t_data_Q,'LineStyle','none','Marker','o','MarkerSize',8,'LineWidth',1.5)
hold on
plot(t,I_t_sim,'LineStyle','--','LineWidth',1.5,'Marker','^','MarkerSize',8)
xlabel({'时间/日'},'FontSize',14);
ylabel(['库存水平'],'FontSize',14)
set(gca,'FontName','Microsoft YaHei','FontSize',14,'Xlim',[-0.5,7.5],'Ylim',[0,850]);
legend(["真实水平","拟合水平"],'location','northeast','FontSize',12,'NumColumns',1);
% save figure
savefig(fig1,'.\figure\grey_direct_method.fig');
exportgraphics(fig1,'.\figure\grey_direct_method.pdf')

