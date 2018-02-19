clear;
close all;

%%%%%%% INPUTS %%%%%%%

bases    = 4;
orbitals = 3;
gas      = 8;

% Command Center Units
scv       = bases; %(Constant Worker Production)
%scv       = 0;     %(Stop Worker Production)

% Barracks Units
reaper    = 0;
marine    = 15;
marauder  = 0;
ghost     = 0;

% Factory Units
hellion   = 0;
seigetank = 2;
mine      = 0;
thor      = 0;
cyclone   = 0;

% Starport Units
medivac       = 0;
viking        = 0;
liberator     = 0;
raven         = 3;
banshee       = 0;
battlecruiser = 0;

% Unit Production Counts
units = [
    scv
    reaper   
    marine   
    marauder 
    ghost    
    hellion  
    seigetank
    mine     
    thor     
    cyclone  
    medivac  
    viking   
    liberator
    raven
    banshee
    battlecruiser
];

[ surplus_nodepot surplus_gas surplus_depot unit_comp ] ...
    = calcProd(bases,orbitals,gas,units);

fprintf('Bases    = %d\nOrbitals = %d\nGas      = %d\n',bases,orbitals,gas);
fprintf('Surplus Gas              = %10f\n', surplus_gas);
fprintf('Surplus Minerals Remax   = %10f\n', surplus_nodepot);
fprintf('Surplus Minerals Buildup = %10f\n', surplus_depot);
fprintf('Unit Composition\n');

names = [
    'Reaper       '
    'Marine       '
    'Marauder     '
    'Ghost        '
    'Hellion      '
    'Seige Tank   '
    'Window Mine  '
    'Thor         '
    'Cyclone      '
    'Medivac      '
    'Viking       '
    'Liberator    '
    'Raven        '
    'Banshee      '
    'Battlecruiser'
];
unit_comp = unit_comp./min(unit_comp(unit_comp>0));
for i=1:length(unit_comp)
    if( unit_comp(i)>0 )
        fprintf(['    ' names(i,:) ' : ' num2str(unit_comp(i),'%04.1f') ' (' num2str(units(i+1)) ')\n']);
    end
end
