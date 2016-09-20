function markerplot(x_values, y_matrix, axis_scale)
  if ~exist('axis_scale', 'var')
    handles = plot(x_values, y_matrix);
  else
    if strcmp(axis_scale, 'semilogx')
      handles = semilogx(x_values, y_matrix);
    elseif strcmp(axis_scale, 'semilogy')
      handles = semilogy(x_values, y_matrix);
    elseif strcmp(axis_scale, 'loglog')
      handles = loglog(x_values, y_matrix);
    end
  end

  set_markers(handles);
end
