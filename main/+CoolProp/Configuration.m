classdef Configuration < SwigRef
  methods
    function self = Configuration(varargin)
      if nargin~=1 || ~ischar(varargin{1}) || ~strcmp(varargin{1},'_swigCreate')
        % How to get working on C side? Commented out, replaed by hack below
        %self.swigInd = CoolPropMATLAB_wrap(409, varargin{:});
        tmp = CoolPropMATLAB_wrap(409, varargin{:}); % FIXME
        self.swigInd = tmp.swigInd;
        tmp.swigInd = uint64(0);
      end
    end
    function delete(self)
      if self.swigInd
        CoolPropMATLAB_wrap(410, self);
        self.swigInd=uint64(0);
      end
    end
    function varargout = get_item(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(411, self, varargin{:});
    end
    function varargout = add_item(self,varargin)
      [varargout{1:nargout}] = CoolPropMATLAB_wrap(412, self, varargin{:});
    end
    function varargout = get_items(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(413, self, varargin{:});
    end
    function varargout = set_defaults(self,varargin)
      [varargout{1:nargout}] = CoolPropMATLAB_wrap(414, self, varargin{:});
    end
  end
  methods(Static)
  end
end
