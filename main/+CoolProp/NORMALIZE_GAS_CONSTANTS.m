function v = NORMALIZE_GAS_CONSTANTS()
  persistent vInitialized;
  if isempty(vInitialized)
    vInitialized = CoolPropMATLAB_wrap(0, 132);
  end
  v = vInitialized;
end
