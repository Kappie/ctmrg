classdef Constants
  properties(Constant)
    BASE_DIR = fullfile(fileparts(mfilename('fullpath')), '..', '..');
    DATABASE = fullfile(Constants.BASE_DIR, 'db', 'tensors.db');
    LOAD_FROM_DB = true;
    SAVE_TO_DB = true;

    J = 1;
    T_crit = 2.269185314213022;
  end
end
