function v = HENRYS_LAW_TO_GENERATE_VLE_GUESSES()
  persistent vInitialized;
  if isempty(vInitialized)
    vInitialized = CoolPropMATLAB_wrap(0, 143);
  end
  v = vInitialized;
end
