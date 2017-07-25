function varargout = get_config_bool(varargin)
  [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(415,varargin{:});
end
