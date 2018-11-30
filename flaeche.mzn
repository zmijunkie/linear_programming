% we solve a small mathematical problem
% we assume int values


% "decision variable" : stands for the (unknown) 
var int: x;

% some values
var int: flaeche_rechteck_oben_nach_unten;
var int: flaeche_rechteck_links_nach_rechts;
 
constraint flaeche_rechteck_oben_nach_unten   == flaeche_rechteck_links_nach_rechts;
constraint flaeche_rechteck_oben_nach_unten   == (x+8)*(x+8);
constraint flaeche_rechteck_links_nach_rechts == x*(x+20);

solve satisfy;
output [ show(x) ++ "\n"];

% solution: 16