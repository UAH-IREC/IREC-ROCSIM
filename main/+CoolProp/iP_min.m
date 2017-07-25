function v = iP_min()
  persistent vInitialized;
  if isempty(vInitialized)
    vInitialized = CoolPropMATLAB_wrap(0, 20);
  end
  v = vInitialized;
end
