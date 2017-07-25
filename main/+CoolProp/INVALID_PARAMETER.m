function v = INVALID_PARAMETER()
  persistent vInitialized;
  if isempty(vInitialized)
    vInitialized = CoolPropMATLAB_wrap(0, 3);
  end
  v = vInitialized;
end
