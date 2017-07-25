function v = iP_critical()
  persistent vInitialized;
  if isempty(vInitialized)
    vInitialized = CoolPropMATLAB_wrap(0, 13);
  end
  v = vInitialized;
end
