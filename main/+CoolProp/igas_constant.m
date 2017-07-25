function v = igas_constant()
  persistent vInitialized;
  if isempty(vInitialized)
    vInitialized = CoolPropMATLAB_wrap(0, 4);
  end
  v = vInitialized;
end
