function values = compute(obj, quantity)
  values = obj.compute_for_every_combination(quantity, obj.temperatures, obj.chi_values, obj.N_values);
  % automatically squeeze out singleton dimensions for convenience
  values = squeeze(values);
end
