function v = ALTERNATIVE_REFPROP_PATH()
  persistent vInitialized;
  if isempty(vInitialized)
    vInitialized = CoolPropMATLAB_wrap(0, 137);
  end
  v = vInitialized;
end
