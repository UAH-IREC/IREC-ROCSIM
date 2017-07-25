function v = irhomolar_critical()
  persistent vInitialized;
  if isempty(vInitialized)
    vInitialized = CoolPropMATLAB_wrap(0, 8);
  end
  v = vInitialized;
end
