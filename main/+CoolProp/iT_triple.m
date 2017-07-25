function v = iT_triple()
  persistent vInitialized;
  if isempty(vInitialized)
    vInitialized = CoolPropMATLAB_wrap(0, 15);
  end
  v = vInitialized;
end
