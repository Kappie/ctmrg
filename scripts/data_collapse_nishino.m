function data_collapse_nishino
  temperatures = [Constants.T_crit];
  chi_values = [4, 16, 32, 64];
  % chi_values = 4:13;
  tolerances = [1e-7];
  N_values = [20, 40, 60, 80, 100, 200, 300, 400, 500, 750, 1000, 1500, 2000, 2500, 3000, 3500, 4000, 4500, 5000, 6000, 7000, 8000, 10000, 12000, 14000, 16000, 18000, 20000, 22000, 24000, 30000, 40000, 50000, 60000];

  % Compute xi(chi)
  sim = FixedToleranceSimulation(temperatures, chi_values, tolerances).run();
  correlation_lengths = sim.compute(CorrelationLength);

  % Compute m(N, chi)
  sim = FixedNSimulation(temperatures, chi_values, N_values).run();
  order_parameters = sim.compute(OrderParameter);

  % DO DATA COLLAPSE
  beta = 1/8;

  figure
  hold on
  MARKERS = markers();

  for c = 1:numel(chi_values)
    x_values = numel(N_values);
    scaling_function_values = numel(N_values);

    for n = 1:numel(N_values)
      x_values(n) = correlation_lengths(c) / N_values(n);
      scaling_function_values(n) = order_parameters(c, n) * N_values(n)^beta;
    end

    plot(x_values, scaling_function_values, MARKERS(mod(c, numel(MARKERS)) + 1));
  end

  make_legend(chi_values, '\chi');
  xlabel('$\xi(\chi, t = 0) / N$')
  ylabel('$m(N, \chi, t = 0) N^{\beta/\nu}$')
  axis([0 0.2 0 5])
end
