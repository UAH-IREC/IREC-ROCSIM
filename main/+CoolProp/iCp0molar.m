function v = iCp0molar()
  persistent vInitialized;
  if isempty(vInitialized)
    vInitialized = CoolPropMATLAB_wrap(0, 31);
  end
  v = vInitialized;
end
