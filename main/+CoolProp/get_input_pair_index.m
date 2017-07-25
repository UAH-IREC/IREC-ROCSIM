function varargout = get_input_pair_index(varargin)
  [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(155,varargin{:});
end
