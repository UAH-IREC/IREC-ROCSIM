function v = HmolarP_INPUTS()
  persistent vInitialized;
  if isempty(vInitialized)
    vInitialized = CoolPropMATLAB_wrap(0, 117);
  end
  v = vInitialized;
end
