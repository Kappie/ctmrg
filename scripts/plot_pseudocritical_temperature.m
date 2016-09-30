function plot_pseudocritical_temperature
  chi_values = [4, 6, 8, 16, 24, 32];
  pseudocritical_temps = [];

  for filename = {'t_stars_chi4-8_TolX1e-5.mat', 't_stars_chi16-24-32_TolX1e-5.mat'}
    filename = filename{1};
    result = load(filename);
    pseudocritical_temps = [pseudocritical_temps result.t_stars];
  end

  save('temp.mat','pseudocritical_temps')

  markerplot(chi_values, pseudocritical_temps)
  hline(Constants.T_crit, '--', '$T_{c}^{\infty}$')
  xlabel('$\chi$')
  ylabel('$T_{c}^{\chi}$')
end
