function v = iT_reducing()
  persistent vInitialized;
  if isempty(vInitialized)
    vInitialized = CoolPropMATLAB_wrap(0, 9);
  end
  v = vInitialized;
end
