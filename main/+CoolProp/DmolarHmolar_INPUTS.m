function v = DmolarHmolar_INPUTS()
  persistent vInitialized;
  if isempty(vInitialized)
    vInitialized = CoolPropMATLAB_wrap(0, 127);
  end
  v = vInitialized;
end
