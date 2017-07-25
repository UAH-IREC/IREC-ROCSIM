function v = ifundamental_derivative_of_gas_dynamics()
  persistent vInitialized;
  if isempty(vInitialized)
    vInitialized = CoolPropMATLAB_wrap(0, 51);
  end
  v = vInitialized;
end
