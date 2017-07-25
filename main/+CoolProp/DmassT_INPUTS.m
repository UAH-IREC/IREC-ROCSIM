function v = DmassT_INPUTS()
  persistent vInitialized;
  if isempty(vInitialized)
    vInitialized = CoolPropMATLAB_wrap(0, 106);
  end
  v = vInitialized;
end
