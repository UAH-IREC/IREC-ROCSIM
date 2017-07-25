function v = iundefined_parameter()
  persistent vInitialized;
  if isempty(vInitialized)
    vInitialized = CoolPropMATLAB_wrap(0, 75);
  end
  v = vInitialized;
end
