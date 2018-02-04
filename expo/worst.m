clear;
close all;

t = 0;
x = 12;

%first_expotiming = 0;       % "Perfect"
%first_expotiming = 60 + 71; % CC First
%first_expotiming = 60 + 45 + 71; % Reaper Expo
%first_expotiming = 3*60 + 30 + 71; % Cloakshee
first_expotiming = 3*60 + 30 + 71; % Cloakshee

while x<100
    % Firxt Expo Constraint
    if( t(end) < first_expotiming+25 )
        production = 1;
    else
        % Calculate number of bases
        bases = floor(x/22) + 1;
        bases( t<first_expotiming ) = 1;

        % Find time of last CC completion
        idx = find(diff( bases ),1,'last');

        if( isempty(idx) )
            production = 1;
        else
            production = bases(end);
            tidx = t(idx) + 12 + 25;
            if( t(end) < tidx )
                production = production - 1;
            end
        end
    end

    t(end+1) = t(end) + 12;
    x(end+1) = x(end) + production;
end

t = t(1:(end-1));
x = x(1:(end-1));

nbases = floor(x/22) + 1;
nbases( t<first_expotiming ) = 1;

% Get Expo Times
texp = t( find(diff(nbases)) )+12-71;
for i=1:length(texp)
    fprintf('Expo %d at %02d:%02d\n',i+1,floor(texp(i)/60),mod(texp(i),60));
end

figure('Position',[ 902  -327   931   634 ]);
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
grid;
