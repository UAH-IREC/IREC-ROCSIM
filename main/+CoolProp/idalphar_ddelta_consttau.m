function v = idalphar_ddelta_consttau()
  persistent vInitialized;
  if isempty(vInitialized)
    vInitialized = CoolPropMATLAB_wrap(0, 54);
  end
  v = vInitialized;
end
