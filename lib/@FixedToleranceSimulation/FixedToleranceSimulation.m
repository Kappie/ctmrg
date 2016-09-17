classdef FixedToleranceSimulation < Simulation
  properties
    tolerances;
    MAX_ITERATIONS = 1e5;
  end

  methods
    function obj = FixedToleranceSimulation(temperatures, chi_values, tolerances)
      obj = obj@Simulation(temperatures, chi_values);
      obj.tolerances = tolerances;
      obj.run();
    end
  end
end
