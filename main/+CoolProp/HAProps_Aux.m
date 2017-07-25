function varargout = HAProps_Aux(varargin)
  [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(425,varargin{:});
end
