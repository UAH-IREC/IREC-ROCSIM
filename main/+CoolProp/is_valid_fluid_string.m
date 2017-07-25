function varargout = is_valid_fluid_string(varargin)
  [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(325,varargin{:});
end
