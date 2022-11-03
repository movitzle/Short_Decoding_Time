% Script containing all code to generate figure 2b. Note multiple Sections
%% Run plot 2b for amplitudes 

clear all
close all
color = [0.35    0.54    0.69;
    0.92    0.28    0.29;
    0.44    0.75    0.43;
    1.00    0.60    0.20];

nBins = 100;


figure;
hold on
load('./Results/workspace_D_2_b_0_xi_1_L_5.mat')
[hist_val,edges] = histcounts(amps(:), nBins);
max_edge = max(edges);
min_edge = min(edges);
plot([edges(1),repelem(edges(2:end-1),1,2),edges(end)], repelem(hist_val,1,2)/sum(hist_val),'LineWidth',1.5,'Color',color(3,:));

load('./Results/workspace_D_2_b_0_xi_2_L_5.mat')
[hist_val,edges] = histcounts(amps(:), nBins);
max_edge = max(max_edge, max(edges));
min_edge = min(min_edge, min(edges));
plot([edges(1),repelem(edges(2:end-1),1,2),edges(end)], repelem(hist_val,1,2)/sum(hist_val),'LineWidth',1.5,'Color',color(4,:));

xlabel('Maximal firing rate, a (sp/s)','Interpreter','latex','fontsize',20)
ylabel('Normalized distribution','Interpreter','latex','fontsize',20)
ylim([0,0.6])
xlim([min_edge, max_edge])
xticks([10,20,30,40])
yticks([0,0.2,0.4,0.6])
x0 = 100;
y0 = 100;
width = 300;
height = 225;

set(gcf,'position',[x0,y0,width,height])
set(gca,'fontsize',12)

save_to = './Results/';
name = 'Fig2b_dist_amps_D_2';

save_figure(save_to, name, gcf)

figure;

load('./Results/workspace_D_1_b_0_xi_1_L_5.mat')
nBins = 100;
[hist_val,edges] = histcounts(amps(:), nBins);
plot([edges(1),repelem(edges(2:end-1),1,2),edges(end)], repelem(hist_val,1,2)/sum(hist_val),'LineWidth',1.5,'Color',color(1,:));
hold on

load('./Results/workspace_D_1_b_0_xi_2_L_5.mat')
[hist_val,edges] = histcounts(amps(:), nBins);
plot([edges(1),repelem(edges(2:end-1),1,2),edges(end)], repelem(hist_val,1,2)/sum(hist_val),'LineWidth',1.5,'Color',color(2,:));
xlabel('Maximal firing rate, a (sp/s)','Interpreter','latex','fontsize',20)
ylabel('Normalized distribution','Interpreter','latex','fontsize',20)
ylim([0,0.6])
xlim([min_edge, max_edge])
%xticks([12,16,20,24,28,32])
xticks([10,20,30,40])
yticks([0,0.2,0.4,0.6])
x0 = 100;
y0 = 100;
width = 300;
height = 225;

set(gcf,'position',[x0,y0,width,height])
set(gca,'fontsize',12)


save_to = './Results/';
name = 'Fig2b_dist_amps_D_1';

save_figure(save_to, name, gcf)


%% Fig 2b empirical rates
clear all

color = [0.35    0.54    0.69;
    0.92    0.28    0.29;
    0.44    0.75    0.43;
    1.00    0.60    0.20];
load params.mat N c
r_mean = zeros(4,length(c),N);
load('./Results/workspace_D_1_b_0_xi_1_L_5.mat')


for i=1:14
    r_mean(1,i,:) = mean(cell2mat(r(i)))/T_th(i);
end
load('./Results/workspace_D_1_b_0_xi_2_L_5.mat')
for i=2:14 % c = 1 not included in simulation
    r_mean(2,i,:) = mean(cell2mat(r(i-1)))/T_th(i-1);
end
load('./Results/workspace_D_2_b_0_xi_1_L_5.mat')
for i=1:14
    r_mean(3,i,:) = mean(cell2mat(r(i)))/T_th(i);
end

load('./Results/workspace_D_2_b_0_xi_2_L_5.mat')
for i=2:14 % c = 1 not included in simulation
    r_mean(4,i,:) = mean(cell2mat(r(i-1)))/T_th(i-1);
end


figure;
nBins = 100;
binWidth = 0.05;
[hist_val,edges] = histcounts(r_mean(1,:), 'BinWidth',binWidth);
plot([edges(1),repelem(edges(2:end-1),1,2),edges(end)], repelem(hist_val,1,2)/sum(hist_val),'LineWidth',1.5,'Color',color(1,:));
hold on
[hist_val,edges] = histcounts(r_mean(2,2:end,:), 'BinWidth',binWidth);
plot([edges(1),repelem(edges(2:end-1),1,2),edges(end)], repelem(hist_val,1,2)/sum(hist_val),'LineWidth',1.5,'Color',color(2,:));

xlabel('Empirical average firing rate (sp/s)','Interpreter','latex','fontsize',20)
ylabel('Normalized distribution','Interpreter','latex','fontsize',20)
ylim([0,0.1])
xlim([0,8])
xticks([0,2,4,6,8])
yticks([0,0.02,0.04,0.06,0.08,0.1])
x0 = 100;
y0 = 100;
width = 300;
height = 260;
width = 300;
height = 225;
set(gcf,'position',[x0,y0,width,height])
set(gca,'fontsize',12)

save_to = './Results/';
name = 'Fig_2b_av_rates_D_1';

save_figure(save_to, name, gcf)



figure;
nBins = 100;
binWidth = 0.02;
[hist_val,edges] = histcounts(r_mean(3,1:end,:), 'BinWidth', binWidth);
plot([edges(1),repelem(edges(2:end-1),1,2),edges(end)], repelem(hist_val,1,2)/sum(hist_val),'LineWidth',1.5,'Color',color(3,:));
hold on
[hist_val,edges] = histcounts(r_mean(4,2:end,:), 'BinWidth', binWidth);
plot([edges(1),repelem(edges(2:end-1),1,2),edges(end)], repelem(hist_val,1,2)/sum(hist_val),'LineWidth',1.5,'Color',color(4,:));

xlabel('Empirical average firing rate (sp/s)','Interpreter','latex','fontsize',20)
ylabel('Normalized distribution','Interpreter','latex','fontsize',20)
ylim([0,0.1])
xlim([0,8])
xticks([0,2,4,6,8])
yticks([0,0.02,0.04,0.06,0.08,0.1])
x0 = 100;
y0 = 100;
width = 300;
height = 260;
width = 300;
height = 225;
set(gcf,'position',[x0,y0,width,height])
set(gca,'fontsize',12)

save_to = './Results/';
name = 'Fig_2b_av_rates_D_2';
save_figure(save_to, name, gcf)