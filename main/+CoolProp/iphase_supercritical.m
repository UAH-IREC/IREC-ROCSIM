function v = iphase_supercritical()
  persistent vInitialized;
  if isempty(vInitialized)
    vInitialized = CoolPropMATLAB_wrap(0, 77);
  end
  v = vInitialized;
end
