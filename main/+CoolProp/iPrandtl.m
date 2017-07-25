function v = iPrandtl()
  persistent vInitialized;
  if isempty(vInitialized)
    vInitialized = CoolPropMATLAB_wrap(0, 47);
  end
  v = vInitialized;
end
