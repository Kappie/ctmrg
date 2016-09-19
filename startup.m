addpath(genpath('./dependencies/'));
addpath('./lib/');
addpath('./scripts');

set(groot, 'DefaultAxesTickLabelInterpreter', 'latex');
set(groot, 'DefaultLegendInterpreter', 'latex');

mathematica_colors = [ ...
  0.368417, 0.506779, 0.709798;
  0.880722, 0.611041, 0.142051;
  0.560181, 0.691569, 0.194885;
  0.922526, 0.385626, 0.209179;
  0.528488, 0.470624, 0.701351;
  0.772079, 0.431554, 0.102387;
  0.363898, 0.618501, 0.782349;
  1, 0.75, 0;
  0.647624, 0.37816, 0.614037;
  0.571589, 0.586483, 0.;
  0.915, 0.3325, 0.2125;
  0.400822, 0.522007, 0.85;
  0.972829, 0.621644, 0.073362;
  0.736783, 0.358, 0.503027;
  0.280264, 0.715, 0.429209];

set(gca,'DefaultAxesColorOrder', mathematica_colors);

format long;