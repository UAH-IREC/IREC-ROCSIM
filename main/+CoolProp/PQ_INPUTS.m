function v = PQ_INPUTS()
  persistent vInitialized;
  if isempty(vInitialized)
    vInitialized = CoolPropMATLAB_wrap(0, 98);
  end
  v = vInitialized;
end
