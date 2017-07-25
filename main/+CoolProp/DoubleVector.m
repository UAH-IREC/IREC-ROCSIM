classdef DoubleVector < SwigRef
  methods
    function varargout = pop(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(19, self, varargin{:});
    end
    function varargout = paren(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(20, self, varargin{:});
    end
    function varargout = paren_asgn(self,varargin)
      [varargout{1:nargout}] = CoolPropMATLAB_wrap(21, self, varargin{:});
    end
    function varargout = append(self,varargin)
      [varargout{1:nargout}] = CoolPropMATLAB_wrap(22, self, varargin{:});
    end
    function varargout = empty(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(23, self, varargin{:});
    end
    function varargout = size(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(24, self, varargin{:});
    end
    function varargout = clear(self,varargin)
      [varargout{1:nargout}] = CoolPropMATLAB_wrap(25, self, varargin{:});
    end
    function varargout = swap(self,varargin)
      [varargout{1:nargout}] = CoolPropMATLAB_wrap(26, self, varargin{:});
    end
    function varargout = get_allocator(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(27, self, varargin{:});
    end
    function varargout = begin(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(28, self, varargin{:});
    end
    function varargout = end(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(29, self, varargin{:});
    end
    function varargout = rbegin(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(30, self, varargin{:});
    end
    function varargout = rend(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(31, self, varargin{:});
    end
    function varargout = pop_back(self,varargin)
      [varargout{1:nargout}] = CoolPropMATLAB_wrap(32, self, varargin{:});
    end
    function varargout = erase(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(33, self, varargin{:});
    end
    function self = DoubleVector(varargin)
      if nargin~=1 || ~ischar(varargin{1}) || ~strcmp(varargin{1},'_swigCreate')
        % How to get working on C side? Commented out, replaed by hack below
        %self.swigInd = CoolPropMATLAB_wrap(34, varargin{:});
        tmp = CoolPropMATLAB_wrap(34, varargin{:}); % FIXME
        self.swigInd = tmp.swigInd;
        tmp.swigInd = uint64(0);
      end
    end
    function varargout = push_back(self,varargin)
      [varargout{1:nargout}] = CoolPropMATLAB_wrap(35, self, varargin{:});
    end
    function varargout = front(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(36, self, varargin{:});
    end
    function varargout = back(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(37, self, varargin{:});
    end
    function varargout = assign(self,varargin)
      [varargout{1:nargout}] = CoolPropMATLAB_wrap(38, self, varargin{:});
    end
    function varargout = resize(self,varargin)
      [varargout{1:nargout}] = CoolPropMATLAB_wrap(39, self, varargin{:});
    end
    function varargout = insert(self,varargin)
      [varargout{1:nargout}] = CoolPropMATLAB_wrap(40, self, varargin{:});
    end
    function varargout = reserve(self,varargin)
      [varargout{1:nargout}] = CoolPropMATLAB_wrap(41, self, varargin{:});
    end
    function varargout = capacity(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(42, self, varargin{:});
    end
    function delete(self)
      if self.swigInd
        CoolPropMATLAB_wrap(43, self);
        self.swigInd=uint64(0);
      end
    end
  end
  methods(Static)
  end
end
