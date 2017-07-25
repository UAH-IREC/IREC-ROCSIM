classdef MatlabSwigIterator < SwigRef
  methods
    function delete(self)
      if self.swigInd
        CoolPropMATLAB_wrap(3, self);
        self.swigInd=uint64(0);
      end
    end
    function varargout = value(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(4, self, varargin{:});
    end
    function varargout = incr(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(5, self, varargin{:});
    end
    function varargout = decr(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(6, self, varargin{:});
    end
    function varargout = distance(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(7, self, varargin{:});
    end
    function varargout = equal(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(8, self, varargin{:});
    end
    function varargout = copy(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(9, self, varargin{:});
    end
    function varargout = next(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(10, self, varargin{:});
    end
    function varargout = previous(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(11, self, varargin{:});
    end
    function varargout = advance(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(12, self, varargin{:});
    end
    function varargout = isequal(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(13, self, varargin{:});
    end
    function varargout = ne(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(14, self, varargin{:});
    end
    function varargout = TODOincr(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(15, self, varargin{:});
    end
    function varargout = TODOdecr(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(16, self, varargin{:});
    end
    function varargout = plus(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(17, self, varargin{:});
    end
    function varargout = minus(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(18, self, varargin{:});
    end
    function self = MatlabSwigIterator(varargin)
      if nargin~=1 || ~ischar(varargin{1}) || ~strcmp(varargin{1},'_swigCreate')
        error('No matching constructor');
      end
    end
  end
  methods(Static)
  end
end
