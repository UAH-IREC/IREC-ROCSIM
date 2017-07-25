function v = idipole_moment()
  persistent vInitialized;
  if isempty(vInitialized)
    vInitialized = CoolPropMATLAB_wrap(0, 21);
  end
  v = vInitialized;
end
