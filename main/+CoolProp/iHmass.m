function v = iHmass()
  persistent vInitialized;
  if isempty(vInitialized)
    vInitialized = CoolPropMATLAB_wrap(0, 37);
  end
  v = vInitialized;
end
