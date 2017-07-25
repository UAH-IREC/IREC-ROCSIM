function v = HmassP_INPUTS()
  persistent vInitialized;
  if isempty(vInitialized)
    vInitialized = CoolPropMATLAB_wrap(0, 116);
  end
  v = vInitialized;
end
