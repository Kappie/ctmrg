function [C, T, convergence] = calculate_environment(obj, temperature, chi, N, initial_C, initial_T)
  C = initial_C;
  T = initial_T;
  singular_values = obj.initial_singular_values(chi);

  for iteration = 1:N
    singular_values_old = singular_values;
    [C, T, singular_values] = grow_lattice(temperature, chi, C, T);
  end

  convergence = calculate_convergence(singular_values, singular_values_old, chi)
end
