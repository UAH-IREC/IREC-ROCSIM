function v = CONFIGURATION_STRING_TYPE()
  persistent vInitialized;
  if isempty(vInitialized)
    vInitialized = CoolPropMATLAB_wrap(0, 150);
  end
  v = vInitialized;
end
