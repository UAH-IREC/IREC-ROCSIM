function varargout = HAProps(varargin)
  [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(424,varargin{:});
end
