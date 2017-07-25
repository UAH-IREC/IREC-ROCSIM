function v = INPUT_PAIR_INVALID()
  persistent vInitialized;
  if isempty(vInitialized)
    vInitialized = CoolPropMATLAB_wrap(0, 96);
  end
  v = vInitialized;
end
