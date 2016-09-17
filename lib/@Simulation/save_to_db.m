function obj = save_to_db(obj, temperature, chi, N, convergence, C, T)
  if obj.SAVE_TO_DB
    sqlite3.execute('INSERT INTO tensors (temperature, chi, n, convergence, c, t) VALUES (?, ?, ?, ?, ?, ?)', ...
      temperature, chi, N, convergence, getByteStreamFromArray(C), getByteStreamFromArray(T));
    display('I put stuff into the DB.')
  end
end
