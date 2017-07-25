function v = iCvirial()
  persistent vInitialized;
  if isempty(vInitialized)
    vInitialized = CoolPropMATLAB_wrap(0, 59);
  end
  v = vInitialized;
end
