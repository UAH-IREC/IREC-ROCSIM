function v = iphase_not_imposed()
  persistent vInitialized;
  if isempty(vInitialized)
    vInitialized = CoolPropMATLAB_wrap(0, 84);
  end
  v = vInitialized;
end
