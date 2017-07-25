function v = irhomolar_reducing()
  persistent vInitialized;
  if isempty(vInitialized)
    vInitialized = CoolPropMATLAB_wrap(0, 7);
  end
  v = vInitialized;
end
