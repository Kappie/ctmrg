function tensor_struct = find_or_calculate_environment(obj, temperature, chi, tolerance)
  % I look for all records with the same temperature, lesser or equal chi and greater or equal tolerance.
  % If I find an exact match (same temperature, chi, tolerance as I'm trying to simulate)
  % I do not simulate again.
  % If I find a record with matching temperature and lesser chi or higher tolerance (highest chi takes precedence)
  % I select the C, T from that record to use as initial C, T for the new simulation.

  query = ['SELECT * ' ...
    'FROM tensors ' ...
    'WHERE temperature = ? AND chi <= ? AND convergence >= ? ' ...
    'ORDER BY chi DESC, convergence ASC ' ...
    'LIMIT 1'];
  query_result = sqlite3.execute(query, temperature, chi, tolerance);

  if isempty(query_result) || ~obj.LOAD_FROM_DB
    display('Did not find a matching record.');
    initial_C = spin_up_initial_C(temperature);
    initial_T = spin_up_initial_T(temperature);
    [C, T, convergence, N, converged] = obj.calculate_environment(temperature, chi, tolerance, initial_C, initial_T);
    simulated = true;
  else
    if query_result.chi == chi & query_result.convergence == tolerance
      display('Found a matching record.')
      [C, T] = Util.deserialize_tensors(query_result);
      simulated = false;
    else
      display('Found a record with lower chi and higher tolerance to use as initial condition')
      [initial_C, initial_T] = Util.deserialize_tensors(query_result);
      [C, T, convergence, N, converged] = obj.calculate_environment(temperature, chi, tolerance, initial_C, initial_T);
      simulated = true;
    end
  end

  if simulated && converged
    obj.save_to_db(temperature, chi, N, tolerance, C, T);
  end

  tensor_struct = struct('C', C, 'T', T);
end
