function varargout = add_fluids_as_JSON(varargin)
  [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(326,varargin{:});
end
