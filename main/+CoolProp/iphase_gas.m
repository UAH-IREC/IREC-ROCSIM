function v = iphase_gas()
  persistent vInitialized;
  if isempty(vInitialized)
    vInitialized = CoolPropMATLAB_wrap(0, 81);
  end
  v = vInitialized;
end
