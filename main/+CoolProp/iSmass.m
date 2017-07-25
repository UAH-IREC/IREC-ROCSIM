function v = iSmass()
  persistent vInitialized;
  if isempty(vInitialized)
    vInitialized = CoolPropMATLAB_wrap(0, 38);
  end
  v = vInitialized;
end
