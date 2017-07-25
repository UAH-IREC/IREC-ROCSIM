function v = iP_max()
  persistent vInitialized;
  if isempty(vInitialized)
    vInitialized = CoolPropMATLAB_wrap(0, 19);
  end
  v = vInitialized;
end
