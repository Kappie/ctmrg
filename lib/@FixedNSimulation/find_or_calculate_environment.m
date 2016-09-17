function obj = find_or_calculate_environment(obj, temperature, chi, N)
  % Checks if converged tensors are already in the database.
  % If tensors already exist, do nothing.
  % If tensors with same temperature and chi, but with lower N exist,
  % use those as a starting point and add the remaining N.

  query = ['SELECT * ' ...
    'FROM tensors ' ...
    'WHERE temperature = ? AND chi = ? AND n <= ? ' ...
    'ORDER BY n DESC ' ...
    'LIMIT 1'];
  found_record = sqlite3.execute(query, temperature, chi, N);

  if isempty(found_record)
    iterations_remaining = N;
    initial_C = obj.initial_C(temperature);
    initial_T = obj.initial_T(temperature);
    [C, T, convergence] = calculate_environment(temperature, chi, iterations_remaining, initial_C, initial_T);
  else
    iterations_remaining = N - found_record.N;
    if iterations_remaining > 0
      [initial_C, initial_T] = Util.deserialize_tensors(found_record);
      [C, T, convergence] = calculate_environment(temperature, chi, iterations_remaining, initial_C, initial_T)
    end
  end

  if iterations_remaining > 0
    obj.save_to_db(temperature, chi, N, convergence, C, T);
  end
end
