function v = IFRAC_PURE()
  persistent vInitialized;
  if isempty(vInitialized)
    vInitialized = CoolPropMATLAB_wrap(0, 89);
  end
  v = vInitialized;
end
