function v = iP()
  persistent vInitialized;
  if isempty(vInitialized)
    vInitialized = CoolPropMATLAB_wrap(0, 23);
  end
  v = vInitialized;
end
