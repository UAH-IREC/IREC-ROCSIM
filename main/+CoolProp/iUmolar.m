function v = iUmolar()
  persistent vInitialized;
  if isempty(vInitialized)
    vInitialized = CoolPropMATLAB_wrap(0, 33);
  end
  v = vInitialized;
end
