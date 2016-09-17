classdef Util
  methods(Static)
    function C = spin_up_initial_C(temperature)
      spin_up_tensor = corner_delta();
      spin_up_tensor(2, 2) = 0;
      P = construct_P(temperature);
      C = ncon({P, P, spin_up_tensor}, {[-1 1], [-2 2], [1 2]});
    end

    function T = spin_up_initial_T(temperature)
      spin_up_tensor = edge_delta();
      spin_up_tensor(2, 2, 2) = 0;
      P = construct_P(temperature);
      T = ncon({P, P, P, spin_up_tensor}, {[-1 1], [-2 2], [-3 3], [1 2 3]});
    end

    function a = construct_a(temperature)
      delta = construct_delta();
      P = construct_P(temperature);
      a = ncon({P, P, P, P, delta}, {[-1, 1], [-2, 2], [-3, 3], [-4, 4], [1, 2, 3, 4]});
    end

    function delta = construct_delta()
      delta = zeros(2, 2, 2, 2);
      delta(1, 1, 1, 1) = 1;
      delta(2, 2, 2, 2) = 1;
    end

    function delta = edge_delta()
      delta = zeros(2, 2, 2);
      delta(1, 1, 1) = 1;
      delta(2, 2, 2) = 2;
    end

    function delta = corner_delta()
      delta = zeros(2, 2);
      delta(1, 1) = 1;
      delta(2, 2) = 1;
    end

    function P = construct_P(temperature)
      % We need square root of a matrix here, not the square root of the elements!
      P = sqrtm(construct_Q(temperature));
    end

    function Q = construct_Q(temperature)
      Q = [exp((1/temperature)*Constants.J) exp(-(1/temperature)*Constants.J); exp(-(1/temperature)*Constants.J) exp((1/temperature)*Constants.J)];
    end

    function [C, T] = deserialize_tensors(record)
      C = getArrayFromByteStream(record.c);
      T = getArrayFromByteStream(record.t);
    end
  end
end
