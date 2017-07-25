function v = iisobaric_expansion_coefficient()
  persistent vInitialized;
  if isempty(vInitialized)
    vInitialized = CoolPropMATLAB_wrap(0, 50);
  end
  v = vInitialized;
end
