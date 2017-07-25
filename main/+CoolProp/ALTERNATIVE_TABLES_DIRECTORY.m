function v = ALTERNATIVE_TABLES_DIRECTORY()
  persistent vInitialized;
  if isempty(vInitialized)
    vInitialized = CoolPropMATLAB_wrap(0, 136);
  end
  v = vInitialized;
end
