%% clear data and figure
clc;
clear;
close all;
load apple.mat
%% initialization of data storage
Date=apple.Date;
PurchaseQuantity=apple.PurchaseQuantity;
PurchaseAmount=apple.PurchaseAmount;
SalesQuantity=apple.SalesQuantity;
Inventory=apple.Inventory;
%% data prepare
Date_time = {};
Date_t0={};
Date_time_t0 = {};
Date_index_t0 = {};
T_true = {};
Cost={};
Sale={};
Levelatt0= {};
Level = {};
Level_t0 = {};
% plot
% Date_plot=[];
% Level_plot=[];
% Datet0=[];
% Levelt0=[];
%
NotNaNPositions=~isnan(PurchaseQuantity);% 返回一个逻辑矩阵，NaN 位置为 true
[NotNaNrow, ~] = find(NotNaNPositions); % 找出 NaN 的行和列索引
% Date4result=Date(NotNaNrow);
% writematrix(Date4result,'Date4result.xlsx');
for i = 1:(length(NotNaNrow)-1)
    irow=NotNaNrow(i);
    inextrow=NotNaNrow(i+1);
    Date_time{i} =Date(irow:(inextrow-1));
    Date_t0{i} =Date(irow-1);
    Date_time_t0{i} =Date(irow-1:(inextrow-1));
    Date_index_t0{i} =[0;(1:inextrow-irow)'];
    T_true{i}=inextrow-irow;
    Cost{i}=PurchaseAmount(irow)/PurchaseQuantity(irow);
    Sale{i}=SalesQuantity(irow:(inextrow-1));
    levelatt0=Inventory(irow-1)+PurchaseQuantity(irow);
    Levelatt0{i}=levelatt0;
    Level{i}=Inventory(irow:(inextrow-1));
    Level_t0{i}=[levelatt0;Inventory(irow:(inextrow-1))];
    %
    % Date_plot=[Date_plot;Date(irow-1:(inextrow-1))];
    % Level_plot=[Level_plot;levelatt0;Inventory(irow:(inextrow-1))];
    % Datet0=[Datet0;Date(irow-1)];
    % Levelt0=[Levelt0;levelatt0];
end
%% plot demand and inventory
% plot sales
demand_fig=figure('unit','centimeters','position',[5,5,40,20],'PaperPosition',[5,5,40,20],'PaperSize',[40,20]);
plot(Date,SalesQuantity,'MarkerSize',12,'Marker','x','LineWidth',2,'LineStyle','none',...
    'Color',[0 0.447058823529412 0.741176470588235])
xlabel({'时间/日'},'FontSize',14);
ylabel(['需求量'],'FontSize',14)
set(gca,'FontName','Microsoft YaHei','FontSize',16);
% plot inventory
inventory_fig=figure('unit','centimeters','position',[5,5,40,20],'PaperPosition',[5,5,40,20],'PaperSize',[40,20]);
for i = 1:length(Date_time_t0)
    plot(Date_time_t0{i},Level_t0{i},'Marker','o','LineWidth',1.5,'MarkerSize',8)
    hold on
    stem(Date_t0{i},Levelatt0{i},'LineStyle','--','LineWidth',1,'Color','black')
end
xlabel({'时间/日'},'FontSize',14);
ylabel(['库存水平'],'FontSize',14);
xlim([datetime(2019,2,28) datetime(2019,6,30)]);
set(gca,'FontName','Microsoft YaHei','FontSize',16);
annotation(inventory_fig,'textbox',...
    [0.18 0.84 0.10 0.05],...
    'String',{'订货点'},...
    'HorizontalAlignment','center',...
    'FontSize',16,...
    'FontName','Microsoft YaHei',...
    'FitBoxToText','off');
% Create textarrow
annotation(inventory_fig,'textarrow',[0.17162471395881 0.225781845919146],...
    [0.669642857142857 0.84]);
% Create textarrow
annotation(inventory_fig,'textarrow',[0.293668954996186 0.241800152555301],...
    [0.705357142857143 0.84]);
% Create textarrow
annotation(inventory_fig,'textarrow',[0.214340198321892 0.232646834477498],...
    [0.710714285714286 0.84]);
% Create textarrow
annotation(inventory_fig,'textarrow',[0.25629290617849 0.236460717009917],...
    [0.710714285714286 0.84]);
%
save("parpareddata.mat","Date_time","Date_time_t0","Date_index_t0","Sale","Levelatt0","Level","Level_t0")
save("economic_parameters.mat","Cost","T_true","Date_t0")
% save figure
savefig(demand_fig,'..\figure\case_demand.fig');
exportgraphics(demand_fig,'..\figure\case_demand.pdf')
savefig(inventory_fig,'..\figure\case_inventory.fig');
exportgraphics(inventory_fig,'..\figure\case_inventory.pdf')
