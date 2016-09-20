function main
  rehash;

  sim = FixedNSimulation([Constants.T_crit], [2], [100, 200]);
  sim.LOAD_FROM_DB = false;
  sim.SAVE_TO_DB = false;
  sim.run();

end
