function v = iphase_twophase()
  persistent vInitialized;
  if isempty(vInitialized)
    vInitialized = CoolPropMATLAB_wrap(0, 82);
  end
  v = vInitialized;
end
