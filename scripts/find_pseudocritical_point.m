function find_pseudocritical_point
  chi_values = [16, 24, 32];
  tolerance = 1e-8;
  t_width = 0.3;

  t_stars = zeros(1, numel(chi_values));
  corr_lengths = zeros(1, numel(chi_values));
  negative_xi = @(temperature, chi, tolerance) -1 * calculate_correlation_length(temperature, chi, tolerance);
  options = optimset('Display', 'iter', 'TolX', 1e-5);

  for c = 1:numel(chi_values)
    optim_func = @(temperature) negative_xi(temperature, chi_values(c), tolerance);
    [t_star, corr_length] = fminbnd(optim_func, ...
      Constants.T_crit - t_width, Constants.T_crit + t_width, options);

    t_stars(c) = t_star;
    corr_lengths(c) = corr_length;
  end

  save('t_stars_chi16-24-32_tol1e-8_TolX1e-5.mat', 'chi_values', 't_stars', 'corr_lengths')

end

function xi = calculate_correlation_length(temperature, chi, tolerance)
  if temperature < 0
    xi = 0;
  elseif temperature > 20
    error('hou maar op')
  else
    sim = FixedToleranceSimulation([temperature], [chi], [tolerance]).run();
    xi = sim.compute(CorrelationLength);
  end
end
