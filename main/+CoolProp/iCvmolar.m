function v = iCvmolar()
  persistent vInitialized;
  if isempty(vInitialized)
    vInitialized = CoolPropMATLAB_wrap(0, 32);
  end
  v = vInitialized;
end
