function data_collapse_chi
  temperature_width = 0.01;
  temperatures = linspace(Constants.T_crit - temperature_width, Constants.T_crit + temperature_width, 9);
  % temperatures_zoom = linspace(Constants.T_crit - temperature_width/10, Constants.T_crit + temperature_width/10, 9);
  % temperatures_zoom_further = linspace(Constants.T_crit - temperature_width/100,  ...
  %   Constants.T_crit + temperature_width/100, 9);
  % temperatures = [temperatures temperatures_zoom temperatures_zoom_further];
  chi_values = 2:2:16;
  % tolerance = 1e-7 is safe (see plot)
  tolerances = [1e-7];

  sim = FixedToleranceSimulation(temperatures, chi_values, tolerances);
  sim.LOAD_FROM_DB = false; sim.SAVE_TO_DB = false;
  sim = sim.run();
  order_parameters = sim.compute(OrderParameter);
  correlation_lengths = sim.compute(CorrelationLength);

  sort(correlation_lengths(:))

  % DO DATA COLLAPSE
  % Critical exponents
  % nu = 1, but we leave it out altogether.
  beta = 1/8;
  MARKERS = markers();

  figure
  hold on

  for c = 1:numel(chi_values)
    x_values = zeros(1, numel(temperatures));
    scaling_function_values = zeros(1, numel(temperatures));

    for t = 1:numel(temperatures)
      x_values(t) = reduced_T(temperatures(t)) * correlation_lengths(t, c);
      scaling_function_values(t) = order_parameters(t, c) * correlation_lengths(t, c)^beta;
    end

    plot(x_values, scaling_function_values, MARKERS(mod(c, numel(MARKERS)) + 1));
  end

  make_legend(chi_values, 'chi')
  xlabel('$t\xi(\chi, t)^{1/\nu}$');
  ylabel('$m(t, \chi)\xi(\chi,t)^{\beta/\nu}$')


  function t = reduced_T(T)
    t = (T - Constants.T_crit) / Constants.T_crit;
  end
end