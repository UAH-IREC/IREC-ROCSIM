function v = iT_min()
  persistent vInitialized;
  if isempty(vInitialized)
    vInitialized = CoolPropMATLAB_wrap(0, 17);
  end
  v = vInitialized;
end
