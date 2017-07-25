function v = iHmolar()
  persistent vInitialized;
  if isempty(vInitialized)
    vInitialized = CoolPropMATLAB_wrap(0, 28);
  end
  v = vInitialized;
end
