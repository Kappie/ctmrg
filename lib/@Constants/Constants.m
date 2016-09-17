classdef Constants
  properties(Constant)
    J = 1;
    T_crit = 2.269185314213022;
    BASE_DIR = fullfile(fileparts(mfilename('fullpath')), '..', '..');
    DB_DIR = fullfile(Constants.BASE_DIR, 'db');
  end
end
