function v = iGmolar()
  persistent vInitialized;
  if isempty(vInitialized)
    vInitialized = CoolPropMATLAB_wrap(0, 34);
  end
  v = vInitialized;
end
