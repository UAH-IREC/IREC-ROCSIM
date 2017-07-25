function v = iPH()
  persistent vInitialized;
  if isempty(vInitialized)
    vInitialized = CoolPropMATLAB_wrap(0, 72);
  end
  v = vInitialized;
end
