classdef Simulation
% SIMULATION Abstract base class.
%   See also FixedNSimulation, FixedToleranceSimulation.
  properties
    temperatures;
    chi_values;
  end

  methods
    function obj = Simulation(temperatures, chi_values)
      obj.temperatures = temperatures;
      obj.chi_values   = chi_values;
      obj.run()
    end
  end
end
