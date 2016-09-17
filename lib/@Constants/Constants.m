classdef Constants
  properties(Constant)
    BASE_DIR = fullfile(mfilename('fullpath'), '..', '..');
    DATABASE = fullfile(Constants.BASE_DIR, 'db', 'tensors.db');
    SAVE_TO_DB = true;
    J = 1;
  end
end
