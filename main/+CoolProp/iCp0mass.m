function v = iCp0mass()
  persistent vInitialized;
  if isempty(vInitialized)
    vInitialized = CoolPropMATLAB_wrap(0, 40);
  end
  v = vInitialized;
end
