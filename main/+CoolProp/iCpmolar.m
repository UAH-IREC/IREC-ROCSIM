function v = iCpmolar()
  persistent vInitialized;
  if isempty(vInitialized)
    vInitialized = CoolPropMATLAB_wrap(0, 30);
  end
  v = vInitialized;
end
