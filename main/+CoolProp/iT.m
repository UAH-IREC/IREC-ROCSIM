function v = iT()
  persistent vInitialized;
  if isempty(vInitialized)
    vInitialized = CoolPropMATLAB_wrap(0, 22);
  end
  v = vInitialized;
end
