function v = HmassSmass_INPUTS()
  persistent vInitialized;
  if isempty(vInitialized)
    vInitialized = CoolPropMATLAB_wrap(0, 122);
  end
  v = vInitialized;
end
