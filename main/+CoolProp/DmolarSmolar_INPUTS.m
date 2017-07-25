function v = DmolarSmolar_INPUTS()
  persistent vInitialized;
  if isempty(vInitialized)
    vInitialized = CoolPropMATLAB_wrap(0, 129);
  end
  v = vInitialized;
end
