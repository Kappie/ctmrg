classdef (Abstract) Simulation
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
    end
  end

  methods(Abstract)
    run(obj)
  end

  methods(Static)
    % I put grow_lattice in a separate file grow_lattice.m with helper functions, so I have
    % to declare it here in order to make it Static (otherwise it would be public).
    [C, T, singular_values] = grow_lattice(temperature, chi, C, T);

    function C = initial_C(temperature)
      C = Util.spin_up_initial_C(temperature);
    end

    function T = initial_T(temperature)
      T = Util.spin_up_initial_T(temperature);
    end

    function s = initial_singular_values(chi)
      s = ones(chi, 1) / chi;
    end

    function c = calculate_convergence(singular_values, singular_values_old, chi)
      % TODO: something weird happened last time: when calculating correlation length
      % for T >> Tc, I found that the T tensor did not have the right dimension.

      % Sometimes it happens that the current singular values vector is smaller
      % than the old one, because MATLAB's svd procedure throws away excessively
      % small singular values. The code below adds zeros to singular_values to match
      % the dimension of singular_values_old.
      if size(singular_values, 1) < chi
        singular_values(chi) = 0;
      end

      % If chi_init is small enough, the bond dimension of C and T will not exceed
      % chi for the first few steps.
      if size(singular_values_old, 1) < chi
        singular_values_old(chi) = 0;
      end

      c = sum(abs(singular_values - singular_values_old));
    end

    function obj = save_to_db(temperature, chi, N, convergence, C, T)
      if Constants.SAVE_TO_DB
        sqlite3.execute('INSERT INTO tensors (temperature, chi, n, convergence, c, t) VALUES (?, ?, ?, ?, ?, ?)', ...
          temperature, chi, N, convergence, getByteStreamFromArray(C), getByteStreamFromArray(T));
      end
    end
  end
end
