function test_db
  test_db = 'test.db';
  clear_db

  temperatures = [Constants.T_crit]
  chi_values = [2, 4]
  tolerances = [1e-2, 1e-3];
  N_values = [50, 100];

  fixed_tolerance_sim = FixedToleranceSimulation(temperatures, chi_values, tolerances);
  fixed_tolerance_sim.DATABASE = 'test.db';
  fixed_tolerance_sim = fixed_tolerance_sim.run;

  function clear_db
    sqlite3.open(test_db);
    sqlite3.execute('delete from tensors;');
    sqlite3.close(test_db);
  end
end
