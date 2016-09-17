classdef (Abstract) Quantity
% Every quantity must respond to value_at(temperature, C, T).
% A quantity is computed by a simulated environment , like this:
% simulation = FixedNSimulation(temperatures, chi_values, N_values);
% simulation.compute(quantity)

  methods
    function obj = Quantity(temperatures, chi_values)
      obj;
    end
  end

  methods(Abstract)
    value = value_at(temperature, C, T);
  end
end
