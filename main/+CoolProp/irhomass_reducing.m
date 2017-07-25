function v = irhomass_reducing()
  persistent vInitialized;
  if isempty(vInitialized)
    vInitialized = CoolPropMATLAB_wrap(0, 11);
  end
  v = vInitialized;
end
