function varargout = cair_sat(varargin)
  [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(432,varargin{:});
end
