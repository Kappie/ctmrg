function obj = run(obj)
  sqlite3.open(Constants.DATABASE);

  for temperature = obj.temperatures
    for chi = obj.chi_values
      for N  = obj.N_values
        obj.find_or_calculate_environment(temperature, chi, N);
      end
    end
  end

  sqlite3.close(Constants.DATABASE);
end
