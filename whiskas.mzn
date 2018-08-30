% we solve the whiskas blending problem
%

% parameter : maximum weight of all used ingredients
int: total_weight = 100;
array[1..6] of string: Ingredient = ["chicken", "beef", "mutton", "rice", "wheat", "gel"];
int: nr_ingredients = length(Ingredient);

% "decision variable" : stands for the (unknown) amount of ingredients
% in gramm to be used to fill the can
array[1..nr_ingredients] of var float: weight;

% cost of ingredient chicken, beef, mutton, rice, wheat, gel
array[1..nr_ingredients] of var float: cost= [0.013, 0.008, 0.010, 0.002, 0.005, 0.001]; 

% ingredient parameters
array[1..nr_ingredients] of var float: protein = [0.100, 0.200, 0.150, 0.000, 0.040, 0.000];
array[1..nr_ingredients] of var float: fat     = [0.080, 0.100, 0.110, 0.010, 0.010, 0.000];
array[1..nr_ingredients] of var float: fibre   = [0.001, 0.005, 0.003, 0.100, 0.150, 0.000];
array[1..nr_ingredients] of var float: salt    = [0.002, 0.005, 0.007, 0.002, 0.008, 0.000];
 
constraint forall (i in 1..nr_ingredients)(weight[i]  >= 0.0);
 
constraint sum (i in 1..nr_ingredients)(protein[i]*weight[i]) >= 8.0;
constraint sum (i in 1..nr_ingredients)(fat[i]*weight[i]) >= 6.0;
constraint sum (i in 1..nr_ingredients)(fibre[i]*weight[i]) <= 2.0;
constraint sum (i in 1..nr_ingredients)(salt[i]*weight[i]) <= 0.4;
constraint sum (i in 1..nr_ingredients)(weight[i]) ==total_weight;

% the objective
var 0.0..3.0 : total_cost = sum (i in 1..nr_ingredients) (cost[i] * weight[i])  ;
solve minimize total_cost;

output [ show(weight[i])++" "++Ingredient[i]++"\n" | i in 1..nr_ingredients];

% some datastructures learned from
% http://www.hakank.org/minizinc/restaurant_scheduling.mzn
% http://www.minizinc.org/doc-2.2.0/en/predicates.html (2.3.3)
% https://github.com/MiniZinc/MiniZincIDE/blob/master/MiniZincIDE/cheat_sheet.mzn
% https://github.com/hakank/hakank/blob/master/minizinc/blending.mzn
% The solution is: 60g beef, 40g gel