clear;
close all;

t = 0;
x = 12;

while x<100
    nbases = floor(x(end)/22)+1;
    t(end+1) = t(end) + 12;
    x(end+1) = x(end) + nbases;
end

t = t(1:(end-1));
x = x(1:(end-1));

nbases = floor(x/22) + 1;

figure;
ax = plotyy(t/60,x,t/60,nbases);
xlabel('Game Time (min)');
xlim(ax(1),[min(t) max(t)]/60);
xlim(ax(2),[min(t) max(t)]/60);
ylim(ax(1),[12 max(x)]);
ylim(ax(2),[1 4]);
ylabel(ax(1),'SCV Count');
ylabel(ax(2),'Number of Bases');
set(ax(1),'xtick',[0 1 2 3 4 5 6 7]);
set(ax(1),'ytick',[15 20 25 30 35 40 45 50 55 60 65 70 75 80 85 90 95]);
set(ax(2),'ytick',[0 1 2 3 4]);
