function v = iP_triple()
  persistent vInitialized;
  if isempty(vInitialized)
    vInitialized = CoolPropMATLAB_wrap(0, 16);
  end
  v = vInitialized;
end
