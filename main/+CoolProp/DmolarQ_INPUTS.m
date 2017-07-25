function v = DmolarQ_INPUTS()
  persistent vInitialized;
  if isempty(vInitialized)
    vInitialized = CoolPropMATLAB_wrap(0, 103);
  end
  v = vInitialized;
end
