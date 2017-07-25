function v = HmolarQ_INPUTS()
  persistent vInitialized;
  if isempty(vInitialized)
    vInitialized = CoolPropMATLAB_wrap(0, 101);
  end
  v = vInitialized;
end
