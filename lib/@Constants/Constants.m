classdef Constants
  properties(Constant)
    J = 1;
    T_crit = 2.269185314213022;
    BASE_DIR = fullfile(fileparts(mfilename('fullpath')), '..', '..');
    DB_DIR = fullfile(Constants.BASE_DIR, 'db');
    PLOTS_DIR = '~/Documents/Natuurkunde/Scriptie/Plots/';
  end

  methods(Static)
    function T = T_pseudocrit(chi)
      pseudocritical_temps = [2.281203074810333, 2.274406982976446, 2.273518615263356, ...
        2.269918694241065, 2.269513820256367, 2.269410411882484];
      chi_values = [4, 6, 8, 16, 24, 32];
      map = containers.Map(chi_values, pseudocritical_temps);
      T = map(chi);
    end
  end
end
