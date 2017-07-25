function varargout = is_valid_first_derivative(varargin)
  [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(150,varargin{:});
end
