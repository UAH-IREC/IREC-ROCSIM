function v = HmassQ_INPUTS()
  persistent vInitialized;
  if isempty(vInitialized)
    vInitialized = CoolPropMATLAB_wrap(0, 102);
  end
  v = vInitialized;
end
