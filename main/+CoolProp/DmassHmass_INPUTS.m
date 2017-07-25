function v = DmassHmass_INPUTS()
  persistent vInitialized;
  if isempty(vInitialized)
    vInitialized = CoolPropMATLAB_wrap(0, 126);
  end
  v = vInitialized;
end
