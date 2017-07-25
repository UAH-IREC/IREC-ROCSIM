function v = iT_critical()
  persistent vInitialized;
  if isempty(vInitialized)
    vInitialized = CoolPropMATLAB_wrap(0, 10);
  end
  v = vInitialized;
end
