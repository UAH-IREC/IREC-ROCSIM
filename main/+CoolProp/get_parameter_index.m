function varargout = get_parameter_index(varargin)
  [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(146,varargin{:});
end
