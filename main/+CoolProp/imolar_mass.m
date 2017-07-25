function v = imolar_mass()
  persistent vInitialized;
  if isempty(vInitialized)
    vInitialized = CoolPropMATLAB_wrap(0, 5);
  end
  v = vInitialized;
end
