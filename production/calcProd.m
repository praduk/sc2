function [ surplus_nodepot surplus_gas surplus_depot unit_comp ] = calcProd(bases,orbitals,gas,units)

%clear;
%close all;

%%%%%%% INPUTS %%%%%%%

%bases    = 3;
%orbitals = 3;
%gas      = 6;
%
%% Command Center Units
%scv       = bases; %(Constant Worker Production)
%%scv       = 0;     %(Stop Worker Production)
%
%%Barracks Units
%reaper    = 0;
%marine    = 0;
%marauder  = 0;
%ghost     = 0;
%
%%Factory Units
%hellion   = 0;
%seigetank = 0;
%mine      = 0;
%thor      = 0;
%cyclone   = 0;
%
%%Starport Units
%medivac       = 0;
%viking        = 0;
%liberator     = 0;
%raven         = 0;
%banshee       = 0;
%battlecruiser = 0;

%%%%%%%%%%%%% Unit Cost Configuration %%%%%%%%%%%%%%%

cost_depot = 100/21/8; % Depot (minerals/sec/supply)

% Unit Production Counts
%units = [
%    scv
%    reaper   
%    marine   
%    marauder 
%    ghost    
%    hellion  
%    seigetank
%    mine     
%    thor     
%    cyclone  
%    medivac  
%    viking   
%    liberator
%    raven
%    banshee
%    battlecruiser
%];

%names = [
%    'scv           '
%    'reaper        '
%    'marine        '
%    'marauder      '
%    'ghost         '
%    'hellion       '
%    'seigetank     '
%    'mine          '
%    'thor          '
%    'cyclone       '
%    'medivac       '
%    'viking        '
%    'liberator     '
%    'raven         '
%    'banshee       '
%    'battlecruiser '
%];


% Unit Production Costs
cost_supply = [
    1 % scv
    1 % reaper   
    1 % marine   
    2 % marauder 
    2 % ghost    
    2 % hellion  
    3 % seigetank
    2 % mine     
    6 % thor     
    3 % cyclone  
    2 % medivac  
    2 % viking   
    3 % liberator
    2 % raven
    3 % banshee
    6 % battlecruiser
];

% Unit Production Costs
cost_minerals = [
   50 % scv
   50 % reaper   
   50 % marine   
  100 % marauder 
  200 % ghost    
  100 % hellion  
  150 % seigetank
   75 % mine     
  300 % thor     
  150 % cyclone  
  100 % medivac  
  150 % viking   
  150 % liberator
  100 % raven
  150 % banshee
  400 % battlecruiser
];

% Unit Production Costs
cost_gas = [
    0 % scv
   50 % reaper   
    0 % marine   
   25 % marauder 
  100 % ghost    
    0 % hellion  
  125 % seigetank
   25 % mine     
  200 % thor     
  100 % cyclone  
  100 % medivac  
   75 % viking   
  150 % liberator
  200 % raven
  100 % banshee
  300 % battlecruiser
];

% Unit Production Costs
cost_time = [
   12 % scv
   32 % reaper   
   18 % marine   
   21 % marauder 
   29 % ghost    
   21 % hellion  
   32 % seigetank
   29 % mine     
   43 % thor     
   32 % cyclone  
   30 % medivac  
   30 % viking   
   43 % liberator
   43 % raven
   43 % banshee
   64 % battlecruiser
];


%%%%%%%%%%%%% CALCULATIONS %%%%%%%%%%%%%%%

% Mineral Income (minerals/second)
inc_minerals = (912/60 + 225/64)*bases;
inc_gas = (162/60)*gas;

% Calculate Unit Composition
unit_comp = units(2:end)./cost_time(2:end);
unit_comp(units(2:end)==0) = 0;
unit_comp = unit_comp./sum(unit_comp);

% Divide All Costs by Time
use_minerals = cost_minerals./cost_time;
use_gas = cost_gas./cost_time;
use_supply = cost_supply./cost_time;

% Multiply All Costs by Number of Units
use_minerals = use_minerals.*units;
use_gas = use_gas.*units;
use_supply = use_supply.*units;

% Add Up All Costs
use_minerals = sum(use_minerals);
use_gas = sum(use_gas);
use_supply = sum(use_supply);

% Total All Costs
use_mineral_total_nodepot = use_minerals;
use_mineral_total_depot   = use_minerals + cost_depot*use_supply;
use_gas_total = use_gas;

% Calculate Surplus
surplus_nodepot = inc_minerals - use_mineral_total_nodepot;
surplus_depot   = inc_minerals - use_mineral_total_depot;
surplus_gas     = inc_gas      - use_gas_total;
