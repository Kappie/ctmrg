function obj = run(obj)
  sqlite3.open(obj.DATABASE);

  for temperature = obj.temperatures
    for chi = obj.chi_values
      for tolerance  = obj.tolerances
        % SEGFAULT HAPPENS WHEN I STEP INTO THIS FUNCTION. VERY BAD.
        obj.find_or_calculate_environment(temperature, chi, tolerance);
      end
    end
  end

  sqlite3.close(obj.DATABASE);
end
