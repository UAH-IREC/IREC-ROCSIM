function v = R_U_CODATA()
  persistent vInitialized;
  if isempty(vInitialized)
    vInitialized = CoolPropMATLAB_wrap(0, 145);
  end
  v = vInitialized;
end
