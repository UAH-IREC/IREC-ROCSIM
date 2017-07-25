function v = iCpmass()
  persistent vInitialized;
  if isempty(vInitialized)
    vInitialized = CoolPropMATLAB_wrap(0, 39);
  end
  v = vInitialized;
end
