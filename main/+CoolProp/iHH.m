function v = iHH()
  persistent vInitialized;
  if isempty(vInitialized)
    vInitialized = CoolPropMATLAB_wrap(0, 71);
  end
  v = vInitialized;
end
