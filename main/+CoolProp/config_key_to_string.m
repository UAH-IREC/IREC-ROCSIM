function varargout = config_key_to_string(varargin)
  [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(400,varargin{:});
end
