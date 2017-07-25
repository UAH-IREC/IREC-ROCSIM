function v = iGWP20()
  persistent vInitialized;
  if isempty(vInitialized)
    vInitialized = CoolPropMATLAB_wrap(0, 67);
  end
  v = vInitialized;
end
